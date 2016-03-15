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
        
        let meBtn = UIBarButtonItem(image: UIImage(named: "nav_me_default"), landscapeImagePhone: nil, style: .Plain, target: self, action: Selector("showUserCenterController"))
        let musicPlayBtn = UIBarButtonItem(image: UIImage(named: "my_player_stop"), landscapeImagePhone: nil, style: .Plain, target: self, action: Selector("showMusicPlayer"))

        navigationItem.rightBarButtonItems = [meBtn,musicPlayBtn]
        
        

//        var backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_default_wight"), landscapeImagePhone: nil, style: .Plain, target: self, action: nil)
//        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
//        navigationItem.backBarButtonItem = popButton
        
    }
    
    func showUserCenterController() {
        
        navigationController?.pushViewController(TELoginController(), animated: true)
    }
    
    func showMusicPlayer() {
        print("music")
    }
}
