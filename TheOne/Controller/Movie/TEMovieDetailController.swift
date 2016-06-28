//
//  TEMovieDetailController.swift
//  TheOne
//
//  Created by Maru on 16/4/4.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEMovieDetailController: UITableViewController {

    override func viewDidLoad() {
        
    }
    
    private func setupUI() {
        
        tableView.registerClass(TEMovieHeaderCell.self, forCellReuseIdentifier: String(TEMovieHeaderCell))
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
            return 1
        case 2:
            return 1
        case 3:
            return 10
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return indexPath.row == 0 ? 300 : 40
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 4
        default:
            return 0
        }
    }
}
