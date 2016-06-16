//
//  TEMusicBanner.swift
//  TheOne
//
//  Created by Maru on 16/6/16.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEMusicBanner: UIView {

    
    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var authour: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var Profession: UILabel!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        header.layer.cornerRadius = 25.0
        layer.borderWidth = 2.0
    }
}
