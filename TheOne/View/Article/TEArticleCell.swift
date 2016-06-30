//
//  TEArticleCell.swift
//  TheOne
//
//  Created by Maru on 16/6/5.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ObjectMapper
import Cartography

enum TEArticleType: String {
    /// 问答
    case question = "questionIcon"
    /// 短篇
    case read     = "readIcon"
    /// 连载
    case serial   = "serialIcon"
}

class TEArticleCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var hotLine: UILabel!
    @IBOutlet weak var typeImage: UIImageView!

    var articleStyle: TEArticleType = .question {
        didSet {
            typeImage.image = UIImage(named: self.articleStyle.rawValue)
        }
    }
    
    override func awakeFromNib() {
        
        
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        title.textAlignment = .Left
        title.font = UIFont.systemFontOfSize(19)
        title.numberOfLines = 0
        
        author.textColor = UIColor.grayColor()
        author.font = UIFont.systemFontOfSize(15)
        author.textAlignment = .Left
        author.numberOfLines = 0
        
        hotLine.textColor = UIColor.grayColor()
        hotLine.font = UIFont.systemFontOfSize(15)
        hotLine.textAlignment = .Left
        hotLine.numberOfLines = 0
    }

}

extension TEArticleCell {
    
    // MARK: - Public Method
    func configureWithType(model: Mappable) {
        if model is TEEssay {
            let essay = model as! TEEssay
            title.text = essay.hp_title
            author.text = essay.author![0].user_name
            hotLine.text = essay.guide_word
            articleStyle = .read;
        }else if model is TESerial {
            let serial = model as! TESerial
            title.text = serial.title
            author.text = serial.author!.user_name
            hotLine.text = serial.excerpt
            articleStyle = .serial
        }else if model is TEIssue {
            let issue = model as! TEIssue
            title.text = issue.question_title
            author.text = issue.answer_title
            hotLine.text = issue.answer_content
            articleStyle = .question
        }
    }
}
