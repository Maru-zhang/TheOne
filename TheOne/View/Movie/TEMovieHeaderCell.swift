//
//  TEMovieHeaderCell.swift
//  TheOne
//
//  Created by Maru on 16/6/29.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TEMovieHeaderCell: TECleanCell {

    let scores    = UILabel()
    let bgImage   = UIImageView()
    let lineImage = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        scores.font = TEConfigure.movie_score_font
        scores.textColor = TEConfigure.movie_score_color
        
        contentView.addSubview(bgImage)
        contentView.addSubview(scores)
        contentView.addSubview(lineImage)
        
        constrain(scores, bgImage, lineImage) { (scores, bgImage, lineImage) in
            
            bgImage.edges == (bgImage.superview?.edges)!
            
            scores.right == bgImage.right - 10
            scores.bottom == bgImage.bottom - 10
            
            lineImage.right == scores.right
            lineImage.top == scores.bottom
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TEMovieHeaderCell {
    
    // MARK: - Public Method
    func configWithEntity(entity: TEMovieDetail?
        ) {
        guard entity != nil else {
            return
        }
        bgImage.kf_setImageWithURL(NSURL.init(string: entity!.detailcover!)!, placeholderImage: UIImage.init(named: "movie"))
        scores.text = entity!.score
    }
}
