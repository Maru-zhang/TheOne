//
//  TEMusicController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveSwift
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
        view.backgroundColor = UIColor.white
        

    }
    
    
    func setupData() {
        
        viewModel.fetchIDList()
        
        viewModel.orders.producer
            .filter({ (orders) -> Bool in
                return orders.count != 0
            })
            .startWithValues { [unowned self] (_) in
                self.pageView.reloadData()
        }
        
        viewModel.contentCellType.signal
            .observe(on: QueueScheduler.main)
            .observeValues { [unowned self] (type) in
                let tableView = self.pageView.visibleCell.first as! UITableView
                tableView.reloadData()
        }
        
        Signal.combineLatest(viewModel.detail.signal, viewModel.relates.signal, viewModel.comments.signal)
            .observe(on: QueueScheduler.main)
            .filter { (details, relateds, comments) -> Bool in
            return details != nil && relateds.count != 0 && comments.count != 0
        }.observeValues { [unowned self] (_, _, _) in
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
            
            cell = UITableView(frame: CGRect.zero, style: .plain)
            cell!.dataSource = self
            cell!.delegate = self
            cell!.estimatedRowHeight = 70.0
            cell!.separatorInset = UIEdgeInsets.zero
            cell!.layoutMargins = UIEdgeInsets.zero
            cell!.tableFooterView = UIView()
            cell?.register(TEHeaderCell.self, forCellReuseIdentifier: String(describing: TEHeaderCell.self))
            cell!.register(TEContentCell.self, forCellReuseIdentifier: String(describing: TEContentCell.self))
            cell!.register(TEButtonLineCell.self, forCellReuseIdentifier: String(describing: TEButtonLineCell()))
            cell!.register(TERelatedMusicCell.self, forCellReuseIdentifier: String(describing: TERelatedMusicCell.self))
            cell!.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
            cell!.register(UINib.init(nibName: String(describing: TECommentCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TECommentCell.self))
            let _ = cell?.es_addInfiniteScrolling(handler: { [unowned self] in
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
        
        DispatchQueue.main.async {
            (reuseView as! UITableView).setContentOffset(CGPoint.zero, animated: false)
            (reuseView as! UITableView).reloadData()
        }
    }
    
    func pageableViewDidEndScroll(pageView: TEPageableView, toIndexPath indexPath: NSIndexPath) {
        viewModel.pageToIndex(page: indexPath.index(atPosition: 0))
    }
    
    
}

extension TEMusicController: UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - DataSource
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if pageView.visibleCell.count == 1 {
            return 3
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TEHeaderCell.self), for: indexPath) as! TEHeaderCell
                cell.configWithEntity(entity: viewModel.detail)
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
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TEContentCell()), for: indexPath) as! TEContentCell
                cell.displayType = viewModel.contentCellType.value
                cell.configWithEntity(entity: viewModel.detail.value)
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TEButtonLineCell()), for: indexPath) as! TEButtonLineCell
                cell.configWithEntity(entity: viewModel.detail.value)
                return cell
            }
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TERelatedMusicCell()), for: indexPath) as! TERelatedMusicCell
            cell.configWithEntitys(entitys: viewModel.relates.value)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TECommentCell()), for: indexPath) as! TECommentCell
            let entity: TEComment = viewModel.comments.value[indexPath.row]
            cell.configWithComment(comment: entity)
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell()), for: indexPath)

        }
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            return TEConfigure.musicHeaderViewForSection(title: "相似歌曲")
        case 2:
            return TEConfigure.musicHeaderViewForSection(title: "评论列表")
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
