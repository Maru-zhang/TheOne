//
//  TEArticleCell.swift
//  TheOne
//
//  Created by Maru on 16/6/5.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
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
    

    let title: UILabel!
    let author: UILabel!
    let hotLine: UILabel!
    let typeImage: UIImageView!
    
    var articleStyle: TEArticleType {
        didSet {
            typeImage.image = UIImage(named: self.articleStyle.rawValue)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        title = UILabel()
        author = UILabel()
        hotLine = UILabel()
        typeImage = UIImageView()
        articleStyle = .question
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clearColor()
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
        
        addSubview(title)
        addSubview(author)
        addSubview(hotLine)
        addSubview(typeImage)
                
        constrain(title, author, hotLine, typeImage) { (title, author, hotLine, typeImage) in
            
            title.left == (title.superview?.left)! + 5
            title.right == (title.superview?.right)! - 54
            title.top  == (title.superview?.left)! + 8
            
            typeImage.right == (title.superview?.right)! - 8
            typeImage.top == title.top
            typeImage.width == 41
            typeImage.height == 19
            
            author.left == title.left
            author.top  == title.bottom + 8
            author.right == title.right
            
            hotLine.left == title.left
            hotLine.right == (title.superview?.right)! - 5
            hotLine.top  == author.bottom + 8
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TEArticleCell {
    
    // MARK: - Public Method
    func configureWithType(model: TEArticleViewModel, type: TEArticleType) {
        
    }
}
