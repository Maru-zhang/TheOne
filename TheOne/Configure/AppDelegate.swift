//
//  AppDelegate.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = TENavigationController(rootViewController: TETabBarController())
        window?.makeKeyAndVisible()
        
        setupAppreance()
        setupKingfisher()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    private func setupAppreance() {
        
        // 导航栏背景颜色
        UINavigationBar.appearance().barTintColor = TEConfigure.navBarTintColor
        // 导航栏字体颜色
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: TEConfigure.navTextColor]
        // 设置返回颜色
        UINavigationBar.appearance().tintColor = TEConfigure.navBackColor
        // 设置不透明
        UINavigationBar.appearance().translucent = false
        
        
        // 设置TabbarItem的外观
        UITabBarItem.appearance()
        .setTitleTextAttributes([NSForegroundColorAttributeName: TEConfigure.tabbarFontColor], forState: UIControlState.Normal)
        
        UITabBarItem.appearance()
            .setTitleTextAttributes([NSForegroundColorAttributeName: TEConfigure.tabbarFontColor_Selected], forState: .Selected)
        
    }
    
    private func setupKingfisher() {
        
        KingfisherManager.sharedManager.cache.maxMemoryCost = 5 * 1024 * 1024
        KingfisherManager.sharedManager.cache.maxDiskCacheSize = 100 * 1024 * 1024

    }
}

