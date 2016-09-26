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
        line_l.bounds = CGRect(x: 0,y: 0,width: 1,height: 27)
        line_l.center = CGPoint(x:frame.width / 3,y: frame.height / 2)
        line_r.bounds = CGRect(x: 0,y: 0,width: 1,height: 27)
        line_r.center = CGPoint(x: frame.width * 0.66,y: frame.height / 2)
        let width = self.frame.width / CGFloat(3)
        for (index,btn) in lineButtons.enumerated() {
            btn.frame = CGRect(x: width * CGFloat(index),y: 0,width: width,height: frame.height)
        }
        super.layoutSubviews()
        
    }

    
    private func setupView() {
        
        for index in 0...2 {
            let btn = TELineButton()
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            if index == 0 {
                btn.setImage(UIImage.init(named: "like_default"), for: .normal)
                btn.setImage(UIImage.init(named: "like_selected"), for: .selected)
            }else if index == 1 {
                btn.setImage(UIImage.init(named: "toolBarComment"), for: .normal)
            }else {
                btn.setImage(UIImage.init(named: "shareImage"), for: .normal)
            }
            
            addSubview(btn)
            lineButtons.append(btn)
        }

    }

}

class TELineButton: UIButton {
    
    override func contentRect(forBounds bounds: CGRect) -> CGRect {
        return bounds
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: contentRect.width / 2 - contentRect.height, y: 0, width: contentRect.height, height: contentRect.height)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: contentRect.width / 2, y: 0, width: contentRect.height,height: contentRect.height)
    }
}
