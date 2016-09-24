//
//  TEMovieCardModel.swift
//  TheOne
//
//  Created by Maru on 16/3/15.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import ObjectMapper

struct TEMovieCardModel: Mappable {
    /// ID
    var id: String?
    /// 标题
    var title: String?
    var verse: String?
    var verse_en: String?
    /// 分数
    var score: String?
    /// 更新时间
    var revisedscore: String?
    var releasetime: String?
    var scoretime: String?
    /// 封面图片URL
    var cover: String?
    var servertime: String?
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id           <- map["id"]
        title        <- map["title"]
        verse        <- map["verse"]
        verse_en     <- map["verse_en"]
        score        <- map["score"]
        revisedscore <- map["revisedscore"]
        releasetime  <- map["releasetime"]
        scoretime    <- map["scoretime"]
        cover        <- map["cover"]
        servertime   <- map["servertime"]
    }
}
