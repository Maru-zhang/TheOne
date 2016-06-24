//
//  TEBaseSelectButton.swift
//  TheOne
//
//  Created by Maru on 16/6/23.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEBaseSelectButton: UIButton {

    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        selected ? (selected = false) : (selected = true)
    }

}
