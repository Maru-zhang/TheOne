//
//  TEMovieDetailController.swift
//  TheOne
//
//  Created by Maru on 16/4/4.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TEMovieDetailController: UITableViewController {

    let viewModel: TEMovieDetailViewModel
    
    // MARK: - Life Cycle
    
    init(model: TEMovieDetailViewModel) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
        self.title = viewModel.title.value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        setupUI()
        
        setupBinding()
    }
    

    private func setupUI() {
        
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.estimatedRowHeight = 70
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
        tableView.registerClass(TEMovieHeaderCell.self, forCellReuseIdentifier: String(TEMovieHeaderCell))
        tableView.registerClass(TEMovieUtilCell.self, forCellReuseIdentifier: String(TEMovieUtilCell))
        tableView.registerClass(TEMovieStoryCell.self, forCellReuseIdentifier: String(TEMovieStoryCell))
        tableView.registerClass(TEKeywordCell.self, forCellReuseIdentifier: String(TEKeywordCell))
        tableView.registerNib(UINib.init(nibName: String(TECommentCell), bundle: nil), forCellReuseIdentifier: String(TECommentCell))
        
        tableView.es_addInfiniteScrolling { [unowned self] in
            self.viewModel.fetchCommentList()
        }
        
    }
    
    private func setupBinding() {
        
        combineLatest(viewModel.detail.signal, viewModel.story.signal, viewModel.comments.signal)
            .filter { (detal, story, comments) -> Bool in
                return (detal != nil && story != nil && comments.count != 0)
            }
            .observeOn(QueueScheduler.mainQueueScheduler)
            .observeNext { [unowned self] (_, _, _) in
                self.tableView.reloadData()
        }

        
        viewModel.commentsSignal
            .observeOn(QueueScheduler.mainQueueScheduler)
            .observeNext { [unowned self] (_) in
                self.tableView.es_stopLoadingMore()
                self.tableView.reloadData()
        }
        
        viewModel.commentsSignal
            .observeOn(QueueScheduler.mainQueueScheduler)
            .observeCompleted { [unowned self] in
                self.tableView.es_noticeNoMoreData()
        }
    }
}

extension TEMovieDetailController {
    
    // MARK: - DataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return viewModel.story.value.count
        case 2:
            if viewModel.detail.value != nil {
                return 1
            }else {
                return 0
            }
        case 3:
            return viewModel.comments.value.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier(String(TEMovieHeaderCell), forIndexPath: indexPath) as! TEMovieHeaderCell
                cell.configWithEntity(viewModel.detail.value)
                return cell
            }else {
                return tableView.dequeueReusableCellWithIdentifier(String(TEMovieUtilCell), forIndexPath: indexPath)
            }
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(TEMovieStoryCell), forIndexPath: indexPath)  as! TEMovieStoryCell
            cell.configWithEntity(viewModel.story.value.first!)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(TEKeywordCell), forIndexPath: indexPath) as! TEKeywordCell
            cell.configWithKeyword((viewModel.detail.value?.keywords!)!)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(TECommentCell), forIndexPath: indexPath) as! TECommentCell
            
            cell.configWithComment(viewModel.comments.value[indexPath.row])
            return cell
        default:
            return tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
        }
    }
    
    // MARK: - Delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return indexPath.row == 0 ? 200 : 40
        case 2:
            return 126
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 44
        case 2:
            return 44
        case 3:
            return 44
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return TEConfigure.musicHeaderViewForSection("电影故事")
        case 2:
            return TEConfigure.musicHeaderViewForSection("一个电影表")
        case 3:
            return TEConfigure.musicHeaderViewForSection("评论列表")
        default:
            return nil
        }
    }
    
}

extension TEMovieDetailController {
    
    // MARK: - Override
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return .Fade
    }
}
