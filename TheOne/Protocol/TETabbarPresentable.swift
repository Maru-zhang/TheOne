//
//  TETabbarPresentable.swift
//  TheOne
//
//  Created by Maru on 16/3/15.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import UIKit


protocol TETabbarPresentable {
    
    func setupTabbar();
}


extension TETabbarPresentable where Self: UITabBarController {
    
    func setupTabbar() {
        
        // 配置子控制器
        let homeVC = TENavigationController(rootViewController: TEHomeController())
        let articleVC = TENavigationController(rootViewController: TEArticleController())
        let musicVC = TENavigationController(rootViewController: TEMusicController())
        let movieVC = TENavigationController(rootViewController: TEMovieController())
        
        viewControllers = [homeVC,articleVC,musicVC,movieVC]
        
        // 配置图片文字
        let tabbarItems: [UITabBarItem] = self.tabBar.items!
        
        let item_0 = tabbarItems[0]
        let item_1 = tabbarItems[1]
        let item_2 = tabbarItems[2]
        let item_3 = tabbarItems[3]
        
        item_0.title = "主页"
        item_0.image = UIImage(named: "tab_home_default")?.imageWithRenderingMode(.AlwaysOriginal)
        item_0.selectedImage = UIImage(named: "tab_home_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        item_1.title = "阅读"
        item_1.image = UIImage(named: "tab_reading_default")?.imageWithRenderingMode(.AlwaysOriginal)
        item_1.selectedImage = UIImage(named: "tab_reading_selected")?.imageWithRenderingMode(.AlwaysOriginal);
        
        item_2.title = "音乐"
        item_2.image = UIImage(named: "tab_music_default")?.imageWithRenderingMode(.AlwaysOriginal)
        item_2.selectedImage = UIImage(named: "tab_music_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        item_3.title = "电影"
        item_3.image = UIImage(named: "tab_movie_default")?.imageWithRenderingMode(.AlwaysOriginal)
        item_3.selectedImage = UIImage(named: "tab_movie_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: TEConfigure.tabbarFontColor], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: TEConfigure.tabbarFontColor_Selected], forState: .Selected)
    }
}