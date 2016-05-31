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
    /// 首页图片
    let imageView: UIImageView!
    /// 编号
    let VOL: UILabel!
    /// 作者
    let author: UILabel!
    /// 标记时间
    let markTime: UILabel!
    /// 内容
    let content: UILabel!
    
    override init(frame: CGRect) {
        
        imageView = UIImageView()
        VOL       = UILabel()
        author    = UILabel()
        markTime  = UILabel()
        content   = UILabel()
        
        VOL.textAlignment = .Left
        VOL.textColor = TEConfigure.card_Fade_Color
        VOL.font = TEConfigure.card_fade_font
        
        author.textAlignment = .Right
        author.textColor = TEConfigure.card_Fade_Color
        author.font = TEConfigure.card_fade_font
        
        markTime.textAlignment = .Right
        markTime.textColor = TEConfigure.card_Fade_Color
        markTime.font = TEConfigure.card_time_font
        
        content.textColor = TEConfigure.card_Content_Color
        content.font = TEConfigure.card_content_font
        content.textAlignment = .Left
        content.numberOfLines = 0
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()

        addSubview(imageView)
        addSubview(VOL)
        addSubview(author)
        addSubview(markTime)
        addSubview(content)
        
        // temp 
        imageView.kf_setImageWithURL(NSURL(string: "http://image.wufazhuce.com/FiSIgDStYtE_skZ4bAsCf_kik8cl")!)
        VOL.text = "VOL.1330"
        author.text = "maru 作品"
        markTime.text = "Sat28 May.2016"
        content.text = "人有一种可怕的欲望，想窥探别人内心，传递自己的恐慌，为别人同自己一样悲伤恐惧而感到安慰，想要操纵别人，在得知别人受到自己影响时的自鸣得意。这些都是难以启齿的，我们心中的恶魔。 by 帕慕克"
        
        // Custom Layout
        constrain(imageView, VOL, author, markTime, content) { (imageView, VOL, author, markTime, content) in
            
            imageView.left == ((imageView.superview)?.left)! + 6
            imageView.right == (imageView.superview?.right)! - 6
            imageView.top == (imageView.superview?.top)! + 6
            imageView.height == 300
            
            VOL.left == (VOL.superview?.left)! + 6
            VOL.top == imageView.bottom + 4
            
            author.right == (imageView.superview?.right)! - 6
            author.top == imageView.bottom + 4
            
            markTime.right == imageView.right - 6
            markTime.bottom == (markTime.superview?.bottom)! - 5
            
            content.top == VOL.bottom + 8
            content.left == imageView.left + 2
            content.right == imageView.right
            
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        shadowLayer = CALayer()
        shadowLayer.backgroundColor = UIColor.whiteColor().CGColor
        shadowLayer.frame = rect
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowColor = UIColor.blackColor().CGColor
        shadowLayer.shadowOffset = CGSizeMake(0, 0)
        shadowLayer.shadowRadius = 3.0
        shadowLayer.cornerRadius = 5.0
        
        layer.insertSublayer(shadowLayer, below: imageView.layer)


    }
}
