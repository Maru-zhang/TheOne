//
//  TEMovieCardCell.swift
//  TheOne
//
//  Created by Maru on 16/3/15.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

class TEMovieCardCell: UITableViewCell {
    
    /// 分数
    let scorlLable = UILabel()
    /// 背景图片
    let coverImage = UIImageView()
    /// 底部的横线
    let bottomLine = UIImageView()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        constrain(scorlLable, coverImage ,bottomLine) { (scorlLable, coverImage, bottomLine) -> () in
            
            coverImage.top == (coverImage.superview?.top)!
            coverImage.left == (coverImage.superview?.left)!
            coverImage.right == (coverImage.superview?.right)!
            coverImage.bottom == (coverImage.superview?.bottom)! - 5
            
            scorlLable.width == 70
            scorlLable.height == 70
            scorlLable.bottom == coverImage.bottom
            scorlLable.right == coverImage.right
            
            bottomLine.width == 60
            bottomLine.height == 5
            bottomLine.top == scorlLable.bottom - 13
            bottomLine.right == scorlLable.right
        }
    }
    
    private func setupView() {
        
        addSubview(coverImage)
        addSubview(scorlLable)
        addSubview(bottomLine)
        
        bottomLine.image = UIImage(named: "redline")
        bottomLine.transform = CGAffineTransformMakeRotation(-0.3)
        
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
    }
    
    // MARK: - Public Method
    func configureWithViewModels(viewModel: TEMovieViewModel,indexPath: NSIndexPath) {
        
        coverImage.kf_setImageWithURL(viewModel.coverImageURLAtIndexPath(indexPath))
        
        if let score = viewModel.scoreNumberAtIndexPath(indexPath) {
            scorlLable.font = TEConfigure.movie_score_font
            scorlLable.textColor = TEConfigure.movie_score_color
            scorlLable.text = score
            bottomLine.hidden = false
        }else {
            scorlLable.font = TEConfigure.movie_beon_font
            scorlLable.textColor = TEConfigure.movie_beon_color
            scorlLable.text = "即将上映"
            bottomLine.hidden = true
        }
    }

}
