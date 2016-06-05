//
//  TEPageAble.swift
//  TheOne
//
//  Created by Maru on 16/3/15.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation

protocol TEPageableDataSource: NSObjectProtocol {
    
    /**
     总共需要显示多少列的视图
     
     - parameter pageView:	负责显示的PageView
     
     - returns: 显示的视图数量
     */
    func pageableView(pageView: TEPageableView) -> NSInteger
    
    /**
     返回需要显示的Cell的视图对象
     
     - parameter pageView:						负责显示的PageView
     - parameter cardCellForColumnAtIndexPath:	在PageView中显示的子视图
     
     - returns: 子视图
     */
    func pageableView(pageView: TEPageableView, cardCellForColumnAtIndexPath indexPath: NSIndexPath) -> UIView
    
}


protocol TEPageableDelegate: NSObjectProtocol {
    
    /**
     指定列出，cell的位置
     
     - parameter pageView:	容器
     - parameter indexPath:	指定位置的IndexPath
     
     - returns: CGRect
     */
    func pageableViewFrame(pageView: TEPageableView,atIndexPath indexPath: NSIndexPath) -> CGRect
    
    /**
     当滚动视图滚动完成后调用该函数，反馈现在的滚动位置
     
     - parameter pageView:	容器
     - parameter indexPath:	滚动待的IndexPath位置
     */
    func pageableViewDidScroll(pageView: TEPageableView, toIndexPath indexPath: NSIndexPath)
}


extension TEPageableDelegate {
    
    func pageableViewFrame(pageView: TEPageableView,atIndexPath indexPath: NSIndexPath) -> CGRect {
        return CGRectMake(0, 0, pageView.frame.width, pageView.frame.height)
    }
    
    func pageableViewDidScroll(pageView: TEPageableView, toIndexPath indexPath: NSIndexPath) {
        
    }
    
}
