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
        let homeVC = TENavigationController(rootViewController: TEHomeController())
        let articleVC = TENavigationController(rootViewController: TEArticleController())
        let musicVC = TENavigationController(rootViewController: TEMusicController())
        let movieVC = TENavigationController(rootViewController: TEMovieController())
        
        configChild(homeVC, itemImage: "tab_home", title: "主页")
        configChild(articleVC, itemImage: "tab_reading", title: "阅读")
        configChild(musicVC, itemImage: "tab_music", title: "音乐")
        configChild(movieVC, itemImage: "tab_movie", title: "电影")
    }
}
