//
//  TEKeywordCell.swift
//  TheOne
//
//  Created by Maru on 16/6/30.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TEKeywordCell: UITableViewCell {
    
    let lable1: TEKeywordLable
    let lable2: TEKeywordLable
    let lable3: TEKeywordLable
    let lable4: TEKeywordLable
    let lable5: TEKeywordLable
    let bgImage: UIImageView

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        lable1 = TEKeywordLable()
        lable2 = TEKeywordLable()
        lable3 = TEKeywordLable()
        lable4 = TEKeywordLable()
        lable5 = TEKeywordLable()
        bgImage = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bgImage.image = UIImage(named: "GrossBorder")
        
        contentView.addSubview(bgImage)
        contentView.addSubview(lable1)
        contentView.addSubview(lable2)
        contentView.addSubview(lable3)
        contentView.addSubview(lable4)
        contentView.addSubview(lable5)
        
        constrain(bgImage) { (bgImage) in
            bgImage.edges == bgImage.superview!.edges
        }
        
        constrain(lable1, lable2, lable3, lable4, lable5) { (lable1, lable2, lable3, lable4, lable5) in
            
            lable1.width == lable1.superview!.width / 3
            lable1.height == lable1.superview!.height / 2
            lable1.left == lable1.superview!.left
            lable1.top == lable1.superview!.top
            
            lable2.width == lable1.width
            lable2.height == lable1.height
            lable2.top == lable1.top
            lable2.left == lable1.right
            
            lable3.width == lable1.width
            lable3.height == lable1.height
            lable3.left == lable2.right
            lable3.top == lable1.top
            
            lable4.width == lable4.superview!.width / 2
            lable4.height == lable1.height
            lable4.left == lable4.superview!.left
            lable4.top == lable1.bottom
            
            lable5.width == lable4.width
            lable5.height == lable4.height
            lable5.left == lable4.right
            lable4.top == lable5.top
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TEKeywordCell {
    
    // MARK: - Public Method
    func configWithKeyword(key: String) {
        let keywords = key.componentsSeparatedByString(";")
        for (index,content) in keywords.enumerate() {
            (contentView.subviews[index+1] as! TEKeywordLable).text = content
        }
    }
}

class TEKeywordLable: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.systemFontOfSize(12)
        textColor = TEConfigure.author_Highlight
        textAlignment = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}