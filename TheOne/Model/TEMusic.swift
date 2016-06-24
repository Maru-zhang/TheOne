
//
//  TEMusic.swift
//  TheOne
//
//  Created by Maru on 16/6/13.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ObjectMapper

struct TEMusicDetail: Mappable {
    
    var id: String?
    var title: String?
    var cover: String?
    var isfirst: String?
    var story_title: String?
    var story: String?
    var lyric: String?
    var info: String?
    var platform: String?
    var music_id: String?
    var charge_edt: String?
    var related_to: String?
    var web_url: String?
    var praisenum: NSInteger?
    var sort: NSInteger?
    var maketime: String?
    var last_update_date: String?
    var read_num: String?
    var author: TEAuthor?
    var story_Author: Story_Author?
    var sharenum: NSInteger?
    var commentnum: NSInteger?
    
    init() {}
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        cover <- map["cover"]
        isfirst <- map["cover"]
        story_title <- map["story_title"]
        story <- map["story"]
        lyric <- map["lyric"]
        info <- map["info"]
        platform <- map["platform"]
        music_id <- map["music_id"]
        charge_edt <- map["charge_edt"]
        related_to <- map["related_to"]
        web_url <- map["web_url"]
        praisenum <- map["praisenum"]
        sort <- map["sort"]
        maketime <- map["maketime"]
        last_update_date <- map["last_update_date"]
        read_num <- map["read_num"]
        author <- map["author"]
        story_Author <- map["story_author"]
        sharenum <- map["sharenum"]
        commentnum <- map["commentnum"]
    }
    
    
    
}

struct Story_Author: Mappable {
    
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


struct TEMusic_Related: Mappable {
    
    var id: String?
    var title: String?
    var cover: String?
    var platform: String?
    var music_id: String?
    var author: TEAuthor?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        cover <- map["cover"]
        platform <- map["platform"]
        music_id <- map["music_id"]
        author <- map["author"]
    }
}