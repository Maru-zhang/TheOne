//
//  TENavigationController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TENavigationController: UINavigationController,UINavigationControllerDelegate {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        setupSetting()
    }

    
    // MARK: - Private Method
    private func setupSetting() {
        delegate = self
    }
    
    
    // MARK: - Navi Delegate
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        
        // 如果是栈底根控制器那就显示，否则隐藏
        if viewController.isEqual(viewControllers[0]) {
            viewController.tabBarController?.tabBar.hidden = false
        }else {
            viewController.tabBarController?.tabBar.hidden = true
        }
        
    }
    
}
