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
        
        let meBtn = UIBarButtonItem(image: UIImage(named: "nav_me_default"), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(UIViewController.showUserCenterController))
        let musicPlayBtn = UIBarButtonItem(image: UIImage(named: "my_player_stop"), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(UIViewController.showMusicPlayer))

        // 取消半透明
        navigationController?.navigationBar.translucent = false
        navigationItem.rightBarButtonItems = [meBtn,musicPlayBtn]
        
    }
    
    func showUserCenterController() {
        
        navigationController?.pushViewController(TESettingController(), animated: true)
    }
    
    func showMusicPlayer() {
        print("music")
    }
}
