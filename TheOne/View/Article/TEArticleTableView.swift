//
//  TEArticleTableView.swift
//  TheOne
//
//  Created by Maru on 16/6/5.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEArticleTableView: UITableView {

    var shadowLayer: CALayer!
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        super.drawRect(rect)
        
        backgroundColor = UIColor.clearColor()
        
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
        
//        layer.insertSublayer(shadowLayer, atIndex: 0)
    }
 

}
