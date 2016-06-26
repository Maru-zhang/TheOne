
//
//  TEContentCell.swift
//  TheOne
//
//  Created by Maru on 16/6/21.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

enum TEContentType {
    case story,lyrics,info
}

class TEContentCell: TECleanCell {
    
    
    let title: UILabel
    let author: UILabel
    let textView: UITextView
    var displayType: TEContentType
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        title = UILabel.init()
        author = UILabel.init()
        textView = UITextView.init()
        displayType = .story
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.font = UIFont.systemFontOfSize(17)
        author.font = UIFont.systemFontOfSize(13)
        author.textColor = TEConfigure.author_Highlight
        author.textAlignment = .Left
        textView.font = UIFont.systemFontOfSize(15)
        textView.editable = false
        textView.scrollEnabled = false
        
        contentView.addSubview(textView)
        contentView.addSubview(title)
        contentView.addSubview(author)
        
        constrain(title, author, textView) { (title, author, textView) in
            
            title.top == (title.superview?.top)!
            title.left == (title.superview?.left)! + 8
            title.right == (title.superview?.right)! - 8
            
            author.top == (title.superview?.top)! + 20
            author.left == title.left
            author.right == title.right
            
            textView.top == author.bottom + 3
            textView.left == (title.superview?.left)! + 3
            textView.right == (title.superview?.right)! - 3
            textView.bottom == (title.superview?.bottom)! - 3
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        switch displayType {
        case .story:
            title.text = entity?.story_title
            author.text = entity?.story_Author?.user_name
            textView.attributedText = try! NSMutableAttributedString.init(data: (entity?.story?.dataUsingEncoding(NSUnicodeStringEncoding))!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            break
        case .lyrics:
            title.text = ""
            author.text = ""
            textView.attributedText = try! NSMutableAttributedString.init(data: (entity?.lyric!.dataUsingEncoding(NSUnicodeStringEncoding))!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            break
        case .info:
            title.text = ""
            author.text = ""
            textView.attributedText = try! NSMutableAttributedString.init(data: (entity?.info!.dataUsingEncoding(NSUnicodeStringEncoding))!, options: [NSDocumentTypeDocumentAttribute: NSPlainTextDocumentType], documentAttributes: nil)
            break
        }
        
        
    }
}
