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
    
    typealias itemType = UIView
    
    var currentPage: Int
    weak var agent: TEPageable?
    
    // MARK: - Life Cycle
    
    
    override init(frame: CGRect) {
        currentPage = 0
        super.init(frame: frame)
        self.bounces = true
        self.delegate = self
        self.contentSize = CGSizeMake(frame.width * 10, frame.height + 100)
        self.backgroundColor = UIColor.clearColor()
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.directionalLockEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

}

extension TEPageableView {
    
    // MARK: - Public Method
    func register() {
        typealias aaa = Int
    }
}

extension TEPageableView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // Make sure that scrollView only scrollenable in one direction once
        if (scrollView.contentOffset.x != 0 &&
            scrollView.contentOffset.y != 0) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }
        
        // Make sure that page only in horizontal direation
        if scrollView.contentOffset.x > 0 || scrollView.contentOffset.x < 0 {
            scrollView.pagingEnabled = true
        }else {
            scrollView.pagingEnabled = false
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
