//
//  TECardPageView.swift
//  TheOne
//
//  Created by Maru on 16/5/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TECardPageView: UIView {
    
    var shadowLayer: CALayer!


    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        // Firsr, remove all of this layer's sublayer
        if shadowLayer != nil {
            shadowLayer.removeFromSuperlayer()
        }
        
        shadowLayer = CALayer()
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.frame = rect
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowRadius = 3.0
        shadowLayer.cornerRadius = 5.0
        
        layer.insertSublayer(shadowLayer, at: 0)
        
        
    }
}

