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
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "personalBackgroundImage")!.resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)))
        
    }
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
