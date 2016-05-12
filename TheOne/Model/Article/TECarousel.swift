//
//  TECarousel.swift
//  TheOne
//
//  Created by Maru on 16/5/12.
//  Copyright © 2016年 Maru. All rights reserved.
//

import ObjectMapper

struct TECarousel: Mappable {
    
    /* ID */
    var id: String?
    /* 标题 */
    var title: String?
    /* 封面 */
    var cover: String?
    /* 背景颜色 */
    var bgcolor: String?
    /* 底部文字 */
    var bottom_text: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        cover <- map["cover"]
        bgcolor <- map["bgcolor"]
        bottom_text <- map["bottom_text"]
    }
}
