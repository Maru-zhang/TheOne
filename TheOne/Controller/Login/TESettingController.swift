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
    var backButton: UIButton!
    /// 登录按钮
    var loginButton: UIButton!
    

    var headerImageView: UIImageView!
    
    // MARK: - Initialilzer
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - Private Method
    private func setupUI() {
        
        backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_default_wight"), for: .normal)
        backButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        headerView.frame = CGRect.init(x: 0, y: 0, width: 0, height: headerView_H)
        headerImageView = UIImageView(image: UIImage(named: "personalBackgroundImage"))
        headerImageView.frame = CGRect.init(x: 0, y: 0, width: SCREEN_BOUNDS.width, height: headerView_H)
        headerImageView.isUserInteractionEnabled = true
        headerView.addSubview(headerImageView)
        
        loginButton = UIButton(type: .custom)
        loginButton.setImage(UIImage(named: "personal"), for: .normal)
        headerImageView.addSubview(loginButton)
        
        nameTips.textColor = UIColor.white
        nameTips.font = UIFont.systemFont(ofSize: 14)
        nameTips.text = "请登录"
        headerImageView.addSubview(nameTips)
        
        tableView.tableHeaderView = headerView
        tableView.addSubview(backButton)
        
        // Layout View
        constrain(loginButton,nameTips,backButton) { loginButton,nameTips,back in
            
            loginButton.width == 60
            loginButton.height == 60
            loginButton.centerX == loginButton.superview!.centerX
            loginButton.centerY == loginButton.superview!.centerY
            
            nameTips.top == loginButton.bottom
            nameTips.height == 30
            nameTips.centerX == loginButton.centerX
            
            back.top == back.superview!.top + 20
            back.left == back.superview!.left + 10
            back.width == 44
            back.height == 44
        }
        
        // Add Event
        loginButton.addTarget(self, action: #selector(presentToLoginController), for: .touchUpInside)
        
    }
    
    
    // MARK: - Private method
    func closeAction() {
        
        dismiss(animated: true, completion: nil)
    }
    
    func presentToLoginController() {
        let login = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TELoginController")
        present(login, animated: true, completion: nil)
    }
}

extension TESettingController {
    
    // MARK: - UIScrolView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset_y = scrollView.contentOffset.y
        
        guard offset_y < 0 else {
            return
        }
        
        headerImageView.frame = CGRect.init(x: 0, y: offset_y, width: SCREEN_BOUNDS.width, height: headerView_H - offset_y)
        
    }
    
    // MARK: - UITableView Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "其他设置"
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
