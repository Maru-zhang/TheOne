//
//  TELoginController.swift
//  TheOne
//
//  Created by Maru on 16/3/15.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

private let headerView_H: CGFloat = 200.0

class TELoginController: UITableViewController {
    
    var headerImageView: UIImageView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        setupHeader()
    }
    
    // MARK: - Private Method
    private func setupHeader() {
        
        // 关闭自动调整
        automaticallyAdjustsScrollViewInsets = false
        
        // 隐藏NavigaionItem
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        
        let headerView = UIView()
        headerView.frame = CGRectMake(0, 0, 0, headerView_H)
        headerImageView = UIImageView(image: UIImage(named: "personalBackgroundImage"))
        headerImageView.frame = CGRectMake(0, 0, SCREEN_BOUNDS.width, headerView_H)
        headerView.addSubview(headerImageView)
        
        let loginButton = UIButton(type: .Custom)
        loginButton.setImage(UIImage(named: "personal"), forState: .Normal)
        headerImageView.addSubview(loginButton)
        
        let popButton = UIBarButtonItem(image: UIImage(named: "back_default_wight")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: Selector("popAction"))
        navigationItem.leftBarButtonItem = popButton
        
        tableView.tableHeaderView = headerView
        
        constrain(loginButton,headerImageView) { loginButton,headerImageView in
            loginButton.width == 60
            loginButton.height == 60
            loginButton.centerX == headerImageView.centerX
            loginButton.centerY == headerImageView.centerY
        }
        
        
    }
    
    func popAction() {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    // MARK: - UIScrolView Delegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset_y = scrollView.contentOffset.y
        
        guard offset_y < 0 else {
            return
        }
        
        headerImageView.frame = CGRectMake(0, offset_y, SCREEN_BOUNDS.width, headerView_H - offset_y)
        
    }
    
   // MARK: - UITableView Delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "das"
    
        return cell
    }
}
