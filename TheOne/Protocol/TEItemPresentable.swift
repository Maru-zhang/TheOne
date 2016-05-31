//
//  TEItemPresentable.swift
//  TheOne
//
//  Created by Maru on 16/5/24.
//  Copyright © 2016年 Maru. All rights reserved.
//
import Foundation

@objc
protocol TEItemPresentable {
    
    optional func setupCommentItem()
    
    optional func showUserController()
    
    optional func showSearchController()
}

extension TEItemPresentable where Self: UIViewController {
    
    func setupCommentItem() {
        
        tabBarController!.title = self.title
        view.backgroundColor = UIColor.whiteColor()
        
        let searchBtn = UIBarButtonItem(image: UIImage(named: "searchIcon")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TEItemPresentable.showSearchController))
        let meBtn = UIBarButtonItem(image: UIImage(named: "nav_me_default")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TEItemPresentable.showUserController))
        
        tabBarController!.navigationItem.leftBarButtonItems = [searchBtn]
        tabBarController!.navigationItem.rightBarButtonItems = [meBtn]
    }
}

extension UIViewController: TEItemPresentable,UIViewControllerTransitioningDelegate {
    
    
    
    func showUserController() {
        let setting = TESettingController()
        setting.transitioningDelegate = self
        self.presentVC(setting)
    }
    
    func showSearchController() {
        
    }
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TipperAnimation()
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TipperAnimation()
    }
}