//
//  TEMusicBanner.swift
//  TheOne
//
//  Created by Maru on 16/6/16.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEMusicBanner: UIView {

    var shadowLayer: CALayer!
    
    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var authour: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var Profession: UILabel!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        authour.textColor = TEConfigure.author_Highlight
        Profession.textColor = UIColor.lightGray
        header.layer.cornerRadius = 25
        header.layer.masksToBounds = true
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Firsr, remove all of this layer's sublayer
        if shadowLayer != nil {
            shadowLayer.removeFromSuperlayer()
        }
        
        shadowLayer = CALayer()
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.frame = rect
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize.init(width: 0, height: 0)
        shadowLayer.shadowRadius = 3.0
        shadowLayer.cornerRadius = 5.0
        
        layer.insertSublayer(shadowLayer, at: 0)
        
        
    }
}

extension TEMusicBanner {
    
    // MARK: - Public Method
    func configWithEntity(entity: TEMusicDetail) {
        title.text = entity.title
        authour.text = entity.author?.user_name
        Profession.text = entity.author?.desc
        timeStamp.text = entity.maketime
    }
}
