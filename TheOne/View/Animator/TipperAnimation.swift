//
//  TipperAnimation.swift
//  TheOne
//
//  Created by Maru on 16/5/31.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TipperAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.7
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC   = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let contain = transitionContext.containerView()
        
        var fromView: UIView!
        var toView  : UIView!
        
        if transitionContext.respondsToSelector(#selector(UIViewControllerTransitionCoordinatorContext.viewForKey(_:))) {
            fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            toView   = transitionContext.viewForKey(UITransitionContextToViewKey)
        }
        
        fromView.frame = transitionContext.finalFrameForViewController(toVC!)
        fromView.transform = CGAffineTransformIdentity
        fromView.alpha = 1
        
        toView?.frame = transitionContext.finalFrameForViewController(toVC!)
        toView.transform = CGAffineTransformMakeScale(-1, 1)
        toView.alpha = 0
        
        contain?.addSubview(fromView)
        contain?.addSubview(toView)
        contain?.addSubview((fromVC?.view)!)

        
        let transitionDuration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(transitionDuration, delay: 0, options: .LayoutSubviews, animations: {
            fromView.transform = CGAffineTransformMakeScale(-1, 1)
            fromView.alpha = 0
            toView.transform = CGAffineTransformIdentity
            toView.alpha = 1
        }) { (finished: Bool) in
            fromView.removeFromSuperview()
            contain?.backgroundColor = UIColor.clearColor()
            let wasCancelled = transitionContext.transitionWasCancelled()
            transitionContext.completeTransition(!wasCancelled)
        }
        
        
    }
    
}
