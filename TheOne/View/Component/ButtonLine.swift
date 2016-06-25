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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
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
