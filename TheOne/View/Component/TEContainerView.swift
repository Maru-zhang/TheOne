//
//  TEContainerView.swift
//  TheOne
//
//  Created by Maru on 16/6/29.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEContainerView: UIScrollView {

    var shadowLayer: CALayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        alwaysBounceVertical = true
        alwaysBounceVertical = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        
        // Firsr, remove all of this layer's sublayer
        if shadowLayer != nil {
            shadowLayer.removeFromSuperlayer()
        }
        
        shadowLayer = CALayer()
        shadowLayer.backgroundColor = UIColor.whiteColor().CGColor
        shadowLayer.frame = rect
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowColor = UIColor.blackColor().CGColor
        shadowLayer.shadowOffset = CGSizeMake(0, 0)
        shadowLayer.shadowRadius = 3.0
        shadowLayer.cornerRadius = 5.0
        
        layer.insertSublayer(shadowLayer, atIndex: 0)
        
        
    }
}
