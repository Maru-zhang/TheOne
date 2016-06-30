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
import ReactiveCocoa


class TEArticleController: UIViewController {
    
    var circleView: MARCarousel!
    var pageView: TEPageableView!
    var viewModel: TEArticleViewModel = TEArticleViewModel()
    
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
        
        pageView = TEPageableView(frame: CGRectMake(0, 180, view.frame.width, view.frame.height - 240))
        pageView.dataSource = self
        pageView.viewDelegate = self

        view.addSubview(circleView)
        view.addSubview(pageView)
        
    }
    
    private func setupBinding() {
        
        viewModel.fetchLastestData()
        
        viewModel.refreshComplete
            .delay(0.25, onScheduler: QueueScheduler.mainQueueScheduler)
            .startWithNext { [unowned self] in
            self.pageView.reloadData()
        }
        
        pageView.leftAction = { [unowned self] refresh in
            self.viewModel.fetchLastestData()
        }
        
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
        return viewModel.essays.value.count
    }
    
    func pageableView(pageView: TEPageableView, cardCellForColumnAtIndexPath indexPath: NSIndexPath) -> UIView {
        
        var cell = pageView.dequeueReusableCell() as? TEArticleTableView
        
        if cell == nil {
            cell = TEArticleTableView(frame: CGRectMake(10, 10, pageView.frame.width - 20, pageView.frame.height), style: .Plain)
            cell!.showsVerticalScrollIndicator = false
            cell!.tableFooterView =  UIView()
            cell!.estimatedRowHeight = 150
            cell!.rowHeight = UITableViewAutomaticDimension
            cell!.registerNib(UINib.init(nibName: "TEArticleCell", bundle: nil), forCellReuseIdentifier: String(TEArticleCell))
            cell!.delegate = self
            cell!.dataSource = self
        }
        
        
        return cell!
    }
    
    func pageableViewFrame(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect {
        
        return CGRectMake(10, 0, pageView.frame.width - 20, pageView.frame.height + 20)
    }
    
    func pageableViewWillShowReuseView(pageView: TEPageableView, reuseView: UIView) {
        (reuseView as! UITableView).reloadData()
        reuseView.setNeedsDisplay()
    }
    
}

extension TEArticleController: UITableViewDataSource,UITableViewDelegate {
    
    // MARK: - DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.essays.value.count == 0 ? 0 : 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(TEArticleCell), forIndexPath: indexPath) as! TEArticleCell
        
        var index: NSInteger = 0
        
        if pageView.contentOffset.x > view.frame.width * CGFloat(pageView.currentIndex) {
            index = pageView.currentIndex + 1
        }else if pageView.contentOffset.x < view.frame.width * CGFloat(pageView.currentIndex) {
            index = pageView.currentIndex - 1
        }else {
            index = pageView.currentIndex
        }
        
        if indexPath.row == 0 {
            cell.configureWithType(viewModel.essays.value[index])
        }else if indexPath.row == 1 {
            cell.configureWithType(viewModel.serials.value[index])
        }else {
            cell.configureWithType(viewModel.issue.value[index])
        }

        return cell
    }
    
    
    // MARK: - Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12)
        cell.layoutMargins = UIEdgeInsetsZero
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TEArticleCell
        
        let detailVC = TEArticleDetailController()
        
        switch cell.articleStyle {
        case .read:
            break
        case .serial:
            break
        case .question:
            break
        }
        
//        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    
}

