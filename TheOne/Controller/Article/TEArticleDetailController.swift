//
//  TEArticleDetailController.swift
//  TheOne
//
//  Created by Maru on 16/6/29.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class TEArticleDetailController<ReadType>: UIViewController {
    

    
    let pageableView: TEPageableView
    
    fileprivate let list: [ReadType]
    fileprivate var index: Int

    // MARK: - Life Cycle
    init(list: [ReadType],index: Int) {
        self.list = list
        self.index = index
        self.pageableView = TEPageableView()
        super.init(nibName: nil, bundle: nil)
        if list.first is TEEssay {
            title = "短篇"
        }else if list.first is TESerial {
            title = "连载"
        }else {
            title = "问题"
        }
        pageableView.frame = view.bounds
        pageableView.dataSource = self
        pageableView.viewDelegate = self
        view.addSubview(pageableView)
        view.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
    }
    
    private func setupUI() {
        
    }

}

extension TEArticleDetailController: TEPageableDelegate,TEPageableDataSource {
    
    func pageableView(pageView: TEPageableView) -> NSInteger {
        return list.count
    }
    
    func pageableView(pageView: TEPageableView, cardCellForColumnAtIndexPath indexPath: NSIndexPath) -> UIView {
        return UIView()
    }
}
