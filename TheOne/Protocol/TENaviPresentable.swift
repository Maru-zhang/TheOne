//
//  TENavigationPresentable.swift
//  TheOne
//
//  Created by Maru on 16/3/15.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

protocol TENavgationPresentable {
    
    static func configureRootController<T>(controller: T) -> TENavigationController!
}

extension TENavgationPresentable {
    
}