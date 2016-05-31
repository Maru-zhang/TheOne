//
//  TEPageableView.swift
//  TheOne
//
//  Created by Maru on 16/5/31.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class TEPageableView: UIScrollView {
    
//    let indexSignal: SignalProducer<Int,NoError>

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.pagingEnabled = true
        self.bounces = true
        self.contentSize = CGSizeMake(frame.width * 3, frame.height + 1)
        self.backgroundColor = UIColor.clearColor()
        self.showsVerticalScrollIndicator = true
        self.showsHorizontalScrollIndicator = true
        self.directionalLockEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TEPageableView {
    
}
