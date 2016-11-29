//
//  TERankCell.swift
//  TheOne
//
//  Created by Maru on 16/6/30.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TERankCell: TECleanCell {
    
    let rank: UILabel
    let topicTitle: UILabel
    let topicPerson: UILabel
    let topicHotLine: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        rank = UILabel()
        topicTitle = UILabel()
        topicPerson = UILabel()
        topicHotLine = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        rank.font = UIFont.systemFont(ofSize: 15)
        rank.textColor = UIColor.white
        
        topicTitle.numberOfLines = 0
        topicTitle.font = UIFont.systemFont(ofSize: 15)
        topicTitle.textColor = UIColor.white
        
        topicPerson.numberOfLines = 0
        topicPerson.font = UIFont.systemFont(ofSize: 11)
        topicPerson.textColor = UIColor.white
        
        topicHotLine.numberOfLines = 0
        topicHotLine.font = UIFont.systemFont(ofSize: 11)
        topicHotLine.textColor = UIColor.white
        
        contentView.addSubview(rank)
        contentView.addSubview(topicTitle)
        contentView.addSubview(topicPerson)
        contentView.addSubview(topicHotLine)
        
        constrain(topicTitle, topicPerson, topicHotLine, rank) { (topicTitle, topicPerson, topicHotLine, rank) in
            
            topicTitle.left == topicTitle.superview!.left + 30
            topicTitle.top  == topicTitle.superview!.top + 4
            topicTitle.right == topicTitle.superview!.right - 4

            topicPerson.left == topicTitle.left
            topicPerson.top == topicTitle.bottom + 3

            topicHotLine.left == topicTitle.left
            topicHotLine.right == topicTitle.right
            topicHotLine.top == topicPerson.bottom + 3
            topicHotLine.bottom == topicHotLine.superview!.bottom - 30
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TERankCell {
    
    func configureWithEntity(recommend: TERecommend) {
        
        topicTitle.text = recommend.title
        topicPerson.text = recommend.auther
        topicHotLine.text = recommend.intro
    }
}
