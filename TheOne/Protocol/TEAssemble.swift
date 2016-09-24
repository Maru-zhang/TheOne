//
//  TEAssemble.swift
//  TheOne
//
//  Created by Maru on 16/8/21.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation

protocol TEAssemble: class {
    func assembleLeftItem(image: UIImage) -> UIButton?
    func assembleRightItem(image: UIImage) -> UIButton?
}

