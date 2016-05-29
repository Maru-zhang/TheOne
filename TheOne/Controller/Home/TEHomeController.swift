//
//  TEHomeController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography
import ReactiveCocoa


let widgetSpace: CFloat = 20

class TEHomeController: UIViewController {
    
    var containner: UIScrollView!

    override func viewDidLoad() {
        
        setupView()
        
        setupBinding()
        
    }
    
}

extension TEHomeController {
    
    // MARK: - Private Method
    private func setupView() {
        
        setupCommentItem()
        
        // 配置滑动视图
        containner = UIScrollView(frame: view.bounds)
        containner.pagingEnabled = true
        containner.bounces = true
        containner.contentSize = CGSizeMake(view.frame.width * 3, view.frame.height + 100)
        containner.backgroundColor = UIColor.whiteColor()
        containner.showsVerticalScrollIndicator = true
        containner.showsHorizontalScrollIndicator = true
        containner.delegate = self
        view.addSubview(containner)
        
        // 配置卡片子视图
        let testCard_0 = TECardPageView()
        testCard_0.bounds = CGRectMake(0, 0, view.frame.width - 50, 400)
        testCard_0.center = CGPointMake(view.frame.width / 2, view.frame.height / 3)
        containner.addSubview(testCard_0)
        
        let testCard_1 = TECardPageView()
        testCard_1.bounds = CGRectMake(0, 0, view.frame.width - 50, 400)
        testCard_1.center = CGPointMake(view.frame.width * 1.5, view.frame.height / 3)
//        testCard_1.backgroundColor = UIColor.purpleColor()
        containner.addSubview(testCard_1)
        
        let testCard_2 = TECardPageView()
        testCard_2.bounds = CGRectMake(0, 0, view.frame.width - 50, 400)
        testCard_2.center = CGPointMake(view.frame.width * 2.5, view.frame.height / 3)
//        testCard_2.backgroundColor = UIColor.purpleColor()
        containner.addSubview(testCard_2)
        
        // 喜爱更多等Button
        let diary = UIImageView(image: UIImage(named: "diary_default"))
        let like = UIImageView(image: UIImage(named: "like_default"))
        let more = UIImageView(image: UIImage(named: "shareImage"))
        let likeNum = UILabel()
        likeNum.textColor = UIColor.lightGrayColor()
        likeNum.textAlignment = .Left
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
            
            likeNum.right == more.left
            likeNum.centerY == diary.centerY
            
            like.height == 44
            like.right == likeNum.left
            like.centerY == diary.centerY
            
            
        }
        
        
    }
    
    private func setupBinding() {
        
        
        rac_signalForSelector(#selector(TEHomeController.viewWillAppear(_:)))
            .toSignalProducer()
            .startWithNext({ [unowned self] (_) in
                self.tabBarController!.navigationItem.titleView = UIImageView(image: UIImage(named: "nav_title"))
            })
        
        rac_signalForSelector(#selector(TEHomeController.viewWillDisappear(_:)))
            .toSignalProducer()
            .startWithNext({ [unowned self] (_) in
                self.tabBarController!.navigationItem.titleView = nil
            })
        
        
    }
}

extension TEHomeController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        debugPrint(scrollView.contentOffset)
//        if scrollView.contentOffset.y <= 0 {
//            scrollView.contentOffset.y = 0
//        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}

