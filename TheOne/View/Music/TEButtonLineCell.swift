

//
//  TEButtonLineCell.swift
//  TheOne
//
//  Created by Maru on 16/6/25.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEButtonLineCell: TECleanCell {
    
    var buttonLine: ButtonLine
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        buttonLine = ButtonLine()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(buttonLine)
    }
    
    override func layoutSubviews() {
        buttonLine.frame = self.bounds
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TEButtonLineCell {
    
    // MARK: - Public Method
    func configWithEntity(entity: TEMusicDetail?) {

        guard entity != nil else {
            return
        }
        buttonLine.lineButtons[0].setTitle(String(entity!.praisenum!), forState: .Normal)
        buttonLine.lineButtons[1].setTitle(String(entity!.commentnum!), forState: .Normal)
        buttonLine.lineButtons[2].setTitle(String(entity!.sharenum!), forState: .Normal)
        
    }
}
