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
    
    var index: Int = 0
    
    var diary: UIButton!
    var like : UIButton!
    var more : UIButton!
    
    var containner: TEPageableView!
    var pre_card: TECardPageView!
    var cur_card: TECardPageView!
    var nex_card: TECardPageView!
    
    var viewModel: TECardViewModel!

    override func viewDidLoad() {
        
        setupView()
        
        setupBinding()
        
        
        TENetService.apiGetLatestOneStuff { (signal) in
            signal.startWithNext({ (papers) in

            })
        }
        
    }
    
}

extension TEHomeController {
    
    // MARK: - Private Method
    private func setupView() {
        
        setupCommentItem()
        
        // 配置滑动视图
        containner = TEPageableView(frame: view.bounds)
        
        // 配置卡片子视图
        pre_card = TECardPageView()
        pre_card.bounds = CGRectMake(0, 0, view.frame.width - 20, 400)
        pre_card.center = CGPointMake(view.frame.width / 2, view.frame.height / 3)
        containner.addSubview(pre_card)
        
        cur_card = TECardPageView()
        cur_card.bounds = CGRectMake(0, 0, view.frame.width - 20, 400)
        cur_card.center = CGPointMake(view.frame.width * 1.5, view.frame.height / 3)
        containner.addSubview(cur_card)
        
        nex_card = TECardPageView()
        nex_card.bounds = CGRectMake(0, 0, view.frame.width - 20, 400)
        nex_card.center = CGPointMake(view.frame.width * 2.5, view.frame.height / 3)
        containner.addSubview(nex_card)
        
        // 喜爱更多等Button
        diary = UIButton()
        diary.setImage(UIImage(named: "diary_default"), forState: .Normal)
        
        like = UIButton()
        like.setImage(UIImage(named: "like_default"), forState: .Normal)
        like.setImage(UIImage(named: "like_highlighted"), forState: .Highlighted)
        like.setImage(UIImage(named: "like_selected"), forState: .Selected)
        
        more = UIButton()
        more.setImage(UIImage(named: "shareImage"), forState: .Normal)
        
        let likeNum = UILabel()
        likeNum.textColor = UIColor.lightGrayColor()
        likeNum.textAlignment = .Left
        likeNum.font = UIFont.systemFontOfSize(13)
        likeNum.text = "2120"
        
        view.addSubview(diary)
        view.addSubview(like)
        view.addSubview(more)
        view.addSubview(likeNum)
        view.addSubview(containner)

        
        // Layout setup
        constrain(diary, like, more, likeNum) { (diary, like, more, likeNum) -> () in
            
            diary.width     == 53
            diary.height    == 21
            diary.left      == (diary.superview?.left)! + 10
            diary.bottom    == (diary.superview?.bottom)! - (tabBarController?.tabBar.bounds.height)! - 40
            
            more.width      == 44
            more.height     == 44
            more.right      == diary.superview!.right - 10
            more.centerY    == diary.centerY
            
            likeNum.right   == more.left
            likeNum.centerY == diary.centerY
            
            like.height     == 44
            like.right      == likeNum.left
            like.centerY    == diary.centerY
            
            
        }
        
        
    }
    
    private func setupBinding() {
        
        viewModel = TECardViewModel()
        
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


