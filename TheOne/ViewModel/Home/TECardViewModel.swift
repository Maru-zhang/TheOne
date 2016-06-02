
//
//  TECardViewModel.swift
//  TheOne
//
//  Created by Maru on 16/5/31.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class TECardViewModel {
    
    let refreshSignal: SignalProducer<Void,NoError>

    var source: [TEPaperModel] = []
    
    init() {
        
        let (refreshSignal,_) = SignalProducer<Void,NoError>.buffer(0)
        self.refreshSignal = refreshSignal
    }
}

extension TECardViewModel {
    
    // MARK: - Public Method
    func fetchLatestData(action: ()->()) {
        
        TENetService.apiGetLatestOneStuff { (signalProducter) in
            signalProducter.startWithNext({ [unowned self] (models) in
                self.source = models
                action()
            })
        }
    }
}
