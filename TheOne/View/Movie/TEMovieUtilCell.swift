//
//  TEMovieUtilCell.swift
//  TheOne
//
//  Created by Maru on 16/6/29.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TEMovieUtilCell: TECleanCell {

    let ticketImage: UIButton
    let ticketLable: UILabel
    let scoreButton: UIButton
    let scoreLable : UILabel
    let shareButton: UIButton
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        ticketImage = UIButton()
        ticketImage.setImage(UIImage(named: "movie_ticket_default"), forState: .Normal)
        ticketImage.setImage(UIImage(named: "movie_ticket_highlighted"), forState: .Highlighted)
        
        ticketLable = UILabel()
        ticketLable.font = UIFont.systemFontOfSize(12)
        ticketLable.textColor = UIColor.lightGrayColor()
        ticketLable.text = "购票"
        
        scoreButton = UIButton()
        scoreButton.setImage(UIImage(named: "not_score"), forState: .Normal)
        scoreButton.setImage(UIImage(named: "not_score_highlighted"), forState: .Highlighted)
        
        scoreLable = UILabel()
        scoreLable.font = UIFont.systemFontOfSize(12)
        scoreLable.textColor = UIColor.lightGrayColor()
        scoreLable.text = "评分"
        
        shareButton = UIButton()
        shareButton.setImage(UIImage(named: "shareImage"), forState: .Normal)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(ticketImage)
        contentView.addSubview(ticketLable)
        contentView.addSubview(scoreLable)
        contentView.addSubview(scoreButton)
        contentView.addSubview(shareButton)
        
        constrain(ticketImage, ticketLable) { (ticketImage, ticketLable) in
            
            ticketImage.width == 44
            ticketImage.height == 44
            ticketImage.left == ticketImage.superview!.left + 10
            ticketImage.centerY == ticketImage.superview!.centerY
            
            ticketLable.left == ticketImage.right + 3
            ticketLable.centerY == ticketImage.centerY
        }
        
        constrain(scoreButton, scoreLable, shareButton) { (scoreButton, scoreLable, shareButton) in
            
            shareButton.width == 44
            shareButton.height == 44
            shareButton.right == shareButton.superview!.right - 10
            shareButton.centerY == shareButton.superview!.centerY
            
            scoreLable.centerY == shareButton.centerY
            scoreLable.right == shareButton.left - 5
            
            scoreButton.width == 44
            scoreButton.height == 44
            scoreButton.centerY == shareButton.centerY
            scoreButton.right == scoreLable.left - 5
        }
        
        separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layoutMargins = UIEdgeInsetsZero
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
