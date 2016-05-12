//
//  TENetService.swift
//  TheOne
//
//  Created by Maru on 16/5/12.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import Alamofire

class TENetService {
    
    typealias SuccessHandler = () -> Void
    typealias FailureHandler = () -> Void
    
    private static let HOST = "http://v3.wufazhuce.com:8000"
    
    private struct API_Route {
        
        /**
         首页的API
         
         - parameter page:	页码
         
         - returns: URL的字符串
         */
        static func OneStuff(page: Int) -> String {
            return "\(TENetService.HOST)/api/hp/more/\(page)"
        }
    }
    
    
}

extension TENetService {
    /**
     获取最新的首页的图片文字等相关信息
     
     - parameter success:	成功回调
     - parameter fail:	失败回调
     */
    static func apiGetLatestOneStuff(withSuccessHandler success: SuccessHandler,failureHandler fail: FailureHandler) {
        
        
        
    }
    
    
    static func apiGetSpecifyOneStuff(page: Int,withSuccessHandler success: SuccessHandler,failureHandler fail: FailureHandler) {
        
        Alamofire.request(.GET, TENetService.API_Route.OneStuff(0))
            .response { (request, response, data, error) in
            
        }
    }
}