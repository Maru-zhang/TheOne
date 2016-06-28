//
//  TEComment.swift
//  TheOne
//
//  Created by Maru on 16/6/16.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ObjectMapper

struct TEComment: Mappable {
    
    var id: String?
    var quote: String?
    var content: String?
    var praisenum: NSInteger?
    var input_date: String?
    var touser: String?
    /// 0代表热门评论,1代表一般
    var type: NSInteger?
    /// 电影的分数，无用则为nil
    var score: String?
    var user: TEUser?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        quote <- map["quote"]
        content <- map["content"]
        praisenum <- map["praisenum"]
        input_date <- map["input_date"]
        touser <- map["touser"]
        type <- map["type"]
        score <- map["score"]
        user <- map["user"]
    }
}

struct TEUser: Mappable {
    
    var user_id: String?
    var user_name: String?
    var web_url: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        user_id <- map["user_id"]
        user_name <- map["user_name"]
        web_url <- map["web_url"]
    }
}