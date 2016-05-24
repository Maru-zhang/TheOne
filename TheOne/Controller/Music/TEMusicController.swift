//
//  TEMusicController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEMusicController: UIViewController {

    override func viewDidLoad() {
        
        setupView()
    }
    
    
    // MARK: - Private Method
    func setupView() {
        
        title = "音乐"
        
        setupCommentItem()
    }
}
