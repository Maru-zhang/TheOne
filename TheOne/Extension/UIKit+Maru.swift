//
//  UIKit+Maru.swift
//  iCCUT
//
//  Created by Maru on 16/5/22.
//  Copyright © 2016年 Alloc. All rights reserved.
//

import Foundation

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}

extension UIViewController {
    
    func setupCommonProperty() {
        
        view.backgroundColor = UIColor.whiteColor()
        
        
        let searchBtn = UIBarButtonItem(image: UIImage(named: "searchIcon")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(UIViewController.showSearchViewController))
        let meBtn = UIBarButtonItem(image: UIImage(named: "nav_me_default")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(UIViewController.showUserCenterController))
        
        // 取消半透明
        navigationController?.navigationBar.translucent = false
        navigationItem.leftBarButtonItems = [searchBtn]
        navigationItem.rightBarButtonItems = [meBtn]
        
    }
    
    func showUserCenterController() {
        
        presentViewController(TESettingController(), animated: true, completion: nil)
    }
    
    func showSearchViewController() {
        
        
    }
    
    
}