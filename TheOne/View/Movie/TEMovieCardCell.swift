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
    
    typealias ModelType = TEMovieCardModel
    
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
        
        constrain(scorlLable, coverImage) { (scorlLable, coverImage) -> () in
            
            coverImage.top == (coverImage.superview?.top)!
            coverImage.left == (coverImage.superview?.left)!
            coverImage.right == (coverImage.superview?.right)!
            coverImage.bottom == (coverImage.superview?.bottom)! - 5
            
            scorlLable.width == 70
            scorlLable.height == 70
            scorlLable.bottom == coverImage.bottom
            scorlLable.right == coverImage.right
        }
    }
    
    private func setupView() {
        
        addSubview(coverImage)
        addSubview(scorlLable)
        
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        scorlLable.font = TEConfigure.movie_score_font;
        scorlLable.textColor = TEConfigure.movie_score_color
    }

}
