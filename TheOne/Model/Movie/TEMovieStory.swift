//
//  TEMovieStory.swift
//  TheOne
//
//  Created by Maru on 16/6/29.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ObjectMapper

struct TEMovieStory: Mappable {
    
    var id: String?
    var movie_id: String?
    var title: String?
    var content: String?
    var user_id: String?
    var sort: String?
    var praisenum: NSInteger?
    var input_date: String?
    var story_type: String?
    var user: TEUser?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        movie_id <- map["movie_id"]
        title <- map["title"]
        content <- map["content"]
        user_id <- map["user_id"]
        sort <- map["sort"]
        praisenum <- map["praisenum"]
        input_date <- map["input_date"]
        story_type <- map["story_type"]
        user <- map["user"]
    }
}