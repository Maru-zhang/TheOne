//
//  ButtonLine.swift
//  TheOne
//
//  Created by Maru on 16/6/25.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class ButtonLine: UIView {
    
    var lineButtons: [TELineButton] = []
    var line_l: UIImageView
    var line_r: UIImageView

    override init(frame: CGRect) {
        line_l = UIImageView(image: UIImage.init(named: "toolBarLine"))
        line_r = UIImageView(image: UIImage.init(named: "toolBarLine"))
        super.init(frame: frame)
        addSubview(line_l)
        addSubview(line_r)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        line_l.bounds = CGRectMake(0, 0, 1, 27)
        line_l.center = CGPointMake(frame.width / 3, frame.height / 2)
        line_r.bounds = CGRectMake(0, 0, 1, 27)
        line_r.center = CGPointMake(frame.width * 0.66, frame.height / 2)
        let width = self.frame.width / CGFloat(3)
        for (index,btn) in lineButtons.enumerate() {
            btn.frame = CGRectMake(width * CGFloat(index), 0, width, frame.height)
        }
        super.layoutSubviews()
        
    }

    
    private func setupView() {
        
        for index in 0...2 {
            let btn = TELineButton()
            btn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(12)
            if index == 0 {
                btn.setImage(UIImage.init(named: "like_default"), forState: .Normal)
                btn.setImage(UIImage.init(named: "like_selected"), forState: .Selected)
            }else if index == 1 {
                btn.setImage(UIImage.init(named: "toolBarComment"), forState: .Normal)
            }else {
                btn.setImage(UIImage.init(named: "shareImage"), forState: .Normal)
            }
            
            addSubview(btn)
            lineButtons.append(btn)
        }

    }

}

class TELineButton: UIButton {
    
    override func contentRectForBounds(bounds: CGRect) -> CGRect {
        return bounds
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(contentRect.width / 2 - contentRect.height, 0, contentRect.height, contentRect.height)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(contentRect.width / 2, 0, contentRect.height, contentRect.height)
    }
}
