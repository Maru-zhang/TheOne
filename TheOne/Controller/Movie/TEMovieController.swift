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
    
    override func viewDidAppear(animated: Bool) {
        
        setupData()
        
    }
    
    // MARK: - Private Method
    private func setupView() {
        title = "电影"
        tableView.separatorStyle = .None
        tableView.registerClass(TEMovieCardCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(TEMovieCardCell))
        tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 9)
    }
    
    
    private func setupData() {
        
        tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            
        })
    
    }
    
    private func bindingView() {
        
        viewModel.active <~ isActive()
        
        viewModel.refreshSignal.startWithNext { [unowned self] in
            
            self.viewModel.fetchRemoteRefreshDataWithCallBack({ (entitys) in
                self.tableView.reloadData()
                }, failure: { (error) in
                    debugPrint(error)
            })
        }
        
    }
    
    // MARK: - DataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMoviesInSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(TEMovieCardCell), forIndexPath: indexPath) as! TEMovieCardCell
        
        viewModel.updateCell(cell, index: indexPath)
        
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.cellForHeightAtIndexPath(indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        navigationController?.pushViewController(TEMovieDetailController(), animated: true)
    }
    
    
}
