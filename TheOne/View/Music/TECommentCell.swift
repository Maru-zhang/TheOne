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
        header.layer.cornerRadius = 20.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TECommentCell {
    
    // MARK: - Public Method
    
    func configWithComment(comment: TEComment) {
        username.text = comment.user?.user_name
        header.kf_setImageWithURL(NSURL(string: (comment.user?.web_url)!)!)
        timestamp.text = comment.input_date
        content.text = comment.content
        likeNum.text = String(comment.praisenum)
    }
    
    // MARK: - Action
    @IBAction func likeAction(sender: AnyObject) {
        
    }
}