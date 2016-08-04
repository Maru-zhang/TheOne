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
        
        tableView.backgroundColor = UIColor.colorWithHexString(model.bgcolor!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

}

extension TERankTableController {
    
    // MARK: - DataSource
    
    
    // MARK: - Delegate
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UILabel.init()
        header.font = UIFont.systemFontOfSize(15)
        header.textColor = UIColor.whiteColor()
        header.textAlignment = .Center
        header.text = viewModel.title.value
        return header
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
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
    
    // MARK: User Event
    
    @objc final private func closeClick() {
        
        dismissVC(completion: nil)
    }
}
