//
//  MARCarousel.swift
//  TheOne
//
//  Created by Maru on 16/5/13.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

public class MARCarousel: UIView {

    private enum MARDirection {
        case Left,Right
    }
    
    /// All images to show
    public dynamic var images: [UIImage]!
    /// Imgs Container
    private var scrollView: UIScrollView!
    /// Current Image to show
    private var currentImageView: UIImageView!
    /// Last Image to show
    private var lastImageView: UIImageView!
    /// Next Image to Show
    private var nextImageView: UIImageView!
    /// The pageIndicator
    private var pageIndicator: UIPageControl!
    /// The time Manager
    private var timer: Timer?
    /// Default time duration
    public var duration: TimeInterval!
    /// Call back when user touch event,Default is nil
    public var touchEventColsure: ((Int) -> Void)?
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
    
    deinit {
        removeObserver(self, forKeyPath: "images")
    }
    
    // MARK: - Public Method

    
    // MARK: - Private method
    private func setup() {
        
        duration = 2.5
        images = [UIImage]()
        touchEventColsure = nil
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.contentSize = CGSize.init(width: self.frame.width * 3, height: self.frame.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        
        currentImageView = UIImageView.init(frame: CGRect(x: self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        currentImageView.isUserInteractionEnabled = true
        currentImageView.contentMode = .scaleToFill
        currentImageView.clipsToBounds = true
        
        lastImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        lastImageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        lastImageView.isUserInteractionEnabled = true
        lastImageView.contentMode = .scaleToFill
        lastImageView.clipsToBounds = true

        nextImageView = UIImageView(frame: CGRect.init(x: self.frame.size.width * 2.0, y: self.frame.size.width, width: self.frame.size.width, height: self.frame.height))
        nextImageView.isUserInteractionEnabled = true
        nextImageView.contentMode = .scaleToFill
        nextImageView.clipsToBounds = true
        
        pageIndicator = UIPageControl()
        pageIndicator.hidesForSinglePage = true
        pageIndicator.backgroundColor = UIColor.clear
        pageIndicator.frame = CGRect.init(x: 0, y: self.frame.height - 40, width: self.frame.width, height: 40)
        pageIndicator.numberOfPages = images.count
        pageIndicator.currentPage = 0
        
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        addSubview(scrollView)
        addSubview(pageIndicator)
        scrollView.addSubview(currentImageView)
        scrollView.addSubview(nextImageView)
        scrollView.addSubview(lastImageView)
        
        addObserver(self, forKeyPath: "images", options: .new, context: &MAR_Context)
        
    }
    
    private func beginTimer() {
        
        
        guard images.count > 1 else {
            return
        }
        
        if timer != nil { stopTimer() }
        
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTime() {
        
        scrollToSpecifyDirection(direction: .Left)
    }
    
    /**
     重置图片设置
     */
    private func resetImageView() {
        currentImageView.image = images[indexOfCurrent]
//        nextImageView.image = images[getLastOrNextIndex(false)]
//        lastImageView.image = images[getLastOrNextIndex(true)]
    }
    
    /**
     获取前一个或者后一个的Index
     
     - parameter last:	True为前一个，反之亦然
     
     - returns: Index
     */
    private func getLastOrNextIndex(last: Bool) -> Int {
        if last {
            return (self.indexOfCurrent + self.images.count - 1) % self.images.count
        }else {
            return (self.indexOfCurrent + 1) % self.images.count
        }
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
            
            self.scrollView.setContentOffset(CGPoint.init(x: self.frame.width * 2, y: 0), animated: true)
            
        }else {
            
            self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }
        
    }
    
    
    // MARK: - Override
    public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutableRawPointer) {
        
        if (context == &MAR_Context) && (keyPath == "images") {
            
            if let newValue = change![NSKeyValueChangeNewKey]{
            
                let newImages = newValue as! [UIImage]
                
                indexOfCurrent = 0
                pageIndicator.numberOfPages = newImages.count
                resetImageView()
                scrollView.contentOffset = CGPoint.init(x: self.bounds.width, y: 0)
            }
            
        }else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change as! [NSKeyValueChangeKey : Any]?, context: context)
        }
    }

    
}

extension MARCarousel: UIScrollViewDelegate {
    
    // MARK: - UIScrollView Delegate
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
                
        if scrollView.contentOffset.x == 0 {
            indexOfCurrent = getLastOrNextIndex(true)
        }else if scrollView.contentOffset.x == scrollView.frame.size.width * 2 {
            indexOfCurrent = getLastOrNextIndex(false)
        }else {
            beginTimer()
            return
        }
        
        resetImageView()
        
        scrollView.setContentOffset(CGPointMake(self.frame.size.width, 0), animated: false)
        
        beginTimer()
    }
    
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        scrollViewDidEndDecelerating(scrollView)
        
    }
}
