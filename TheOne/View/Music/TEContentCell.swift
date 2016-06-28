
//
//  TEContentCell.swift
//  TheOne
//
//  Created by Maru on 16/6/21.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

enum TEContentType: String {
    case story  = "音乐故事",lyrics = "歌词", info   = "歌曲信息"
}

class TEContentCell: TECleanCell {
    
    
    let title: UILabel
    let author: UILabel
    let textView: UITextView
    let from: UILabel
    var displayType: TEContentType
    
    private let paragraphStyle = NSMutableParagraphStyle()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        title = UILabel.init()
        author = UILabel.init()
        textView = UITextView.init()
        from = UILabel.init()
        displayType = .story
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.font = UIFont.systemFontOfSize(17)
        
        author.font = UIFont.systemFontOfSize(13)
        author.textColor = TEConfigure.author_Highlight
        author.textAlignment = .Left
        
        textView.font = UIFont.systemFontOfSize(15)
        textView.editable = false
        textView.scrollEnabled = false
        
        from.font = UIFont.systemFontOfSize(12)
        from.textColor = UIColor.lightGrayColor()
        
        paragraphStyle.lineSpacing = 10.0
        
        contentView.addSubview(textView)
        contentView.addSubview(title)
        contentView.addSubview(author)
        contentView.addSubview(from)
        
        constrain(title, author, textView, from) { (title, author, textView, from) in
            
            title.top == (title.superview?.top)! + 5
            title.left == (title.superview?.left)! + 8
            title.right == (title.superview?.right)! - 8
            
            author.top == title.bottom + 3
            author.left == title.left
            author.right == title.right
            
            textView.top == author.bottom + 8
            textView.left == (title.superview?.left)! + 3
            textView.right == (title.superview?.right)! - 3
            
            from.left == title.left
            from.top == textView.bottom + 10
            from.bottom == (title.superview?.bottom)! - 5
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
            from.text = entity?.charge_edt
            textView.attributedText = try! NSMutableAttributedString.init(data: (entity?.story?.dataUsingEncoding(NSUnicodeStringEncoding))!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSParagraphStyleAttributeName: paragraphStyle], documentAttributes: nil)
            break
        case .lyrics:
            title.text = ""
            author.text = ""
            from.text = ""
            textView.attributedText = try! NSMutableAttributedString.init(data: (entity?.lyric!.dataUsingEncoding(NSUnicodeStringEncoding))!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSParagraphStyleAttributeName: paragraphStyle], documentAttributes: nil)
            break
        case .info:
            title.text = ""
            author.text = ""
            from.text = ""
            textView.attributedText = try! NSMutableAttributedString.init(data: (entity?.info!.dataUsingEncoding(NSUnicodeStringEncoding))!, options: [NSDocumentTypeDocumentAttribute: NSPlainTextDocumentType,NSParagraphStyleAttributeName: paragraphStyle], documentAttributes: nil)
            break
        }
        
        
    }
}
