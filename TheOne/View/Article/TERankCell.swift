//
//  TERankCell.swift
//  TheOne
//
//  Created by Maru on 16/6/30.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TERankCell: UITableViewCell {
    
    
    let topicTitle: UILabel
    let topicPerson: UILabel
    let topicHotLine: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        topicTitle = UILabel()
        topicPerson = UILabel()
        topicHotLine = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        topicHotLine.numberOfLines = 0
        topicHotLine.textColor = UIColor.whiteColor()
        
        topicPerson.numberOfLines = 0
        topicPerson.textColor = UIColor.whiteColor()
        
        topicHotLine.numberOfLines = 0
        topicHotLine.textColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
