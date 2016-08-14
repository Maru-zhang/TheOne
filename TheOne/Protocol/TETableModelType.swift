//
//  TETableModelType.swift
//  TheOne
//
//  Created by Maru on 16/3/23.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

protocol TETableModelType: class {
    
    
    
    func numberOfSectionsInTableView() -> Int
    
    func table(view: UITableView, numberOfRows section: Int) -> Int
    
    func table(view: UITableView, cellForRow indexPath: NSIndexPath) -> UITableViewCell
    
    /**
     根据Index返回Cell的动态高度
     
     - parameter indexPath:	Cell的位置
     */
    func heightForCellAtIndexPath(indexPath: NSIndexPath) -> CGFloat
    
}

extension TETableBindHelper {
    
    func numberOfSectionsInTableView() -> Int {
        return 1
    }
    
    func table(view: UITableView, numberOfRows section: Int) -> Int {
        return 0
    }
    
    func heightForCellAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
}