//
//  TEArticleCell.swift
//  TheOne
//
//  Created by Maru on 16/6/5.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TEArticleCell: UITableViewCell {
    
    let title: UILabel!
    let author: UILabel!
    let hotLine: UILabel!
    let typeImage: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        title = UILabel()
        author = UILabel()
        hotLine = UILabel()
        typeImage = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(title)
        addSubview(author)
        addSubview(hotLine)
        addSubview(typeImage)
        
        constrain(title, author, hotLine, typeImage) { (title, author, hotLine, typeImage) in
            
            title.left == (title.superview?.left)! + 5
            title.top  == (title.superview?.left)! + 8
            
            typeImage.right == (title.superview?.right)! + 5
            typeImage.centerY == title.centerY
            typeImage.width == 41
            typeImage.height == 19
            
            author.left == title.left
            author.top  == title.bottom + 8
            
            hotLine.left == title.left
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
