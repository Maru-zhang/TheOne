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

class TEMovieController: UITableViewController {
    
    let viewModel = TEMovieViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        setupCommonProperty()
        
        setupView()
        
        bindingView()
        
    }
    
    // MARK: - Private Method
    private func setupView() {
        title = "电影"
        tableView.separatorStyle = .None
        tableView.registerClass(TEMovieCardCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(TEMovieCardCell))
        tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 9)
        
        tableView.mj_footer = MJRefreshBackStateFooter(refreshingBlock: { [unowned self] in
            self.viewModel.loadMoreObserver.sendNext()
        })
    }
    
    
    private func bindingView() {
        
        viewModel.active <~ isActive()
        
        viewModel.refreshSignal
            .observeOn(UIScheduler())
            .startWithNext { [unowned self] in
            
            self.viewModel.fetchRemoteRefreshDataWithCallBack({ (entitys) in
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
                }, failure: { (error) in
                    self.tableView.mj_footer.endRefreshing()
                    // TODO: 添加网络状态错误的相关HUD

            })
        }
        
        viewModel.loadMoreSignal
            .observeOn(UIScheduler())
            .observeNext { [unowned self]() in
            self.viewModel.fetchRemoteDataWithCallBack({ 
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
                }
                , failure: { (fail) in
                    if fail.code == 0 {
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }else {
                        // TODO: 添加网络状态错误的相关HUD
                    }
            })
        }
        
    }
    
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
        
        navigationController?.pushViewController(TEMovieDetailController(), animated: true)
    }
    
    
}
