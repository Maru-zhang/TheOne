//
//  TEArticleController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher


class TEArticleController: UIViewController {
    
    var circleView: CirCleView!

    override func viewDidLoad() {
        
        setupCommonProperty()
        
        setupView()
    }
    
    func setupView() {
        
        title = "阅读"
        
        let a = MARCarousel(frame: CGRectMake(0, 300, view.frame.width, 140))
        a.images = [UIImage(named: "banner-1")!,UIImage(named: "banner-2")!,UIImage(named: "banner-3")!]
        view.addSubview(a)
        
        // 开始轮播资源进行请求
        TENetService.apiGetArtcleCarousel(withSuccessHandler: { (imgResult) in
            
            let urls: [NSURL] = imgResult.map{ NSURL(string: $0.cover!)! }
            
            ImagePrefetcher(urls: urls, optionsInfo: nil, progressBlock: nil, completionHandler: { (skippedResources, failedResources, completedResources) in
                
                
                let imgs: [UIImage] = skippedResources.map({ (resource) -> UIImage in
                    return ImageCache.defaultCache.retrieveImageInDiskCacheForKey(resource.cacheKey)!
                })

                self.circleView = CirCleView(frame: CGRectMake(0, 0, self.view.frame.size.width, 180), imageArray: imgs)
                
                self.view.addSubview(self.circleView)
                
            }).start()
            
        }) { (error) in
            debugPrint(error)
        }
        
        
        
        
        
    }
}
