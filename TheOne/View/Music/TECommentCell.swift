//
//  TECommentCellTableViewCell.swift
//  TheOne
//
//  Created by Maru on 16/6/16.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Kingfisher

class TECommentCell: TECleanCell {

    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var scores: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        username.textColor = TEConfigure.author_Highlight
        scores.font = TEConfigure.movie_score_personnal_font
        scores.textColor = TEConfigure.movie_score_color
    }

    
}

extension TECommentCell {
    
    // MARK: - Public Method
    
    func configWithComment(comment: TEComment) {
        
        // config data
        username.text = comment.user?.user_name!
        header.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: (comment.user?.web_url)!)!))
        timestamp.text = comment.input_date
        content.text = comment.content
        likeNum.text = String(comment.praisenum!)
        scores.text = comment.score ?? ""
        
        // setup display
        header.layer.cornerRadius = 20.0
        header.layer.masksToBounds = true
        
        // Layout separato
        separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layoutMargins = UIEdgeInsets.zero
        
    }
    
    // MARK: - Action
    @IBAction func likeAction(sender: AnyObject) {
        
    }
}
