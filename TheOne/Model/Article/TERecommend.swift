//
//  TERecommend.swift
//  TheOne
//
//  Created by master on 16/7/25.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import ObjectMapper

struct TERecommend: Mappable {
    
    var item_id: String?
    var title: String?
    var intro: String?
    var auther: String?
    var web_url: String?
    var number: String?
    var type: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        item_id   <- map["item_id"]
        title     <- map["title"]
        intro     <- map["introduction"]
        auther    <- map["author"]
        web_url   <- map["web_url"]
        number    <- map["number"]
        type      <- map["type"]
        
    }
}
