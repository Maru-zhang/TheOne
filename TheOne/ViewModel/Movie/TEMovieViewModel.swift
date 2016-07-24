//
//  TEMovieViewModel.swift
//  TheOne
//
//  Created by Maru on 16/3/19.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import Kingfisher
import ReactiveCocoa
import Result

class TEMovieViewModel {
    
    let active = MutableProperty(false)
    let refreshSignal: SignalProducer<Void,NoError>
    let loadMoreSignal: Signal<Void,NoError>
    var page: Int = 0
    
    
    let loadMoreObserver: Observer<Void,NoError>
    private let refreshObserver: Observer<Void, NoError>

    // MARK: - DataSources
    private var pageIndex: Int
    private var movies: [TEMovieCardModel]
    
    
    // MARK: - Initalizer
    init() {
        self.pageIndex = 0
        self.movies = [TEMovieCardModel]()
        
        let (refreshSignal, refreshObserver) = SignalProducer<Void, NoError>.buffer(0)
        self.refreshObserver = refreshObserver
        self.refreshSignal = refreshSignal
        
        let (loadMoreSignal,loadMoreObserver) = Signal<Void, NoError>.pipe()
        self.loadMoreSignal = loadMoreSignal
        self.loadMoreObserver = loadMoreObserver
        

        active.producer
            .filter({ $0 })
            .map({_ in ()})
            .start(refreshObserver)
    }
    
    
}

extension TEMovieViewModel {
    
    typealias CellType = TEMovieCardCell
    typealias FailureType = NSError
    
    // MARK: - Data Source Method
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfMoviesInSection(section: Int) -> Int {
        return movies.count
    }

    func scoreNumberAtIndexPath(indexPath: NSIndexPath) -> String? {
        return movies[indexPath.row].score
    }
    
    func coverImageURLAtIndexPath(indexPath: NSIndexPath) -> NSURL {
        return NSURL(string: movies[indexPath.row].cover!)!
    }
    
    func heightForCellAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return 190;
    }
    
    func entityMappingIndexPath(indexPath: NSIndexPath) -> TEMovieCardModel {
        return movies[indexPath.row]
    }
    
    // MARK: - Fetch Command
    
    /**
     获取更多的数据，即包括分页拉取数据
     
     - parameter success:	成功回调
     - parameter failure:	失败回调
     */
    func fetchRemoteDataWithCallBack(success: () -> Void, failure: (FailureType) -> Void) {
        
        
        TENetService
            .apiGetSpecifyMoiveListwithResultSignalProducer(page) { [unowned self] (signalProducer) in
            signalProducer.startWithNext({ (entitys) in
                guard !entitys.isEmpty else {
                    failure(NSError(domain: TEConfigure.mar_domain, code: 0, userInfo: nil))
                    return
                }
                self.movies.appendContentsOf(entitys)
                self.page = (entitys.last?.id?.toInt())!
                success()
            })
        }
        
    }
    
    /**
     获取最新的数据，即下拉刷新所获取的数据
     
     - parameter success:	成功回调
     - parameter failure:	失败回调
     */
    func fetchRemoteRefreshDataWithCallBack(success: () -> Void, failure: (FailureType) -> Void) {
        
        page = 0
        
        TENetService
            .apiGetSpecifyMoiveListwithResultSignalProducer(page) { [unowned self] (signalProducer) in
                signalProducer.startWithNext({ (entitys) in
                    self.movies = entitys
                    self.page = (entitys.last?.id?.toInt())!
                    success()
                })
        }
    }
}