//
//  TENetService.swift
//  TheOne
//
//  Created by Maru on 16/5/12.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import ReactiveCocoa
import Result

class TENetService {
    
    typealias SuccessHandler = ([Any]) -> Void
    typealias FailureHandler = (NSError) -> Void
    
    /// 主机域名
    private static let HOST = "http://v3.wufazhuce.com:8000"

    /**
     *	API路由集合
     *
     *	@since 0.1.0
     */
    private struct API_Route {
        
        
        // MARK: - Home API
        
        /**
         最新的首页API
         
         - returns: URL的字符串
         */
        static func Home_Stuff() -> String {
            return "\(TENetService.HOST)/api/hp/more/0)"
        }
        
        /**
         首页广告的API
         
         - returns: URL的字符串
         */
        static func Home_AD() -> String {
            return "\(TENetService.HOST)/api/adlist/ios"
        }
        
        
        // MARK: - Read API
        
        /**
         阅读模块的轮播API
         
         - returns: URL的字符串
         */
        static func Read_Carousel() -> String {
            return "\(TENetService.HOST)/api/reading/carousel"
        }
        
        /**
         阅读模块的首页API
         
         - returns: URL的字符串
         */
        static func Read_Index() -> String {
            return "\(TENetService.HOST)/api/reading/index"
        }
        
        // MARK: - Music API
        
        /**
         获取音乐故事的列表
         
         - parameter page:	页码
         
         - returns: URL的字符串
         */
        static func Music_List(page: Int) -> String {
            return "\(TENetService.HOST)/api/music/idlist/\(page)"
        }
        
        /**
         根据音乐故事的ID获取详细信息
         
         - parameter id:	音乐故事的ID
         
         - returns: URL的字符串
         */
        static func Music_Detail(id: Int) -> String {
            return "\(TENetService.HOST)/api/music/detail/\(id)"
        }
        
        /**
         根据音乐故事的ID获取相关的信息
         
         - parameter id:	音乐故事的ID
         
         - returns: URL的字符串
         */
        static func Music_Related(id: Int) -> String {
            return "\(TENetService.HOST)/api/related/music/\(id)"
        }
        
        /**
         根据音乐故事的ID
         
         - parameter id:	音乐故事的ID
         - parameter page:	页码
         
         - returns: URL的字符串
         */
        static func Music_Comment(id: Int,page: Int) -> String {
            return "\(TENetService.HOST)/api/comment/praiseandtime/music/\(id)/\(page)"
        }
        
        // MARK: - Movie API
        
        /**
         根据页码获取电影列表
         
         - parameter page:	页码
         
         - returns: URL的字符串
         */
        static func Movie_List(page: Int) -> String {
            return "\(TENetService.HOST)/api/movie/list/\(page)"
        }
        
        /**
         根据页码过去电影的详细信息
         
         - parameter id:	电影的ID
         
         - returns: URL的字符串
         */
        static func Movie_Detail(id: Int) -> String {
            return "\(TENetService.HOST)/api/movie/detail/\(id)"
        }
        
        /**
         根据电影ID和页码获取评论数据
         
         - parameter id:	电影ID
         - parameter page:	页码
         
         - returns: URL的字符串
         */
        static func Movie_Comment(id: Int,page: Int) -> String {
            return "\(TENetService.HOST)api/comment/praiseandtime/movie/\(id)/\(page)"
        }
        
        /**
         根据电影ID获取相应的电影故事
         
         - parameter id:	电影ID
         
         - returns: 页码
         */
        static func Movie_Story(id: Int) -> String {
            return "\(TENetService.HOST)/api/movie/\(id)/story/1/0"
        }
        
    }
    
    
}

extension TENetService {
    
    
    // MARK: - Home Service
    
    /**
     获取最新的首页的图片文字等相关信息
     
     - parameter success:	成功回调
     - parameter fail:	失败回调
     */
    static func apiGetLatestOneStuff(withSuccessHandler result: (SignalProducer<[TEPaperModel],NSError>) -> ()) {
        
        apiGetSpecifyOneStuff(API_Route.Home_Stuff()) { (signal) in
            result(signal)
        }
    }
    
    
    /**
     获取指定的页码的首页图片相关的信息
     
     - parameter url:	指定的地址
     - parameter result:	结果的回调
     
     */
    private static func apiGetSpecifyOneStuff(url: String,withResult result: (SignalProducer<[TEPaperModel],NSError>) -> ()) {
        
        Alamofire.request(.GET, url)
            .responseJSON { (response) in
            
                switch response.result {
                
                case .Success(_):
                    
                    let json = JSON(response.result.value!)
                    
                    let pagers: [TEPaperModel] = Mapper<TEPaperModel>().mapArray(json["data"].rawString())!
                    
                    result(SignalProducer(value: pagers))
 
                    break
                case .Failure(_):
                    
                    break
                }
        }
    }
    
    // MARK: - Article Service
    static func apiGetArtcleCarousel(withSuccessHandler success: ([TECarousel]) -> Void,fail: FailureHandler) {
        
        Alamofire.request(.GET, API_Route.Read_Carousel()).responseJSON { (response) in
            
            switch response.result {
            case .Success(_):
                
                let json = JSON(response.result.value!)
                
                let modelArr: [TECarousel] = Mapper<TECarousel>().mapArray(json["data"].rawString())!
                
                success(modelArr)
                
                break
            case .Failure(_):
                fail(response.result.error!)
                break
            }
        }
        
    }
    
    /**
     Get the latest articles from server
     
     - parameter result:	冷信号
     */
    static func apiGetArticleIndex(result: (SignalProducer<[TEArticle],NSError>) -> Void) {
        Alamofire.request(.GET, API_Route.Read_Index())
            .responseJSON { (response) in
                switch response.result {
                case .Success(_):
                    let json = JSON(response.result.value!)
                    
                    let models: [TEArticle] = Mapper<TEArticle>().mapArray(json["data"]["essay"].rawString())!
                    
                    result(SignalProducer(value: models))
                    
                    break
                case .Failure(_):
                    result(SignalProducer<[TEArticle],NSError>(error: response.result.error!))
                    break
                }
        }
    }
    
    // MARK: - Music Service
    
    // MARK: - Movie Service
    
    /**
     获取电影的评分列表
     
     - parameter page:	页码
     - parameter success:	成功请求回调
     - parameter fail:	失败请求回调
     */
    static func apiGetSpecifyMoiveListwithResultSignalProducer(page: Int,result: (SignalProducer<[TEMovieCardModel],NSError>) -> Void) {
        
        Alamofire.request(.GET, API_Route.Movie_List(page)).responseJSON { (response) in
            
            switch response.result {
            case .Success(_):
                
                let json = JSON(response.result.value!)
                
                let modelArr: [TEMovieCardModel] = Mapper<TEMovieCardModel>().mapArray(json["data"].rawString())!
                
                result(SignalProducer(value: modelArr))
                
                break
            case .Failure(_):
                result(SignalProducer<[TEMovieCardModel],NSError>(error: response.result.error!))
                break
            }
        }
    }
    
    
}