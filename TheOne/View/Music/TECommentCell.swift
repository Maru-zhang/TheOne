//
//  TECommentCellTableViewCell.swift
//  TheOne
//
//  Created by Maru on 16/6/16.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Kingfisher

class TECommentCell: UITableViewCell {

    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var likeNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        
    }
    
}

extension TECommentCell {
    
    // MARK: - Public Method
    
    func configWithComment(comment: TEComment) {
        username.text = comment.user?.user_name
        header.kf_setImageWithURL(NSURL(string: (comment.user?.web_url)!)!)
        timestamp.text = comment.input_date
        content.text = comment.content
        likeNum.text = String(comment.praisenum!)
        
        // setup display
        header.layer.cornerRadius = 20.0
        header.layer.masksToBounds = true
        separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layoutMargins = UIEdgeInsetsZero
        
    }
    
    // MARK: - Action
    @IBAction func likeAction(sender: AnyObject) {
        
    }
}