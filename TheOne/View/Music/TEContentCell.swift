
//
//  TEContentCell.swift
//  TheOne
//
//  Created by Maru on 16/6/21.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TEContentCell: TECleanCell {
    
    let title: UILabel
    let author: UILabel
    let textView: UITextView
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        title = UILabel.init()
        author = UILabel.init()
        textView = UITextView.init()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.font = UIFont.systemFontOfSize(15)
        author.font = UIFont.systemFontOfSize(13)
        author.textColor = TEConfigure.author_Highlight
        
        contentView.addSubview(textView)
        contentView.addSubview(title)
        contentView.addSubview(author)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        textView.frame = contentView.bounds
        
        super.layoutSubviews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}

extension TEContentCell {
    
    // MARK: - Public Method
    
    func configWithEntity(entity: TEMusicDetail?) {
        guard entity != nil else {
            return
        }
        title.text = entity?.title
        author.text = entity?.author?.user_name
        textView.text = entity!.story
    }
}
