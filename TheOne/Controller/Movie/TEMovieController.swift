//
//  TEMovieController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEMovieController: UITableViewController {
    
    let viewModel = TEMovieViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        setupCommonProperty()
        
        setupView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        setupData()
    }
    
    // MARK: - Private Method
    private func setupView() {
        title = "电影"
        tableView.separatorStyle = .None
        tableView.registerClass(TEMovieCardCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(TEMovieCardCell))
    }
    
    
    private func setupData() {
        
        viewModel.fetchMovieData({ () -> Void in
            self.tableView.reloadData()
            })
            { () -> Void in }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(TEMovieCardCell), forIndexPath: indexPath) as! TEMovieCardCell
        
        viewModel.updating(cell, index: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.cellForHeightAtIndexPath(indexPath)
    }
    
    
}
