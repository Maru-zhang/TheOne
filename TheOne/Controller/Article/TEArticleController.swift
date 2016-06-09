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
        
        pageView = TEPageableView(frame: CGRectMake(0, 180, view.frame.width, view.frame.height - 224))
        pageView.dataSource = self
        pageView.viewDelegate = self
        pageView.reloadData()
        
        view.addSubview(circleView)
        view.addSubview(pageView)
        
    }
    
    private func setupBinding() {
                
        viewModel.refreshSignal.startWithNext { [unowned self] in
            self.viewModel.fetchLastestData({ 
                self.pageView.reloadData()
            })
        }
        
        viewModel.refreshObserver.sendNext()
        
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
        
        var cell = pageView.dequeueReusableCell() as? TECardPageView
        
        if cell == nil {
            cell = TECardPageView()
            let table = TEArticleTableView(frame: CGRectMake(0, 0, pageView.frame.width - 20, pageView.frame.height - 20), style: .Plain)
            table.registerClass(TEArticleCell.self, forCellReuseIdentifier: String(TEArticleCell))
            table.delegate = self
            table.dataSource = self
            cell?.addSubview(table)
        }
        
        
        return cell!
    }
    
    func pageableViewFrame(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect {
        return CGRectMake(10, 10, pageView.frame.width - 20, pageView.frame.height - 20)
    }
    
    func pageableViewDidScroll(pageView: TEPageableView, toIndexPath indexPath: NSIndexPath) {
        
        let tableView = pageView.visibleCell[0].subviews[0] as! UITableView
        tableView.reloadData()
    }
    
}

extension TEArticleController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.essays.value.count == 0 {
            return 0
        }else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(TEArticleCell), forIndexPath: indexPath) as! TEArticleCell
        
        if indexPath.row == 0 {
            cell.title.text = viewModel.essays.value[pageView.currentIndex].hp_title
            cell.author.text = "dsa"
            cell.hotLine.text = viewModel.essays.value[pageView.currentIndex].guide_word
            cell.articleStyle = .read;
        }else if indexPath.row == 1 {
            cell.title.text = viewModel.serials.value[pageView.currentIndex].title
            cell.hotLine.text = viewModel.serials.value[pageView.currentIndex].excerpt
            cell.articleStyle = .serial
        }else {
            cell.title.text = viewModel.issue.value[pageView.currentIndex].question_title
            cell.hotLine.text = viewModel.issue.value[pageView.currentIndex].answer_content
            cell.articleStyle = .question
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12)
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    
}

