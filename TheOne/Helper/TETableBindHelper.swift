//
//  TETableBindHelper.swift
//  TheOne
//
//  Created by master on 16/7/21.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TETableBindHelper: NSObject {
    
    unowned var tableView: UITableView
    unowned var viewModel: TETableModelType
    
    init(tableView: UITableView,viewModel: protocol<TETableModelType>) {
        self.tableView = tableView
        self.viewModel = viewModel
        super.init()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }

}

extension TETableBindHelper: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.table(tableView, numberOfRows: section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return viewModel.table(tableView, cellForRow: indexPath)
    }
    
}

extension TETableBindHelper: UITableViewDelegate {
    
}