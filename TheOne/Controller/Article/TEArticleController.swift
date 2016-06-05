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
    
    var circleView: MARCarousel!
    var pageView: TEPageableView!
    
    override func viewDidLoad() {
        
        setupUI()
        
        setupBinding()
    }
    
}


extension TEArticleController {
    
    // MARK: - Private Method 
    private func setupUI() {
        
        setupCommentItem()
        
        view.backgroundColor = UIColor.whiteColor()
        
        circleView = MARCarousel(frame: CGRectMake(0, 0, view.frame.width, 180))
        circleView.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(circleView)
        
        pageView = TEPageableView(frame: CGRectMake(0, 180, view.frame.width, view.frame.height - 224))
        pageView.dataSource = self
        pageView.viewDelegate = self
        view.addSubview(pageView)
        
    }
    
    private func setupBinding() {
        
        // 开始轮播资源进行请求
        TENetService.apiGetArtcleCarousel(withSuccessHandler: { (imgResult) in
            
            let urls: [NSURL] = imgResult.map{ NSURL(string: $0.cover!)! }
            
            ImagePrefetcher(urls: urls, optionsInfo: nil, progressBlock: nil, completionHandler: { (skippedResources, failedResources, completedResources) in
                
                let imgs: [UIImage] = skippedResources.map({ (resource) -> UIImage in
                    return ImageCache.defaultCache.retrieveImageInDiskCacheForKey(resource.cacheKey)!
                })
                
                self.circleView.images = imgs
                
            }).start()
            
        }) { (error) in
            debugPrint(error)
        }
    }
}

extension TEArticleController: TEPageableDataSource,TEPageableDelegate {
    
    
    func pageableView(pageView: TEPageableView) -> NSInteger {
        return 5
    }
    
    func pageableView(pageView: TEPageableView, cardCellForColumnAtIndexPath indexPath: NSIndexPath) -> UIView {
        
        var cell = pageView.dequeueReusableCell() as? UITableView
        
        if cell == nil { cell = TEArticleTableView() }
        
        cell?.dataSource = self
        cell?.delegate = self
        
        return cell!
    }
    
    func pageableViewFrame(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect {
        return CGRectMake(10, 10, pageView.frame.width - 20, pageView.frame.height - 20)
    }
    
}

extension TEArticleController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return TEArticleCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    
}

