//
//  TEExtension.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

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
        navigationController?.pushViewController(TESettingController(), animated: true)
        
    }
    
    func showSearchViewController() {
        
        
    }
    

}
