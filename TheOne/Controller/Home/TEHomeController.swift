//
//  TEHomeController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography


let widgetSpace: CFloat = 20

class TEHomeController: UIViewController {

    override func viewDidLoad() {
        
        setupView()
        
        setupCommonProperty()
        
    }
    
    
    // MARK: - Private Method
    private func setupView() {
        
        // 导航栏LOGO
        navigationItem.titleView = UIImageView(image: UIImage(named: "nav_title"))
        
        // 喜爱更多等Button
        let diary = UIImageView(image: UIImage(named: "diary_default"))
        let like = UIImageView(image: UIImage(named: "like_default"))
        let more = UIImageView(image: UIImage(named: "shareImage"))
        let likeNum = UILabel()
        likeNum.textColor = UIColor.lightGrayColor()
        likeNum.textAlignment = .Center
        likeNum.font = UIFont.systemFontOfSize(13)
        likeNum.text = "2120"
        
        
        view.addSubview(diary)
        view.addSubview(like)
        view.addSubview(more)
        view.addSubview(likeNum)
        
        // Layout setup
        constrain(diary, like, more, likeNum) { (diary, like, more, likeNum) -> () in
            
            diary.width  == 53
            diary.height == 21
            diary.left   == (diary.superview?.left)! + 15
            diary.bottom == (diary.superview?.bottom)! - (tabBarController?.tabBar.bounds.height)! - 40

            more.width == 44
            more.height == 44
            more.right == diary.superview!.right - 10
            more.centerY == diary.centerY

            likeNum.width == 60
            likeNum.height == 44
            likeNum.right == more.left
            likeNum.centerY == diary.centerY

            like.height == 44
            like.right == likeNum.left
            like.centerY == diary.centerY
            
            
        }
        

    }
    

}
