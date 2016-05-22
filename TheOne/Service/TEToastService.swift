//
//  TEToastService.swift
//  TheOne
//
//  Created by Maru on 16/5/22.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import JLToast


class TEToastService {
    
    /**
     当发现网络无法连接时显示的提示
     */
    static func showNetDisconnet() {
        JLToast.makeText("网络连接错误，请检查网络!").show()
    }
}