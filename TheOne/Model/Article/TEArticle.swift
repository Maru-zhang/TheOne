
//
//  TEArticle.swift
//  TheOne
//
//  Created by Maru on 16/6/6.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ObjectMapper

struct TEArticle: Mappable {
    
    var content_id  : String?
    var hp_title    : String?
    var hp_makettime: String?
    var has_audio   : Bool?
    var author      = TEAuthor()
    
    init?(_ map: Map) {
        guard map["data"].JSONDictionary.count != 0 else {
            return nil
        }
    }
    
    mutating func mapping(map: Map) {
        content_id <- map["content_id"]
        hp_title   <- map["hp_title"]
        hp_makettime <- map["hp_makettime"]
        has_audio  <- map["has_audio"]
        author.user_id <- map["user_id"]
        author.user_name <- map["user_name"]
        author.web_url <- map["web_url"]
        author.desc <- map["desc"]
        author.wb_name <- map["wb_name"]
    }
    
}

struct TEAuthor: Mappable {
    
    var user_id     : String?
    var user_name   : String?
    var web_url     : String?
    var desc        : String?
    var wb_name     : String?
    
    init() {
        
    }
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
    }
}