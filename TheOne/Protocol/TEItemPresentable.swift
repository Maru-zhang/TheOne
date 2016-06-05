//
//  TEItemPresentable.swift
//  TheOne
//
//  Created by Maru on 16/5/24.
//  Copyright © 2016年 Maru. All rights reserved.
//
import Foundation
import ReactiveCocoa

@objc
protocol TEItemPresentable {
    
    optional func setupCommentItem()
    
}

extension TEItemPresentable where Self: UIViewController {
    
    func setupCommentItem() {
        
        tabBarController!.title = self.title
        view.backgroundColor = UIColor.whiteColor()
        
        let searchBtn = UIBarButtonItem(image: UIImage(named: "searchIcon")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: nil, action: nil)
        let meBtn = UIBarButtonItem(image: UIImage(named: "nav_me_default")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: nil, action: nil)
        
        searchBtn.rac_command = RACCommand.init(signalBlock: { (button) -> RACSignal! in
            debugPrint("搜索按钮点击")
            return RACSignal.empty()
        })
        
        meBtn.rac_command = RACCommand.init(signalBlock: { [unowned self] (button) -> RACSignal! in
            let setting = TESettingController()
            setting.transitioningDelegate = self
            self.presentViewController(setting, animated: true, completion: nil)
            return RACSignal.empty()
        })
        
        tabBarController!.navigationItem.leftBarButtonItems = [searchBtn]
        tabBarController!.navigationItem.rightBarButtonItems = [meBtn]
    }
}

extension UIViewController: TEItemPresentable,UIViewControllerTransitioningDelegate {
    
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TipperAnimation()
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TipperAnimation()
    }
}