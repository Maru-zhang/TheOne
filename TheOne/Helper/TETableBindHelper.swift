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
    
    init(tableView: UITableView,viewModel: TETableModelType) {
        self.tableView = tableView
        self.viewModel = viewModel
        super.init()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }

}

extension TETableBindHelper: UITableViewDataSource {
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "")
    }

    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.table(view: tableView, numberOfRows: section)
    }
    
    private func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        return viewModel.table(view: tableView, cellForRow: indexPath as NSIndexPath)
    }
    
}

extension TETableBindHelper: UITableViewDelegate {
    
}
