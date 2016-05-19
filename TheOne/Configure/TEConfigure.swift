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
    /// 电影评分列表API
    static let API_MOVIE = "http://v3.wufazhuce.com:8000/api/movie/list/0"
    
    
    
}

extension TEConfigure {
    
    // MARK: - Color Configure
    /// Tabbar普通颜色
    static let tabbarFontColor = UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1)
    /// Tabbar普通颜色
    static let tabbarFontColor_Selected = UIColor(red: 0.53, green: 0.68, blue: 0.85, alpha: 1)
    /// 电影分数颜色
    static let movie_score_color = UIColor(red: 0.91, green: 0.36, blue: 0.38, alpha: 1)
}


extension TEConfigure {
    
    // MARK: - Font
    /// 电影分数字体
    static let movie_score_font = UIFont(name: "BradleyHandITCTT-Bold", size: 50)
    
    // MARK: - Hodler
    static let imageHolder = UIImage()
}
