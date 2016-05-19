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
    let refreshSignal: ReactiveCocoa.SignalProducer<Void,NoError>
    var page: Int = 0
    
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

        // Trigger refresh when view becomes active
        active.producer
            .filter({ $0 })
            .map({_ in ()})
            .start(refreshObserver)
    }
    
    
}

extension TEMovieViewModel: TETableModelType {
    
    typealias CellType = TEMovieCardCell
    typealias FailureType = NSError
    
    // MARK: - Data Source Method
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfMoviesInSection(section: Int) -> Int {
        return movies.count
    }
    
    func updateCell(cell: CellType, index: NSIndexPath) {
        cell.scorlLable.text = movies[index.row].score
        cell.coverImage.kf_setImageWithURL(NSURL(string: movies[index.row].cover!)!)
    }
    
    func cellForHeightAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return 190;
    }
    
    // MARK: - Fetch Command
    
    /**
     获取更多的数据，即包括分页拉取数据
     
     - parameter success:	成功回调
     - parameter failure:	失败回调
     */
    func fetchRemoteDataWithCallBack(success: () -> Void, failure: (FailureType) -> Void) {
        
        page += 1
        
        TENetService
            .apiGetSpecifyMoiveListwithResultSignalProducer(page) { [unowned self] (signalProducer) in
            signalProducer.startWithNext({ (entitys) in
                self.movies = entitys
                success()
            })
        }
        
    }
    
    func fetchRemoteRefreshDataWithCallBack(success: () -> Void, failure: (FailureType) -> Void) {
        
        page = 0
        
        TENetService
            .apiGetSpecifyMoiveListwithResultSignalProducer(page) { [unowned self] (signalProducer) in
                signalProducer.startWithNext({ (entitys) in
                    self.movies = entitys
                    success()
                })
        }
    }
}