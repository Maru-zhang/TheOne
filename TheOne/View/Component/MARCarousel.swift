//
//  MARCarousel.swift
//  TheOne
//
//  Created by Maru on 16/5/13.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

public class MARCarousel: UIView,UIScrollViewDelegate {

    private enum MARDirection {
        case Left,Right
    }
    
    /// All images to show
    public dynamic var images: [UIImage]!
    /// Imgs Container
    private var scrollView: UIScrollView!
    /// Current Image to show
    private var currentImageView: UIImageView!
    /// Next Image to Show
    private var nextImageView: UIImageView!
    /// The pageIndicator
    private var pageIndicator: UIPageControl!
    /// The time Manager
    private var timer: NSTimer?
    /// Default time duration
    public var duration: NSTimeInterval!
    /// Call back when user touch event,Default is nil
    public var touchEventColsure: (() -> Void)?
    /// The index of current page
    private var indexOfCurrent: Int = 0 {
        didSet {
            pageIndicator.currentPage = indexOfCurrent
        }
    }
    
    private var MAR_Context = 0
    
    // MARK: -  Initlializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(frame: CGRect, images: [UIImage]) {
        self.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Method

    
    // MARK: - Private method
    private func setup() {
        
        duration = 2.5
        images = [UIImage]()
        touchEventColsure = nil
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.contentSize = CGSizeMake(self.frame.width * 3, self.frame.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        
        currentImageView = UIImageView(frame: CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))
        currentImageView.userInteractionEnabled = true
        currentImageView.contentMode = .ScaleToFill
        currentImageView.clipsToBounds = true
        
        nextImageView = UIImageView()
        nextImageView.userInteractionEnabled = true
        nextImageView.contentMode = .ScaleToFill
        nextImageView.clipsToBounds = true
        
        
        pageIndicator = UIPageControl()
        pageIndicator.hidesForSinglePage = true
        pageIndicator.backgroundColor = UIColor.clearColor()
        pageIndicator.frame = CGRectMake(0, self.frame.height - 40, self.frame.width, 40)
        pageIndicator.numberOfPages = images.count
        pageIndicator.currentPage = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        addSubview(scrollView)
        addSubview(pageIndicator)
        scrollView.addSubview(currentImageView)
        
        addObserver(self, forKeyPath: "images", options: .New, context: &MAR_Context)
        
    }
    
    @objc private func updateTime() {
        
        scrollToSpecifyDirection(.Left)
    }
    
    /**
     Assign a direction to scroll
     
     - parameter direction:	direction
     */
    private func scrollToSpecifyDirection(direction: MARDirection) {
        
        guard images.count >= 1 else {
            return
        }
        
        if direction == .Left {
            
            let newIndex = (indexOfCurrent + 1) % images.count
            
            nextImageView.image = images[newIndex]
            
            scrollView.addSubview(nextImageView)
            
            scrollView.setContentOffset(CGPointMake(self.frame.width * 2, 0), animated: true)
            
            indexOfCurrent = newIndex
            
        }else {
            
            let newIndex = (indexOfCurrent + images.count - 1) % images.count
            
            nextImageView.image = images[newIndex]
            
            scrollView.addSubview(nextImageView)

            scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
            
            indexOfCurrent = newIndex

        }
        
        
        
    }
    
    
    // MARK: - Override
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if (context == &MAR_Context) && (keyPath == "images") {
            
            if let newValue = change![NSKeyValueChangeNewKey]{
                
                debugPrint(newValue)
                
                let newImages = newValue as! [UIImage]
                
                pageIndicator.numberOfPages = newImages.count
                currentImageView.image = images.first
                nextImageView.removeFromSuperview()
                scrollView.contentOffset = CGPointMake(self.bounds.width, 0)
                
            }
            
        }else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    
    // MARK: - UIScrollView Delegate
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        dispatch_async(dispatch_get_main_queue()) { 
            
            self.currentImageView.image = self.images[self.indexOfCurrent]
            
            scrollView.contentOffset = CGPointMake(self.frame.width, 0)
            
            self.nextImageView.removeFromSuperview()
            
        }
        
        
        
        //重置计时器
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(TimeInterval, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
    
}
