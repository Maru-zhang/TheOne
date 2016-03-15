
//
//  TEItemType.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import UIKit

protocol TEItemPresentable{
    
    func setupNavigationItem()
    
}

extension TEItemPresentable where Self: UIViewController {
    
    func setupNavigationItem(vc: UIViewController) {
        
        vc.view.backgroundColor = UIColor.whiteColor()
        
    }
}
