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
     指定列处，Cell所显示的Bounds大小
     
     - parameter indexPath:	指定位置的IndexPath
     
     - returns: CGRect
     */
//    func pageableViewBounds(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect
    
    /**
     指定列处，Cell所在的中心点
     
     - parameter indexPath:	指定位置的IndexPath
     
     - returns: CGPoint
     */
//    func pageableViewCenter(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGPoint
    
    /**
     指定列出，cell的位置
     
     - parameter pageView:	容器
     - parameter indexPath:	指定位置的IndexPath
     
     - returns: CGRect
     */
    func pageableViewFrame(pageView: TEPageableView,atIndexPath indexPath: NSIndexPath) -> CGRect
}


extension TEPageableDelegate {
    
    func pageableViewBounds(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect {
        return CGRectMake(0, 0, pageView.frame.width, pageView.frame.height)
    }
    
    func pageableViewCenter(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGPoint {
        return CGPointMake(pageView.frame.width / 2, pageView.frame.height / 2)
    }
}
