//
//  TERankTableControllerTableViewController.swift
//  TheOne
//
//  Created by Maru on 16/6/30.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography

class TERankTableController: UITableViewController {
    

    let viewModel: TERankViewModel
    
    // MARK: - Life Cycle
    
    init(model: TECarousel) {
        
        viewModel = TERankViewModel.init(model: model)
        
        super.init(nibName: nil, bundle: nil)
        
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.colorWithHexString(model.bgcolor!)
        tableView.registerClass(TERankCell.self, forCellReuseIdentifier: String(TERankCell))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        setupBinding()
        
    }

}

extension TERankTableController {
    
    // MARK: - DataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recommends.value.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(String(TERankCell), forIndexPath: indexPath) as! TERankCell
        
        cell.configureWithEntity(viewModel.recommends.value[indexPath.row])
        
        return cell
    }
    
    
    // MARK: - Delegate
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UILabel.init()
        header.font = UIFont.systemFontOfSize(15)
        header.textColor = UIColor.whiteColor()
        header.textAlignment = .Center
        header.text = viewModel.title.value
        return header
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let bottom = UILabel.init()
        bottom.font = UIFont.systemFontOfSize(15)
        bottom.textColor = UIColor.whiteColor()
        bottom.textAlignment = .Center
        bottom.text = viewModel.bottom.value
        return bottom
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
}

extension TERankTableController {
    
    // MARK: - Private Method
    
    final private func setupView() {
        
        let closeButton = UIButton.init()
        closeButton.setImage(UIImage.init(named: "close_default_wight"), forState: .Normal)
        closeButton.setImage(UIImage.init(named: "close_highlighted"), forState: .Highlighted)
        closeButton.addTarget(self, action: #selector(closeClick), forControlEvents: .TouchUpInside)
        
        view.addSubview(closeButton)
        
        constrain(closeButton) { (close) in
            close.width  == 44
            close.height == 44
            close.top    == close.superview!.top + 20
            close.left   == close.superview!.left + 10
        }
    }
    
    final private func setupBinding() {
        
        viewModel.fetchRemoteData()
        
        viewModel.refreshSignal.startWithNext { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    // MARK: User Event
    
    @objc final private func closeClick() {
        
        dismissVC(completion: nil)
    }
}
