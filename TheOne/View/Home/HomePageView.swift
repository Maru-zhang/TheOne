
//
//  HomePageView.swift
//  TheOne
//
//  Created by Maru on 16/6/2.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class HomePageView: TECardPageView {
    
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
        content.lineBreakMode = .ByCharWrapping
        content.numberOfLines = 0
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        addSubview(imageView)
        addSubview(VOL)
        addSubview(author)
        addSubview(markTime)
        addSubview(content)
        
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
            
            content.top == VOL.bottom + 8
            content.left == imageView.left + 2
            content.right == imageView.right
            
            markTime.right == imageView.right - 6
            markTime.bottom == (imageView.superview?.bottom)! - 4
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}

extension HomePageView {
    
    // MARK: - Public Method
    func configWithEntity(entity: TEPaperModel) {
        author.text = entity.hp_author
        content.text = entity.hp_content
        VOL.text = entity.hp_title
        imageView.kf_setImageWithURL(NSURL(string: entity.hp_img_url!)!)
        markTime.text = (entity.hp_makettime! as NSString).substringToIndex(10)
    }
}
