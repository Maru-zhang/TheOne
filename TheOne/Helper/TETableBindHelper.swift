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
    
    private var sectionConfig: ((tableView: UITableView) ->())?
    
    init(tableView: UITableView,viewModel: TETableModelType) {
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
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension TETableBindHelper: UITableViewDelegate {
    
}