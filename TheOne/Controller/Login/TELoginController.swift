//
//  TELoginController.swift
//  TheOne
//
//  Created by Maru on 16/3/23.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TELoginController: UIViewController {
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        setupView()
    }

    // MARK: - Private Method
    private func setupView() {
        
        // 隐藏NavigaionItem
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        
        // 配置背景图片
        let background = UIImageView(image: UIImage(named: "personalBackgroundImage")!)
        background.frame = view.bounds
        view.addSubview(background)
        view.sendSubviewToBack(background)
        
    }
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
