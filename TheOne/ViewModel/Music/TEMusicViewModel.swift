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
    
    let fetchComplete: Signal<Void,NoError>
    
    let comments = MutableProperty<[TEComment]>([TEComment]())
    
    private var sentry = 0
    private let musicID: NSInteger
    private let fetchObserver: Observer<Void,NoError>
    
    init(musicID: NSInteger) {
        
        self.musicID = musicID
        
        var (fetchComplete,fetchobserver) = Signal<Void,NoError>.pipe()
        self.fetchComplete = fetchComplete
        self.fetchObserver = fetchobserver
        
    }
    

}

extension TEMusicViewModel {
    
    // MARK: - Public Method
    
    /*
     如果为true那么是重新加载数据，如果是false那么就添加评论数据
     */
    func fetchData(reset: Bool) {
        
        if reset == true {
            sentry = 0
        }
        
        TENetService.apiGetMusicCommentListBy(musicID, page: sentry) { (sigalProductor) in
            sigalProductor.startWithNext({ [unowned self] (comments, count) in
                self.fetchObserver.sendNext()
            })
        }
    }
}
