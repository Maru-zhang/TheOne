//
//  TEPageableView.swift
//  TheOne
//
//  Created by Maru on 16/5/31.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class TEPageableView: UIScrollView {
    
    typealias triggerAction = (refresh: AAPullToRefresh) -> ()
    
    weak var dataSource: TEPageableDataSource?
    weak var viewDelegate: TEPageableDelegate?
    
    var currentIndex: NSInteger
    var visibleCell: [UIView]
    var loadViewAfter: Bool = false
    
    var leftAction: triggerAction?
    var rightAction: triggerAction?
    
    var leftRefresher: AAPullToRefresh?
    var rightRefresher: AAPullToRefresh?

    private var registerClass: AnyClass?
    private var reuseCell: [UIView]
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        visibleCell = []
        reuseCell = []
        currentIndex = 0
        super.init(frame: frame)
        self.bounces = true
        self.delegate = self
        self.backgroundColor = UIColor.clearColor()
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = true
        self.directionalLockEnabled = true
        
        reloadData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

}

extension TEPageableView {
    
    // MARK: - Public Method

    func reloadData() {
        
        guard dataSource != nil else {
            contentSize = CGSizeMake(frame.width, frame.height + 200)
            return
        }
        
        if dataSource != nil {
            
        }
        
        // Reset && Remove all of view
        removeSubviews()
        currentIndex = 0
        visibleCell.removeAll()
        reuseCell.removeAll()

        let count = dataSource?.pageableView(self)
        contentSize = CGSizeMake(frame.width * CGFloat(count!), frame.height + 100)
        
        // Setup refresh
        
        if leftRefresher != nil {
            leftRefresher?.showPullToRefresh = false
            leftRefresher?.removeFromSuperview()
        }
        
        leftRefresher = addPullToRefreshPosition(.Left) { (v) in
            if let action = self.leftAction { action(refresh: v) }
        }
        
        leftRefresher!.borderWidth = 4.0
        leftRefresher!.borderColor = TEConfigure.pullRefreshColor
        
        // Init scroll
        scrollViewDidScroll(self)
        
        // Call setup delegate
        scrollViewDidEndDecelerating(self)
        
    }
    
    
    func dequeueReusableCell() -> UIView? {
        
        let anyObj = reuseCell.last
        
        if let cell = anyObj {
            return cell
        }else {
            return nil
        }
        
    }
}

extension TEPageableView: UIScrollViewDelegate {
    
    // MARK: - ScrollView Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

        // Some condition checked
        guard dataSource != nil else {
            return
        }
        
        // Make sure that scrollView only scrollenable in one direction once
//        if (scrollView.contentOffset.x != 0 &&
//            scrollView.contentOffset.y != 0) {
//            return
//        }
        
        // Make sure that page only in horizontal direation
        // TODO: There are still some problem
        if scrollView.contentOffset.x % scrollView.frame.width != 0 {
            scrollView.pagingEnabled = true
        }else if scrollView.contentOffset.y != 0 {
            scrollView.pagingEnabled = false
        }
        
        // Dynamic setup cell
        
        if visibleCell.count == 0 {
            let reuseView = dataSource?.pageableView(self, cardCellForColumnAtIndexPath: NSIndexPath(index: 0))
            visibleCell.append(reuseView!)
            viewDelegate?.pageableViewWillShowReuseView(self, reuseView: reuseView!)
            let frame = viewDelegate?.pageableViewFrame(self, atIndexPath: NSIndexPath(index: 0))
            reuseView?.frame = frame!
            scrollView.addSubview(reuseView!)
            return
        }
        
        
        /*
         Before use reuseView from cache, should call -setNeedsDisplay to redraw layer,otherwise
         the layer will be show overlapping.
         */
        
        var reuseView: UIView?
        var newFrame : CGRect?
        
        if scrollView.contentOffset.x > CGFloat(currentIndex) * scrollView.frame.width {
            
            // Scroll to right
            if visibleCell.count == 1 && currentIndex != ((dataSource?.pageableView(self))! - 1) {
                
                newFrame = viewDelegate?.pageableViewFrame(self, atIndexPath: NSIndexPath(index: currentIndex + 1))
                reuseView = dataSource?.pageableView(self, cardCellForColumnAtIndexPath: NSIndexPath(index: currentIndex + 1))
                reuseView?.frame = CGRectMake(scrollView.frame.width * CGFloat(currentIndex + 1) + newFrame!.x, (newFrame?.y)!, (newFrame?.width)!, (newFrame?.height)!)
            }
        }else if scrollView.contentOffset.x < CGFloat(currentIndex) * scrollView.frame.width {
            // Scroll to left
            if visibleCell.count == 1 && currentIndex != 0 {
                newFrame = viewDelegate?.pageableViewFrame(self, atIndexPath: NSIndexPath(index: currentIndex - 1))
                reuseView = dataSource?.pageableView(self, cardCellForColumnAtIndexPath: NSIndexPath(index: currentIndex - 1))
                reuseView?.frame = CGRectMake(scrollView.frame.width * CGFloat(currentIndex - 1) + newFrame!.x, (newFrame?.y)!, (newFrame?.width)!, (newFrame?.height)!)
            }
        }
        
        if reuseView != nil {
            reuseView?.setNeedsDisplay()
            viewDelegate?.pageableViewWillShowReuseView(self, reuseView: reuseView!)
            scrollView.addSubview(reuseView!)
            visibleCell.append(reuseView!)
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let newIndex = NSInteger(scrollView.contentOffset.x) / NSInteger(scrollView.frame.width)
        
        if newIndex == currentIndex && visibleCell.count == 2 {
            // Scroll to same location
            let cell = visibleCell.removeLast()
            reuseCell.append(cell)
            cell.removeFromSuperview()
        }else if newIndex != currentIndex && visibleCell.count == 2 {
            // Scroll to another location
            currentIndex = newIndex
            let cell = visibleCell.removeFirst()
            reuseCell.append(cell)
            cell.removeFromSuperview()

        }
        
        viewDelegate?.pageableViewDidEndScroll(self, toIndexPath: NSIndexPath(index: newIndex))
    }
    
}
