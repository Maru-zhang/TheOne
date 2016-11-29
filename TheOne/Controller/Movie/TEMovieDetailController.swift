//
//  TEMovieDetailController.swift
//  TheOne
//
//  Created by Maru on 16/4/4.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import ReactiveSwift


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
        
        tableView.separatorInset = .zero
        tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.estimatedRowHeight = 70
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell()))
        tableView.register(TEMovieHeaderCell.self, forCellReuseIdentifier: String(describing: TEMovieHeaderCell()))
        tableView.register(TEMovieUtilCell.self, forCellReuseIdentifier: String(describing: TEMovieUtilCell()))
        tableView.register(TEMovieStoryCell.self, forCellReuseIdentifier: String(describing: TEMovieStoryCell()))
        tableView.register(TEKeywordCell.self, forCellReuseIdentifier: String(describing: TEKeywordCell()))
        tableView.register(UINib.init(nibName: String(describing: TECommentCell()), bundle: nil), forCellReuseIdentifier: String(describing: TECommentCell()))
        
        tableView.es_addInfiniteScrolling { [unowned self] in
            self.viewModel.fetchCommentList()
        }
        
    }
    
    private func setupBinding() {
        
    }
}

extension TEMovieDetailController {
    
    // MARK: - Action
    func showTrailerMovieAction() {
        guard viewModel.detail.value != nil else {
            return
        }
        
    }
}

extension TEMovieDetailController {
    
    // MARK: - DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TEMovieHeaderCell.self), for: indexPath as IndexPath) as! TEMovieHeaderCell
                cell.headerDidClick = { [unowned self] in
                    self.showTrailerMovieAction()
                }
                
                
                cell.configWithEntity(entity: viewModel.detail.value)
                return cell
            }else {
                return tableView.dequeueReusableCell(withIdentifier: String(describing: TEMovieUtilCell.self), for: indexPath as IndexPath)
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String.self(describing: TEMovieStoryCell()), for: indexPath as IndexPath)  as! TEMovieStoryCell
            cell.configWithEntity(entity: viewModel.story.value.first!)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TEKeywordCell()), for: indexPath as IndexPath) as! TEKeywordCell
            cell.configWithKeyword(key: (viewModel.detail.value?.keywords!)!)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TECommentCell.self), for: indexPath as IndexPath) as! TECommentCell
            
            cell.configWithComment(comment: viewModel.comments.value[indexPath.row])
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell()), for: indexPath as IndexPath)
        }
    }
    
    // MARK: - Delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return indexPath.row == 0 ? 200 : 40
        case 2:
            return 126
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return TEConfigure.musicHeaderViewForSection(title: "电影故事")
        case 2:
            return TEConfigure.musicHeaderViewForSection(title: "一个电影表")
        case 3:
            return TEConfigure.musicHeaderViewForSection(title: "评论列表")
        default:
            return nil
        }
    }
    
}

extension TEMovieDetailController {
    
    // MARK: - Override
    
}
