//
//  TEMusicController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEMusicController: UITableViewController {

    override func viewDidLoad() {
        
        setupView()
    }
    
    
    // MARK: - Private Method
    func setupView() {
        
        title = "音乐"
        
        setupCommentItem()
        
        view.backgroundColor = UIColor.whiteColor()
        
        tableView.estimatedRowHeight = 70.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: String(UITableViewCell))
        tableView.registerNib(UINib.init(nibName: String(TECommentCell), bundle: nil), forCellReuseIdentifier: String(TECommentCell))
        
        TENetService.apiGetMusicCommentListBy(602, page: 0) { (signal) in
            signal.startWithNext({ (comments, count) in
                debugPrint(comments,count)
            })
        }
    }
}

extension TEMusicController {
    
    // MARK: - DataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
        case 1:
            return tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(String(TECommentCell), forIndexPath: indexPath) as! TECommentCell
            cell.content.text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa "
            return cell
        default:
            return tableView.dequeueReusableCellWithIdentifier(String(UITableViewCell), forIndexPath: indexPath)

        }
    }
    
    // MARK: - Delegate
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "相似歌曲"
        case 2:
            return "评论列表"
        default:
            return nil
        }
    }
    
}