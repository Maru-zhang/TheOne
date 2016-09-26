//
//  TERankViewModel.swift
//  TheOne
//
//  Created by master on 16/7/21.
//  Copyright © 2016年 Maru. All rights reserved.
//

import ReactiveSwift
import Result


class TERankViewModel {
    
    let carousel: TECarousel
    let title: Property<String>
    let bottom: Property<String>
    let recommends = MutableProperty<[TERecommend]>([TERecommend]())
    let refresh: Observer<Void,NoError>
    let refreshSignal: SignalProducer<Void,NoError>
    
    init(model: TECarousel) {
        
        carousel = model
//        title = Property<String>.init(carousel.title!)
//        bottom = Property<String>.init(carousel.bottom_text!)
//        let (refreshS,refreshObserver) = SignalProducer<Void,NoError>.buffer(0)
//        refresh = refreshObserver
//        refreshSignal = refreshS

    }
    
}

extension TERankViewModel {
    
    func fetchRemoteData() {
        
//        TENetService.apiGetArticleRankContent((carousel.id?.toInt())!) { (signal) in
//            
//            signal.startWithNext({ [unowned self] (recommends) in
//                self.recommends.swap(recommends)
//                self.refresh.sendNext()
//            })
//        }
    }
}

