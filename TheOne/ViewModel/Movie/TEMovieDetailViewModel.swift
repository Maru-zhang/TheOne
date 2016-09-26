//
//  TEMovieDetailViewModel.swift
//  TheOne
//
//  Created by Maru on 16/6/29.
//  Copyright © 2016年 Maru. All rights reserved.
//

import ReactiveSwift
import Result

class TEMovieDetailViewModel {
    
    /// 电影名
    let title: Property<String>
    /// 电影详情
    let detail = MutableProperty<TEMovieDetail?>(nil)
    /// 电影故事
    let story  = MutableProperty<[TEMovieStory]>([TEMovieStory]())
    /// 电影评论
    let comments = MutableProperty<[TEComment]>([TEComment]())
    
    /********************** 以上动态属性 ********************************/
    
    let commentsSignal : Signal<[TEComment],NoError>
    let commentObserver: Observer<[TEComment],NoError>
    
    
    /********************** 以上信号相关 *********************************/
    /// 电影ID
    private let movieID: Int
    /// 分页标记
    private var sentry = 0
    
    init(movie: TEMovieCardModel) {
        
        self.movieID     = (movie.id?.toInt())!
        self.title       = ConstantProperty<String>.init(movie.title!)
        
        let (commentsSignal,commentObserver) = Signal<[TEComment],NoError>.pipe()
        self.commentsSignal = commentsSignal
        self.commentObserver = commentObserver
        
        
        fetchMovieDetail()
        fetchMovieStory()
        fetchCommentList()
        
    }
    
}

extension TEMovieDetailViewModel {
    
    // MARK: - Public Method
    func fetchCommentList() {
        
        TENetService.apiGetSpecifyMovieCommentListwithResultSignalProducer(movieID, page: sentry) { (signal) in
            signal
                .filter({ (comments) -> Bool in
                    if comments.count == 0 {
                        self.commentObserver.sendCompleted()
                        return false
                    }else {
                        return true
                    }
                })
                .startWithNext({ (comments) in
                    self.comments.value.appendContentsOf(comments)
                    if self.sentry != 0 {
                        self.commentObserver.sendNext(comments)
                    }
                    self.sentry = (comments.last?.id?.toInt())!
                })
        }
    }
}

extension TEMovieDetailViewModel {
    
    // MARK: - Private Method
    private func fetchMovieStory() {
        
        TENetService.apiGetSpecifyMovieStoryWithResultSignalProducer(movieID) { (signal) in
            signal
                .startWithNext({ [unowned self] (val) in
                    self.story.value.appendContentsOf(val)
                    })
        }
    }
    
    private func fetchMovieDetail() {
        
        TENetService.apiGetSpecifyMovieDetailWithResultSignalProducer(movieID) { (signal) in
            signal
                .startWithNext({ [unowned self] (val) in
                    self.detail.value = val
                    })
        }
    }

}
