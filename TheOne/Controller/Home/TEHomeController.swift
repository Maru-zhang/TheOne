//
//  TEHomeController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEHomeController: UIViewController {

    override func viewDidLoad() {
        
        setupView()
        
        setupCommonProperty()
    }
    
    
    // MARK: - Private Method
    func setupView() {
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "nav_title"))

    }
    
}
