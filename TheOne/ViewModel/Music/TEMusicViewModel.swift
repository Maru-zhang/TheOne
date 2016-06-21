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
    
    //******************* 以上索引相关 *********************************
    
    /// 详细内容
    let detail   = MutableProperty<TEMusicDetail?>(nil)
    /// 相关音乐
    let relates  = MutableProperty<[TEMusic_Related]>([TEMusic_Related]())
    /// 评论数据源
    let comments = MutableProperty<[TEComment]>([TEComment]())
    
    /// 当前页的音乐ID
    let currentMusicID = MutableProperty<String>("0")
    
    // ****************** 以上当前模型相关 ******************************
    
    let commentsSignal : Signal<[TEComment],NoError>
    let commentObserver: Observer<[TEComment],NoError>
    
    /// 分页标记
    private var sentry = 0
    let listReadyObserver: Observer<Void,NoError>
    private let fetchObserver: Observer<Void,NoError>
    
    
    init() {
        
        let (fetchComplete,fetchobserver) = Signal<Void,NoError>.pipe()
        self.fetchComplete = fetchComplete
        self.fetchObserver = fetchobserver
        
        let (listComplete,listObserver) = Signal<Void,NoError>.pipe()
        self.listReady = listComplete
        self.listReadyObserver = listObserver
        
        let  (commentsSignal,commentObserver) = Signal<[TEComment],NoError>.pipe()
        self.comments <~ commentsSignal
        self.commentsSignal = commentsSignal
        self.commentObserver = commentObserver
        
        orders.producer
            .filter({ (list) -> Bool in
                return list.count != 0
            })
            .startWithNext { [unowned self] (list) in
            self.currentMusicID.value = list.first!
        }
        
        currentMusicID.producer.startWithNext { [unowned self] (id) in
            self.fetchCurrentItemData()
        }
        
    }
    

}

extension TEMusicViewModel {
    
    // MARK: - Public Method
    
    func fetchIDList() {
        
        TENetService.apiGetMusicList(0) { (signal) in
            signal.startWithNext({ [unowned self] (lists) in
                self.orders.value = lists
            })
        }
    }
    
    /**
     获取音乐的所有信息，详细故事、相关音乐以及评论
     */
    func fetchCurrentItemData() {
        
        TENetService.apiGetMusicDetailByID(currentMusicID.value.toInt()!) { (signal) in
            signal.startWithNext({ [unowned self] (details) in
                self.detail.value  = details
            })
        }
        
        TENetService.apiGetMusicRelatedList(currentMusicID.value.toInt()!) { (signal) in
            signal.startWithNext({ [unowned self] (relates) in
                self.relates.value = relates
            })
        }
        
        fetchCurrentComment()

    }

    /*
     如果为true那么是重新加载数据，如果是false那么就添加评论数据
     */
    func fetchCurrentComment() {
        
        TENetService.apiGetMusicCommentListBy(currentMusicID.value.toInt()!, page: sentry) { [unowned self] (sigalProductor) in
            
            sigalProductor
                .filter({ (comments, count) -> Bool in
                    return comments.count != 0 || self.comments.value.count != 0
                })
                .startWithNext({ (comments, count) in
                    if self.sentry == 0 { self.comments.value.removeAll() }
                    if comments.count == 0 {
                        self.commentObserver.sendCompleted()
                    }else {
                        self.comments.value.appendContentsOf(comments)
                        self.sentry = (comments.last?.id?.toInt())!
                    }
                })
        }
        
    }
    
    
    /**
     翻页到一个新的页面
     
     - parameter page:	页码
     */
    func pageToIndex(page: Int) {
        sentry = 0
        currentMusicID.value = orders.value[page]
    }
    
    
}
