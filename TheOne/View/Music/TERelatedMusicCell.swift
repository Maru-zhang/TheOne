//
//  TERelatedMusicCell.swift
//  TheOne
//
//  Created by Maru on 16/6/19.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TERelatedMusicCell: UITableViewCell {
    
    let scrollView: UIScrollView
    let item_L: TERelatedMusicItem
    let item_C: TERelatedMusicItem
    let item_R: TERelatedMusicItem
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        scrollView = UIScrollView()
        item_L = TERelatedMusicItem(frame: CGRectZero)
        item_C = TERelatedMusicItem(frame: CGRectZero)
        item_R = TERelatedMusicItem(frame: CGRectZero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(item_R)
        scrollView.addSubview(item_L)
        scrollView.addSubview(item_C)

        constrain(scrollView, item_L, item_C, item_R) { (scrollView, item1, item2, item3) in
            
            scrollView.top == (scrollView.superview?.top)!
            scrollView.left == (scrollView.superview?.left)!
            scrollView.right == (scrollView.superview?.right)!
            scrollView.bottom == (scrollView.superview?.bottom)!
            
            item1.left == scrollView.left
            item1.top == scrollView.top
            item1.bottom == scrollView.bottom
            item1.width == scrollView.width / 3
            
            item2.left == item1.right
            item2.top == scrollView.top
            item2.bottom == scrollView.bottom
            item2.width == scrollView.width / 3
            
            item3.left == item2.right
            item3.top == item2.top
            item3.bottom == item2.bottom
            item2.width == scrollView.width / 3
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {}
    override func setHighlighted(highlighted: Bool, animated: Bool) {}
    
}

class TERelatedMusicItem: UIView {
    
    let imageView: UIImageView
    let title: UILabel
    let author: UILabel
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        title = UILabel()
        author = UILabel()
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(title)
        addSubview(author)
        
        backgroundColor = UIColor.redColor()
        
        constrain(imageView, title, author) { (imageView, title, author) in
            
            imageView.width == (imageView.superview?.width)! - 20
            imageView.height == imageView.width
            imageView.centerX == (imageView.superview?.centerX)!
            imageView.top == (imageView.superview?.top)! + 10
            
            title.leading == imageView.leading
            title.top == imageView.bottom + 3
            
            author.leading == imageView.leading
            author.top == title.bottom + 1
        }
        
        title.text = "dsadsa"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}