//
//  TEMusicController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ESPullToRefresh
import Kingfisher

class TEMusicController: UIViewController {
    
    var pageView: TEPageableView!
    let viewModel = TEMusicViewModel()
    

    override func viewDidLoad() {
        
        setupView()
        
        setupData()
    }
    
    
    // MARK: - Private Method
    func setupView() {
        
        setupCommentItem()
        pageView = TEPageableView(frame: self.view.bounds)
        pageView.dataSource = self
        pageView.viewDelegate = self
        
        view.addSubview(pageView)
        view.backgroundColor = UIColor.whiteColor()
        

    }
    
    
    func setupData() {
        
        viewModel.fetchIDList()
        
        viewModel.orders.producer
            .filter({ (orders) -> Bool in
                return orders.count != 0
            })
            .startWithNext { [unowned self] (_) in
                self.pageView.reloadData()
        }
        
        viewModel.contentCellType.signal
            .observeOn(QueueScheduler.mainQueueScheduler)
            .observeNext { [unowned self] (type) in
                let tableView = self.pageView.visibleCell.first as! UITableView
                tableView.reloadData()
        }
        
        combineLatest(viewModel.detail.signal, viewModel.relates.signal, viewModel.comments.signal)
            .observeOn(QueueScheduler.mainQueueScheduler)
            .filter { (details, relateds, comments) -> Bool in
            return details != nil && relateds.count != 0 && comments.count != 0
        }.observeNext { [unowned self] (_, _, _) in
            let tableView = self.pageView.visibleCell.first as! UITableView
            tableView.es_stopLoadingMore()
            tableView.reloadData()
        }

        viewModel.commentsSignal.observeCompleted { [unowned self] in
            let tableView = self.pageView.visibleCell.first as! UITableView
            tableView.es_stopLoadingMore()
            tableView.es_resetNoMoreData()
        }
        
        
    }
}

extension TEMusicController: TEPageableDataSource,TEPageableDelegate {
    
    // MARK: - Pageable Datasource
    func pageableView(pageView: TEPageableView) -> NSInteger {
        
        return viewModel.orders.value.count
    }
    
    func pageableView(pageView: TEPageableView, cardCellForColumnAtIndexPath indexPath: NSIndexPath) -> UIView {
        
        var cell = pageView.dequeueReusableCell() as? UITableView
        
        if cell == nil {
            
            cell = UITableView(frame: CGRectZero, style: .Plain)
            cell!.dataSource = self
            cell!.delegate = self
            cell!.estimatedRowHeight = 70.0
            cell!.separatorInset = UIEdgeInsetsZero
            cell!.layoutMargins = UIEdgeInsetsZero
            cell!.tableFooterView = UIView()
            cell?.registerClass(TEHeaderCell.self, forCellReuseIdentifier: String(TEHeaderCell))
            cell!.registerClass(TEContentCell.self, forCellReuseIdentifier: String(TEContentCell))
            cell!.registerClass(TEButtonLineCell.self, forCellReuseIdentifier: String(TEButtonLineCell))
            cell!.registerClass(TERelatedMusicCell.self, forCellReuseIdentifier: String(TERelatedMusicCell))
            cell!.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
            cell!.registerNib(UINib.init(nibName: String(TECommentCell), bundle: nil), forCellReuseIdentifier: String(TECommentCell))
            cell?.es_addInfiniteScrolling(handler: { [unowned self] in
                self.viewModel.fetchCurrentComment()
            })
            
        }
        
        return cell!
    }
    
    // MARK: - Pageable Delegate
    func pageableViewFrame(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect {
        return view.bounds
    }
    
    func pageableViewWillShowReuseView(pageView: TEPageableView, reuseView: UIView) {
        dispatch_async(dispatch_get_main_queue()) {
            (reuseView as! UITableView).reloadData()
        }
    }
    
    func pageableViewDidEndScroll(pageView: TEPageableView, toIndexPath indexPath: NSIndexPath) {
        viewModel.pageToIndex(indexPath.indexAtPosition(0))
    }
    
    
}

extension TEMusicController: UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if pageView.visibleCell.count == 1 {
            return 3
        }else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        case 2:
            return viewModel.comments.value.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(String(TEHeaderCell), forIndexPath: indexPath) as! TEHeaderCell
                cell.configWithEntity(viewModel.detail)
                cell.storyAction = { [unowned self] obj in
                    self.viewModel.contentCellType.value = TEContentType.story
                }
                cell.lyricsAction = { [unowned self] obj in
                    self.viewModel.contentCellType.value = TEContentType.lyrics
                }
                cell.infoAction = { [unowned self] obj in
                    self.viewModel.contentCellType.value = TEContentType.info
                }
                cell.titleName.text = viewModel.contentCellType.value.rawValue
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier(String(TEContentCell), forIndexPath: indexPath) as! TEContentCell
                cell.displayType = viewModel.contentCellType.value
                cell.configWithEntity(viewModel.detail.value)
                return cell
            }else {
                let cell = tableView.dequeueReusableCellWithIdentifier(String(TEButtonLineCell), forIndexPath: indexPath) as! TEButtonLineCell
                cell.configWithEntity(viewModel.detail.value)
                return cell
            }
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(TERelatedMusicCell), forIndexPath: indexPath) as! TERelatedMusicCell
            cell.configWithEntitys(viewModel.relates.value)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(TECommentCell), forIndexPath: indexPath) as! TECommentCell
            let entity: TEComment = viewModel.comments.value[indexPath.row]
            cell.configWithComment(entity)
            return cell
            
        default:
            return tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)

        }
    }
    
    // MARK: - Delegate
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "相似歌曲"
        case 2:
            return "评论列表"
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            return TEConfigure.musicHeaderViewForSection("相似歌曲")
        case 2:
            return TEConfigure.musicHeaderViewForSection("评论列表")
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 500
            }else if indexPath.row == 1 {
                return UITableViewAutomaticDimension
            }else {
                return 44
            }
        case 1:
            return 150
        case 2:
            return UITableViewAutomaticDimension
        default:
            return 70
        }
    }

}