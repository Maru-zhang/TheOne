//
//  TEPaperModel.swift
//  TheOne
//
//  Created by Maru on 16/3/15.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import ObjectMapper

struct TEPaperModel: Mappable {
    
    /// 内容ID
    var hpcontent_id: String?
    /// 标题
    var hp_title: String?
    /// 作者ID
    var author_id: String?
    /// 图片URL
    var hp_img_url: String?
    /// 图片源URL
    var hp_img_original_url: String?
    /// 作者名字
    var hp_author: String?
    /// iPAD
    var ipad_url: String?
    /// 内容
    var hp_content: String?
    /// 该图发布时间
    var hp_makettime: String?
    /// 上次更新时间
    var last_update_date: String?
    /// 网站
    var web_url: String?
    /// 网站Image
    var wb_img_url: String?
    /// 点赞数量
    var praisenum: Int?
    /// 分享数量
    var sharenum: Int?
    /// 评论数量
    var commentnum: Int?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        hpcontent_id         <- map["hpcontent_id"]
        hp_title             <- map["hp_title"]
        author_id            <- map["author_id"]
        hp_img_url           <- map["hp_img_url"]
        hp_img_original_url  <- map["hp_img_original_url"]
        hp_author            <- map["hp_author"]
        ipad_url             <- map["ipad_url"]
        hp_content           <- map["hp_content"]
        hp_makettime         <- map["hp_makettime"]
        last_update_date     <- map["last_update_date"]
        web_url              <- map["web_url"]
        wb_img_url           <- map["wb_img_url"]
        praisenum            <- map["praisenum"]
        sharenum             <- map["sharenum"]
        commentnum           <- map["commentnum"]
    }
}