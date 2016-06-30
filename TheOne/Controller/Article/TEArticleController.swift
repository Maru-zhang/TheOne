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
    var carouselModels: [TECarousel] = []
    var reuseHeight: [CGFloat] = [0,0,0]
    
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
        TENetService.apiGetArtcleCarousel(withSuccessHandler: { [unowned self] (imgResult) in
            
            let urls: [NSURL] = imgResult.map{ NSURL(string: $0.cover!)! }
            
            self.carouselModels = imgResult
            
            self.circleView.touchEventColsure = { index in
                self.presentVC(TERankTableController.init(model: self.carouselModels[index]))
            }
            
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
        
        var cell = pageView.dequeueReusableCell() as? UIScrollView
        
        if cell == nil {
            
            cell = UIScrollView()
            cell?.contentSize = CGSizeMake(view.frame.width , 700)
            cell?.backgroundColor = UIColor.whiteColor()
            cell?.showsVerticalScrollIndicator = false
            cell?.showsHorizontalScrollIndicator = false
            
            let pannel = UITableView(frame: CGRectMake(10, 10, view.frame.width - 20, 550))
            pannel.backgroundColor = UIColor.whiteColor()
            pannel.estimatedRowHeight = 150
            pannel.dataSource = self;
            pannel.delegate = self;
            pannel.registerNib(UINib.init(nibName: "TEArticleCell", bundle: nil), forCellReuseIdentifier: String(TEArticleCell))
            pannel.tableFooterView = UIView()
            pannel.scrollEnabled = false;
            pannel.scrollsToTop = false;
            pannel.translatesAutoresizingMaskIntoConstraints = true;
            pannel.layer.masksToBounds = false;
            pannel.layer.shadowColor = UIColor.blackColor().CGColor;
            pannel.layer.shadowRadius = 2;
            pannel.layoutMargins = UIEdgeInsetsZero
            pannel.separatorInset = UIEdgeInsetsZero
            pannel.layer.shadowOffset = CGSizeZero;
            pannel.layer.shadowOpacity = 0.5;
            pannel.layer.cornerRadius = 5;
            
            cell?.addSubview(pannel)
        }
        
        
        return cell!
    }
    
    func pageableViewFrame(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect {
        
        return CGRectMake(0, 0, pageView.frame.width, pageView.frame.height)
    }
    
    func pageableViewWillShowReuseView(pageView: TEPageableView, reuseView: UIView, indexPath: NSIndexPath) {
        let scrollview = reuseView as! UIScrollView
        let tableView = reuseView.subviews[0] as! UITableView
        scrollview.setContentOffset(CGPointZero, animated: false)
        tableView.reloadData()
        dispatch_async(dispatch_get_main_queue()) {
            // MARK: TODO - 这里有性能问题
            let height = (tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0))?.frame.height)! + (tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 1, inSection: 0))?.frame.height)! + (tableView.cellForRowAtIndexPath(NSIndexPath.init(forRow: 2, inSection: 0))?.frame.height)!
            let newHeight = self.reuseHeight.reduce(0, combine: +)
            tableView.frame = CGRectMake(10, 10, self.view.frame.width - 20, height)
            scrollview.contentSize = CGSizeMake(self.view.frame.width, height + 200)
        }
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
        return UITableViewAutomaticDimension
    }

    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        reuseHeight[indexPath.row] = cell.frame.height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TEArticleCell
        
        dispatch_async(dispatch_get_main_queue()) { 
            switch cell.articleStyle {
            case .read:
                let detailVC = TEArticleDetailController(list: self.viewModel.essays.value, index: self.pageView.currentIndex)
                self.navigationController?.pushViewController(detailVC, animated: true)
                break
            case .serial:
                let detailVC = TEArticleDetailController(list: self.viewModel.serials.value, index: self.pageView.currentIndex)
                self.navigationController?.pushViewController(detailVC, animated: true)
                break
            case .question:
                let detailVC = TEArticleDetailController(list: self.viewModel.issue.value, index: self.pageView.currentIndex)
                self.navigationController?.pushViewController(detailVC, animated: true)
                break
            }
        }

    }
    
    
    
}

