//
//  TERankViewModel.swift
//  TheOne
//
//  Created by master on 16/7/21.
//  Copyright © 2016年 Maru. All rights reserved.
//

import ReactiveCocoa
import Result


class TERankViewModel {
    
    let carousel: TECarousel
    let title: ConstantProperty<String>
    let recommends = MutableProperty<[TERecommend]>([TERecommend]())
    
    init(model: TECarousel) {
        
        carousel = model
        title = ConstantProperty<String>(carousel.title!)
    }
    
}

extension TERankViewModel {
    
    func fetchRemoteData() {
        
        TENetService.apiGetArticleRankContent((carousel.id?.toInt())!) { (signal) in
            
            signal.startWithNext({ [unowned self] (recommends) in
                self.recommends.value = recommends
            })
        }
    }
}

