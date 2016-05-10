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
        
        let meBtn = UIBarButtonItem(image: UIImage(named: "nav_me_default")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(UIViewController.showUserCenterController))
        
        // 取消半透明
        navigationController?.navigationBar.translucent = false
        navigationItem.rightBarButtonItems = [meBtn]
        
    }
    
    func showUserCenterController() {
        
        presentViewController(TESettingController(), animated: true, completion: nil)
        
    }
    

}
