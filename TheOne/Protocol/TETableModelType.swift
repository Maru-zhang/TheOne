//
//  TETableModelType.swift
//  TheOne
//
//  Created by Maru on 16/3/23.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

protocol TETableModelType {
    
    associatedtype CellType

    
    /**
     根据传入的Cell和IndexPath来配置Cell
     
     - parameter cell:		需要更新的Cell
     - parameter indexPath:	需要更新的位置
     */
    func updateCell(cell: CellType,index: NSIndexPath)
    
    /**
     根据Index返回Cell的动态高度
     
     - parameter indexPath:	Cell的位置
     */
    func cellForHeightAtIndexPath(indexPath: NSIndexPath) -> CGFloat
}