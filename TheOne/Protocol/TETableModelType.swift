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
    
    func numberOfRows(inSection section: Int) -> Int
    
    /**
     根据Index返回Cell的动态高度
     
     - parameter indexPath:	Cell的位置
     */
    func heightForCellAtIndexPath(indexPath: NSIndexPath) -> CGFloat
    
    /**
     发送网络请求，返回相应的实体数据或者失败回调
     
     - parameter success:	成功回调
     - parameter failure:	失败回调
     */
    func fetchRemoteDataWithCallBack<Error: NSError>(success: () -> Void,failure: (Error) -> Void)
}