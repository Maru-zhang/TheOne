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
    
    weak var dataSource: TEPageableDataSource?
    weak var viewDelegate: TEPageableDelegate?
    
    private var registerClass: AnyClass?
    private var reuseCell: [UIView]
    private var visibleCell: [UIView]
    private var currentIndex: NSInteger
    
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
            contentSize = CGSizeMake(frame.width, frame.height + 100)
            return
        }
        
        // Reset && Remove all of view
        removeSubviews()
        currentIndex = 0
        visibleCell.removeAll()
        reuseCell.removeAll()

        let count = dataSource?.pageableView(self)
        
        contentSize = CGSizeMake(frame.width * CGFloat(count!), frame.height + 100)
        
        // Init scroll
        scrollViewDidScroll(self)
    }
    
    func registerClass(cls: AnyClass) {
        registerClass = cls
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
        if (scrollView.contentOffset.x != 0 &&
            scrollView.contentOffset.y != 0) {
            return
        }
        
        // Make sure that page only in horizontal direation
        // TODO: There are still some problem
        if scrollView.contentOffset.x > 0 || scrollView.contentOffset.x < 0 {
            scrollView.pagingEnabled = true
        }else {
            scrollView.pagingEnabled = false
        }

        // Dynamic setup cell
        
        if visibleCell.count == 0 {
            let reuseView = dataSource?.pageableView(self, cardCellForColumnAtIndexPath: NSIndexPath(index: 0))
            visibleCell.append(reuseView!)
            let frame = viewDelegate?.pageableViewFrame(self, atIndexPath: NSIndexPath(index: 0))
            reuseView?.frame = frame!
            scrollView.addSubview(reuseView!)
            return
        }
        
        
        if scrollView.contentOffset.x > CGFloat(currentIndex) * scrollView.frame.width {
            // Scroll to right
            if visibleCell.count == 1 && currentIndex != ((dataSource?.pageableView(self))! - 1) {

                let frame = viewDelegate?.pageableViewFrame(self, atIndexPath: NSIndexPath(index: currentIndex + 1))
                let reuseView = dataSource?.pageableView(self, cardCellForColumnAtIndexPath: NSIndexPath(index: currentIndex + 1))
                reuseView?.frame = CGRectMake(scrollView.frame.width * CGFloat(currentIndex + 1) + frame!.x, (frame?.y)!, (frame?.width)!, (frame?.height)!)
                reuseView?.setNeedsUpdateConstraints()
                reuseView?.setNeedsLayout()
                reuseView?.layoutIfNeeded()
                scrollView.addSubview(reuseView!)
                visibleCell.append(reuseView!)
                
            }
        }else if scrollView.contentOffset.x < CGFloat(currentIndex) * scrollView.frame.width {
            // Scroll to left
            if visibleCell.count == 1 && currentIndex != 0 {
                let frame = viewDelegate?.pageableViewFrame(self, atIndexPath: NSIndexPath(index: currentIndex - 1))
                let reuseView = dataSource?.pageableView(self, cardCellForColumnAtIndexPath: NSIndexPath(index: currentIndex - 1))
                reuseView?.frame = CGRectMake(scrollView.frame.width * CGFloat(currentIndex - 1) + frame!.x, (frame?.y)!, (frame?.width)!, (frame?.height)!)
                reuseView?.setNeedsUpdateConstraints()
                reuseView?.setNeedsLayout()
                reuseView?.layoutIfNeeded()
                scrollView.addSubview(reuseView!)
                visibleCell.append(reuseView!)
                
            }
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
        
    }
}
