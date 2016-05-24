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
        
        let searchBtn = UIBarButtonItem(image: UIImage(named: "searchIcon")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TEItemPresentable.showSearchController))
        let meBtn = UIBarButtonItem(image: UIImage(named: "nav_me_default")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action: #selector(TEItemPresentable.showUserController))
        
        navigationItem.leftBarButtonItems = [searchBtn]
        navigationItem.rightBarButtonItems = [meBtn]
    }
}

extension UIViewController: TEItemPresentable {
    
    func showUserController() {
        presentVC(TESettingController())
    }
    
    func showSearchController() {
        
    }
}