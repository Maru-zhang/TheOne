//
//  TEMovieController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import MJRefresh
import ReactiveCocoa
import ESPullToRefresh


class TEMovieController: UITableViewController {
    
    let viewModel = TEMovieViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        setupView()
        
        bindingView()
        
    }
    
    // MARK: - Private Method
    private func setupView() {
        setupCommentItem()
        tableView.separatorStyle = .None
        tableView.registerClass(TEMovieCardCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(TEMovieCardCell))
        tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 9)
        tableView.es_addInfiniteScrolling { [unowned self] in
            self.viewModel.loadMoreObserver.sendNext()
        }

    }
    
    
    private func bindingView() {
        
        viewModel.active <~ isActive()
        
        viewModel.refreshSignal
            .observeOn(UIScheduler())
            .startWithNext { [unowned self] in
            
            self.viewModel.fetchRemoteRefreshDataWithCallBack({ (entitys) in
                self.tableView.reloadData()
                self.tableView.es_stopLoadingMore()
                }, failure: { (error) in
                    self.tableView.es_stopLoadingMore()
                    // TODO: 添加网络状态错误的相关HUD
                    TEToastService.showNetDisconnet()
            })
        }
        
        viewModel.loadMoreSignal
            .observeOn(UIScheduler())
            .observeNext { [unowned self]() in
            self.viewModel.fetchRemoteDataWithCallBack({ 
                self.tableView.reloadData()
                self.tableView.es_stopLoadingMore()
                }
                , failure: { (fail) in
                    if fail.code == 0 {
                        self.tableView.es_noticeNoMoreData()
                    }else {
                        // TODO: 添加网络状态错误的相关HUD
                        TEToastService.showNetDisconnet()
                    }
            })
        }
        

    }
    
    
}

extension TEMovieController {
    
    // MARK: - DataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMoviesInSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(TEMovieCardCell), forIndexPath: indexPath) as! TEMovieCardCell
        
        cell.configureWithViewModels(viewModel, indexPath: indexPath)
        
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.heightForCellAtIndexPath(indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let model = TEMovieDetailViewModel.init(movie: viewModel.entityMappingIndexPath(indexPath))
        
        navigationController?.pushViewController(TEMovieDetailController.init(model: model), animated: true)
    }
    
}

