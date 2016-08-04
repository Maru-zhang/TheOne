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

    let title: ConstantProperty<String>
    
    let carousel: TECarousel
    
    init(model: TECarousel) {
        
        carousel = model
        title = ConstantProperty<String>(carousel.title!)
    }
    
}
