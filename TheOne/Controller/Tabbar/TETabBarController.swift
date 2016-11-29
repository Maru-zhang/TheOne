

//
//  TETabBarController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TETabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        setupView()
    }
    
    private func setupView() {
        
        // 不透明
        tabBar.isTranslucent = false
        
        func configChild(vc: UIViewController,itemImage: String,title: String) {
            
            addChildViewController(vc)
            
            vc.title = title
            vc.tabBarItem.image = UIImage(named: "\(itemImage)_default")?.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem.selectedImage = UIImage(named: "\(itemImage)_selected")?.withRenderingMode(.alwaysOriginal)
        }
        
        // 配置子控制器
        configChild(vc: TEHomeController(), itemImage: "tab_home", title: "主页")
        configChild(vc: TEArticleController(), itemImage: "tab_reading", title: "阅读")
        configChild(vc: TEMusicController(), itemImage: "tab_music", title: "音乐")
        configChild(vc: TEMovieController(), itemImage: "tab_movie", title: "电影")
        
    }
}
