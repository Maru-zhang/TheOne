//
//  TETableModelType.swift
//  TheOne
//
//  Created by Maru on 16/3/23.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

protocol TETableModelType {
    
    
    /**
     根据传入的Cell和IndexPath来配置Cell
     
     - parameter cell:		<#cell description#>
     - parameter indexPath:	<#indexPath description#>
     */
    func updateCell(cell: UITableViewCell,indexPath: NSIndexPath)
}