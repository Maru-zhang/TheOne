
//
//  TEArticle.swift
//  TheOne
//
//  Created by Maru on 16/6/6.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ObjectMapper

struct TEEssay: Mappable {
    
    var content_id  : String?
    var hp_title    : String?
    var hp_makettime: String?
    var guide_word  : String?
    var has_audio   : Bool?
    var author      : [TEAuthor]?
    
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
        guide_word <- map["guide_word"]
        author <- map["author"]
    }
    
}

struct TESerial: Mappable {
    
    var id: String?
    var serial_id: String?
    var number: String?
    var title: String?
    var excerpt: String?
    var read_num: String?
    var maketime: String?
    var author : TEAuthor?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        serial_id <- map["serial_id"]
        number <- map["number"]
        title <- map["title"]
        excerpt <- map["excerpt"]
        read_num <- map["read_num"]
        maketime <- map["maketime"]
        author <- map["author"]
    }
}

struct TEIssue: Mappable {
    
    var question_id: String?
    var question_title: String?
    var answer_title: String?
    var answer_content: String?
    var question_makettime: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        question_id <- map["question_id"]
        question_title <- map["question_title"]
        answer_title <- map["answer_title"]
        answer_content <- map["answer_content"]
        question_makettime <- map["question_makettime"]
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
        user_id <- map["user_id"]
        user_name <- map["user_name"]
        web_url <- map["web_url"]
        desc <- map["desc"]
        wb_name <- map["wb_name"]
    }
}