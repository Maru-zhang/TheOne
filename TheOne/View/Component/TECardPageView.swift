//
//  TECardPageView.swift
//  TheOne
//
//  Created by Maru on 16/5/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TECardPageView: UIView {
    
    var containner: UIView!
    var margin: UIEdgeInsets!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.redColor()
        margin = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        containner = UIView(frame: CGRectMake(frame.origin.x + margin.left, frame.origin.y - margin.top, frame.width - margin.left - margin.right, frame.height - margin.top - margin.bottom))
        containner.layer.borderColor = UIColor.grayColor().CGColor
        containner.layer.shadowOffset = CGSizeMake(10, 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        
    }
}
