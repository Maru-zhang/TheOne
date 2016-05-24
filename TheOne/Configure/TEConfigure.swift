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
    
    /// Navgation 背景颜色
    static let navBarTintColor = UIColor.whiteColor()
    /// Navgation 返回颜色
    static let navBackColor = UIColor(r: 198, g: 198, b: 198)
    /// Navgation 正文颜色
    static let navTextColor = UIColor(r: 78, g: 93, b: 105)
    
    
    /// Tabbar普通颜色
    static let tabbarFontColor = UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1)
    /// Tabbar普通颜色
    static let tabbarFontColor_Selected = UIColor(red: 0.53, green: 0.68, blue: 0.85, alpha: 1)
    
    /// 电影分数颜色
    static let movie_score_color = UIColor(red: 0.91, green: 0.36, blue: 0.38, alpha: 1)
    /// 电影即将上映颜色
    static let movie_beon_color = UIColor.lightGrayColor()
}


extension TEConfigure {
    
    // MARK: - Font
    /// 电影分数字体
    static let movie_score_font = UIFont(name: "BradleyHandITCTT-Bold", size: 50)
    /// 即将上映字体
    static let movie_beon_font = UIFont.systemFontOfSize(14)
    
    // MARK: - Hodler
    static let imageHolder = UIImage()
}

extension TEConfigure {
    
    // MARK: - Debug
    static let mar_domain = "com.alloc.maru"
}
