//
//  TEArticleViewModel.swift
//  TheOne
//
//  Created by Maru on 16/6/6.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class TEArticleViewModel {
    
    let refreshComplete: SignalProducer<Void,NoError>
    let refreshObserver: Observer<Void,NoError>

    let essays  = MutableProperty<[TEEssay]>([TEEssay]())
    let serials = MutableProperty<[TESerial]>([TESerial]())
    let issue   = MutableProperty<[TEIssue]>([TEIssue]())
    
    init() {
        
        let (refreshSignal,refreshObserver) = SignalProducer<Void,NoError>.buffer(0)
        self.refreshComplete = refreshSignal
        self.refreshObserver = refreshObserver
        
    }
    
    func fetchLastestData() {
        
        TENetService.apiGetArticleIndex { [unowned self] (resultSignal) in
            resultSignal.startWithNext({ (essay, serial, issue) in
                self.essays.value = essay
                self.serials.value = serial
                self.issue.value = issue
                self.refreshObserver.sendNext()
            })
        }
    }
    
}
