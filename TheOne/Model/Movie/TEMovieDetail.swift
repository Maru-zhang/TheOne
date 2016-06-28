//
//  TEMovieDetail.swift
//  TheOne
//
//  Created by Maru on 16/6/29.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ObjectMapper

struct TEMovieDetail: Mappable {
    
    var id: String?
    var title: String?
    var indexcover: String?
    var detailcover: String?
    var video: String?
    var verse: String?
    var verse_en: String?
    var score: String?
    var revisedscore: String?
    var review: String?
    var keywords: String?
    var movie_id: String?
    var info: String?
    var officialstory: String?
    var charge_edt: String?
    var web_url: String?
    var praisenum: NSInteger?
    var sort: String?
    var releasetime: String?
    var scoretime: String?
    var maketime: String?
    var last_update_date: String?
    var read_num: String?
    var photo: String?
    var sharenum: NSInteger?
    var commentnum: NSInteger?
    var servertime: NSInteger?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        indexcover <- map["indexcover"]
        detailcover <- map["detailcover"]
        video <- map["video"]
        verse <- map["verse"]
        verse_en <- map["verse_en"]
        score <- map["score"]
        revisedscore <- map["revisedscore"]
        review <- map["review"]
        keywords <- map["keywords"]
        movie_id <- map["movie_id"]
        info <- map["info"]
        officialstory <- map["officialstory"]
        charge_edt <- map["charge_edt"]
        web_url <- map["web_url"]
        praisenum <- map["praisenum"]
        sort <- map["sort"]
        releasetime <- map["releasetime"]
        scoretime <- map["scoretime"]
        maketime <- map["maketime"]
        last_update_date <- map["last_update_date"]
        read_num <- map["read_num"]
        photo <- map["photo"]
        sharenum <- map["sharenum"]
        commentnum <- map["commentnum"]
        servertime <- map["servertime"]
    }
    
}
