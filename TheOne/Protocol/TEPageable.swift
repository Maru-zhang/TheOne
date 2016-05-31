//
//  TEPageAble.swift
//  TheOne
//
//  Created by Maru on 16/3/15.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation

protocol TEPageable {
    
    associatedtype PageType
    
    var containner: UIScrollView! { get set }
    var pre_card: PageType! { get set }
    var cur_card: PageType! { get set }
    var nex_card: PageType! { get set }
    
    func configPageable()
}
