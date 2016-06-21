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
        
    }
    
    override func layoutSubviews() {
        
        scrollView.frame = contentView.bounds
        item_L.frame = CGRectMake(0, 0, contentView.frame.width / 3, contentView.frame.height)
        item_C.frame = CGRectMake(contentView.frame.width / 3, 0, contentView.frame.width / 3, contentView.frame.height)
        item_R.frame = CGRectMake(contentView.frame.width * (2 / 3), 0, contentView.frame.width / 3, contentView.frame.height)
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(selected: Bool, animated: Bool) {}
    override func setHighlighted(highlighted: Bool, animated: Bool) {}
    
}

extension TERelatedMusicCell {
    
    func configWithEntitys(entitys: [TEMusic_Related]) {
        
        guard entitys.count == 3 else {
            return
        }
        
        item_R.configWithEntity(entitys[0])
        item_C.configWithEntity(entitys[1])
        item_L.configWithEntity(entitys[2])
    }
}

class TERelatedMusicItem: UIView {
    
    var imageView: UIImageView
    let title: UILabel
    let author: UILabel
    
    override init(frame: CGRect) {
        imageView = UIImageView()
        title = UILabel()
        author = UILabel()
        super.init(frame: frame)
        
        author.textColor = TEConfigure.author_Highlight
        author.font = UIFont.systemFontOfSize(10)
        author.numberOfLines = 1
        
        title.font = UIFont.systemFontOfSize(12)
        title.numberOfLines = 1
        
        addSubview(imageView)
        addSubview(title)
        addSubview(author)
        
    }
    
    override func layoutSubviews() {
        
        constrain(imageView, title, author) { (imageView, title, author) in
            
            imageView.width == (imageView.superview?.width)! * 0.7
            imageView.height == imageView.width
            imageView.centerX == (imageView.superview?.centerX)!
            imageView.top == (imageView.superview?.top)! + 10
            
            title.leading == imageView.leading
            title.top == imageView.bottom + 3
            title.right == (imageView.superview?.right)!
            
            author.leading == imageView.leading
            author.top == title.bottom + 1
        }
        
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TERelatedMusicItem {
    
    // MARK: - Public Method
    func configWithEntity(entity: TEMusic_Related) {
        self.imageView.kf_setImageWithURL(NSURL.init(string: entity.cover!)!)
        self.title.text = entity.title!
        self.author.text = entity.author?.user_name!
    }
}