
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
    
    let active = MutableProperty(false)
    let refreshSignal: SignalProducer<Void,NoError>
    let refreshObserver: Observer<Void,NoError>
    let cards = MutableProperty<[TEPaperModel]>([TEPaperModel]())
    
    init() {
        
        let (refreshSignal, refreshObserver) = SignalProducer<Void,NoError>.buffer(0)
        self.refreshSignal = refreshSignal
        self.refreshObserver = refreshObserver
        
        active.producer
            .filter({ $0 })
            .map({_ in ()})
            .start(refreshObserver)
        
        refreshSignal.startWithNext { [unowned self] () in
            TENetService.apiGetLatestOneStuff { (signalProducter) in
                signalProducter.startWithNext({ [unowned self] (models) in
                    self.cards.value = models
                    })
            }
        }
        
        
        
        
    }
}

extension TECardViewModel {
    

}
