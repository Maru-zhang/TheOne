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
        tabBar.translucent = false
        
        func configChild(vc: UIViewController,itemImage: String,title: String) {
            
            addChildViewController(vc)
            
            vc.title = title
            vc.tabBarItem.image = UIImage(named: "\(itemImage)_default")?.imageWithRenderingMode(.AlwaysOriginal)
            vc.tabBarItem.selectedImage = UIImage(named: "\(itemImage)_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        }
        
        // 配置子控制器
        configChild(TEHomeController(), itemImage: "tab_home", title: "主页")
        configChild(TEArticleController(), itemImage: "tab_reading", title: "阅读")
        configChild(TEMusicController(), itemImage: "tab_music", title: "音乐")
        configChild(TEMovieController(), itemImage: "tab_movie", title: "电影")
        
    }
}
