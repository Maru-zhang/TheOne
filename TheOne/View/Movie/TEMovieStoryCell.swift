//
//  TEMovieStoryCell.swift
//  TheOne
//
//  Created by Maru on 16/6/29.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

class TEMovieStoryCell: TECleanCell{

    let headerImage: UIButton
    let nameLable: UILabel
    let timeLable: UILabel
    let srotyTitle: UILabel
    let storyContent: UILabel
    let likeButton: UIButton
    let likeLable: UILabel
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        headerImage = UIButton()
        nameLable = UILabel()
        timeLable = UILabel()
        srotyTitle = UILabel()
        storyContent = UILabel()
        likeButton = UIButton()
        likeLable = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLable.font = UIFont.systemFontOfSize(10)
        nameLable.textColor = TEConfigure.author_Highlight
        
        timeLable.font = UIFont.systemFontOfSize(10)
        timeLable.textColor = UIColor.lightGrayColor()
        
        likeLable.font = UIFont.systemFontOfSize(10)
        likeLable.textColor = UIColor.lightGrayColor()
        
        headerImage.layer.cornerRadius = 20.0
        headerImage.layer.masksToBounds = true
        
        srotyTitle.numberOfLines = 0
        
        storyContent.numberOfLines = 0
        storyContent.font = UIFont.systemFontOfSize(15)
        storyContent.textColor = UIColor.darkGrayColor()
        
        likeButton.setImage(UIImage.init(named: "like_default"), forState: .Normal)
        likeButton.setImage(UIImage.init(named: "like_selected"), forState: .Selected)
        likeButton.setImage(UIImage.init(named: "like_highlighted"), forState: .Highlighted)
        
        contentView.addSubview(headerImage)
        contentView.addSubview(nameLable)
        contentView.addSubview(srotyTitle)
        contentView.addSubview(storyContent)
        contentView.addSubview(timeLable)
        contentView.addSubview(likeLable)
        contentView.addSubview(likeButton)
        
        constrain(headerImage, nameLable, timeLable, storyContent, srotyTitle) { (headerImage, nameLable, timeLable, storyContent, srotyTitle) in
            
            headerImage.left == headerImage.superview!.left + 8
            headerImage.top == headerImage.superview!.top + 8
            headerImage.width == 40
            headerImage.height == 40
            
            nameLable.top == headerImage.top + 5
            nameLable.left == headerImage.right + 5
            
            timeLable.bottom == headerImage.bottom - 3
            timeLable.left == headerImage.right + 5
            
            srotyTitle.left == nameLable.left
            srotyTitle.right == nameLable.right - 10
            srotyTitle.top == headerImage.bottom + 5
            
            storyContent.top == srotyTitle.bottom + 8
            storyContent.left == timeLable.left
            storyContent.right == storyContent.superview!.right - 10
            storyContent.bottom == storyContent.superview!.bottom - 3
        }
        
        constrain(likeLable, likeButton) { (likeLable, likeButton) in
            
            likeLable.right == likeLable.superview!.right - 5
            likeLable.top == likeLable.superview!.top + 15
            
            likeButton.width == 44
            likeButton.height == 44
            likeButton.right == likeLable.left - 3
            likeLable.centerY == likeLable.centerY
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TEMovieStoryCell {
    
    // MARK: - Publci Method
    func configWithEntity(entity: TEMovieStory) {
        
        headerImage.kf_setImageWithURL(NSURL.init(string: (entity.user?.web_url)!)!, forState: .Normal, placeholderImage: UIImage.init(named: "personal"))
        nameLable.text = entity.user?.user_name ?? ""
        timeLable.text = entity.input_date!
        likeLable.text = entity.praisenum?.toString
        srotyTitle.text = entity.title
        storyContent.text = entity.content
    }
    
}