//
//  TEArticleCell.swift
//  TheOne
//
//  Created by Maru on 16/6/5.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEArticleCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var hotLine: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
