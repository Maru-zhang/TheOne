//
//  TEMusicViewModel.swift
//  TheOne
//
//  Created by Maru on 16/6/16.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class TEMusicViewModel {
    
    let listReady: Signal<Void,NoError>
    let fetchComplete: Signal<Void,NoError>
    
    /// MUSICID列表
    let orders   = MutableProperty<[String]>([String]())
    
    /// 评论数据源
    let comments = MutableProperty<[TEComment]>([TEComment]())
    
    /// 分页标记
    private var sentry = 0
    private let musicID: NSInteger = 0
    private let listReadyObserver: Observer<Void,NoError>
    private let fetchObserver: Observer<Void,NoError>
    
    init() {
        
        let (fetchComplete,fetchobserver) = Signal<Void,NoError>.pipe()
        self.fetchComplete = fetchComplete
        self.fetchObserver = fetchobserver
        
        let (listComplete,listObserver) = Signal<Void,NoError>.pipe()
        self.listReady = listComplete
        self.listReadyObserver = listObserver
        
    }
    

}

extension TEMusicViewModel {
    
    // MARK: - Public Method
    
    func fetchIDList() {
        
        TENetService.apiGetMusicList(0) { (signal) in
            signal.startWithNext({ [unowned self] (lists) in
                self.orders.value = lists
                self.listReadyObserver.sendNext()
            })
        }
    }

    /*
     如果为true那么是重新加载数据，如果是false那么就添加评论数据
     */
    func fetchCurrentItemData() {
        
        TENetService.apiGetMusicCommentListBy(musicID, page: sentry) { [unowned self] (sigalProductor) in
            sigalProductor
                .startWithNext({ (comments, count) in
                    self.fetchObserver.sendNext()
                })
        }
    }
}
