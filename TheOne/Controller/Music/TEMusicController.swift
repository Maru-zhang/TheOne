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

        setupCommonProperty()
        
        setupView()
    }
    
    
    // MARK: - Private Method
    func setupView() {
        
        let libraryBtn = UIButton(frame: CGRectMake(0,0,20,28))
        libraryBtn.setImage(UIImage(named: "music_libraries_default"), forState: .Normal)
        libraryBtn.setImage(UIImage(named: "music_libraries_highlighted"), forState: .Highlighted)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: libraryBtn)
    }
}
