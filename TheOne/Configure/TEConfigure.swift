//
//  TEConfigure.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import UIKit



struct TEConfigure {
    
    // MARK: - API

    
}

extension TEConfigure {
    
    // MARK: - Color Configure
    
    /// 控制器容器颜色
    static let containnerBG = UIColor(r: 249, g: 253, b: 255)
    /// 刷新控件的颜色
    static let pullRefreshColor = UIColor(red: 0.58, green: 0.77, blue: 0.97, alpha: 1)
    /// 作者高亮颜色
    static let author_Highlight = UIColor(red: 0.69, green: 0.77, blue: 0.86, alpha: 1)
    
    /// Navgation 背景颜色
    static let navBarTintColor = UIColor.whiteColor()
    /// Navgation 返回颜色
    static let navBackColor = UIColor(r: 198, g: 198, b: 198)
    /// Navgation 正文颜色
    static let navTextColor = UIColor(r: 78, g: 93, b: 105)
    
    
    /// 首页卡片淡化文字颜色
    static let card_Fade_Color = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
    /// 首页正文文字颜色
    static let card_Content_Color = UIColor(red: 0.42, green: 0.42, blue: 0.42, alpha: 1)
    
    
    /// Tabbar普通颜色
    static let tabbarFontColor = UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1)
    /// Tabbar普通颜色
    static let tabbarFontColor_Selected = UIColor(red: 0.53, green: 0.68, blue: 0.85, alpha: 1)
    
    /// 电影分数颜色
    static let movie_score_color = UIColor(red: 0.91, green: 0.36, blue: 0.38, alpha: 1)
    /// 电影即将上映颜色
    static let movie_beon_color = UIColor.lightGrayColor()
    
    /// 分割线的颜色
    static let separator_color = UIColor(white: 229 / 255.0, alpha: 1)
}


extension TEConfigure {
    
    // MARK: - Font
    
    /// 首页淡化文字字体
    static let card_fade_font = UIFont.systemFontOfSize(10)
    /// 首页时间戳字体
    static let card_time_font = UIFont.systemFontOfSize(12)
    /// 首页正文文字字体
    static let card_content_font = UIFont.systemFontOfSize(13)
    
    /// 电影分数字体
    static let movie_score_font = UIFont(name: "BradleyHandITCTT-Bold", size: 50)
    /// 即将上映字体
    static let movie_beon_font = UIFont.systemFontOfSize(14)
    
    // MARK: - Hodler
    static let imageHolder = UIImage()
}

extension TEConfigure {
    
    // MARK: - UI module
    static func musicHeaderViewForSection(title: String) -> UILabel {
        let lable = UILabel()
        lable.text = "  \(title)"
        lable.font = UIFont.systemFontOfSize(13)
        lable.textColor = UIColor.darkGrayColor()
        lable.backgroundColor = UIColor.groupTableViewBackgroundColor()
        return lable
    }
    
    static func cleanView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
}

extension TEConfigure {
    
    // MARK: - Debug
    static let mar_domain = "com.alloc.maru"
}

