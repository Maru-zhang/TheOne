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

class TESettingController: UITableViewController {
    
    /// 头视图
    let headerView = UIView()
    /// 姓名标签
    let nameTips = UILabel()
    /// 返回按钮
    var popButton: UIBarButtonItem!
    /// 登录按钮
    var loginButton: UIButton!
    

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
        navigationController?.navigationBar.setBackgroundImage(TEConfigure.imageHolder, forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = TEConfigure.imageHolder
        navigationController?.navigationBar.translucent = true
        
        popButton = UIBarButtonItem(image: UIImage(named: "back_default_wight")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(TESettingController.popAction))
        
        headerView.frame = CGRectMake(0, 0, 0, headerView_H)
        headerImageView = UIImageView(image: UIImage(named: "personalBackgroundImage"))
        headerImageView.frame = CGRectMake(0, 0, SCREEN_BOUNDS.width, headerView_H)
        headerImageView.userInteractionEnabled = true
        headerView.addSubview(headerImageView)
        
        loginButton = UIButton(type: .Custom)
        loginButton.setImage(UIImage(named: "personal"), forState: .Normal)
        headerImageView.addSubview(loginButton)
        
        navigationItem.leftBarButtonItem = popButton
        
        nameTips.textColor = UIColor.whiteColor()
        nameTips.text = "请登录"
        headerImageView.addSubview(nameTips)
        
        tableView.tableHeaderView = headerView
        
        // Layout View
        constrain(loginButton,nameTips) { loginButton,nameTips in
            loginButton.width == 60
            loginButton.height == 60
            loginButton.centerX == loginButton.superview!.centerX
            loginButton.centerY == loginButton.superview!.centerY
            
            nameTips.top == loginButton.bottom
            nameTips.height == 30
            nameTips.centerX == loginButton.centerX
        }
        
        // Add Event
        loginButton.addTarget(self, action: #selector(presentToLoginController), forControlEvents: .TouchUpInside)
    }
    
    func popAction() {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func presentToLoginController() {
        let login = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TELoginController")
        presentViewController(login, animated: true, completion: nil)
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
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "其他设置"
    
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
