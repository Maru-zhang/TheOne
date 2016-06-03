//
//  TEHomeController.swift
//  TheOne
//
//  Created by Maru on 16/3/14.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography
import ReactiveCocoa


let widgetSpace: CFloat = 20

class TEHomeController: UIViewController {

    var diary: UIButton!
    var like : UIButton!
    var more : UIButton!
    
    var containner: TEPageableView!

    var viewModel: TECardViewModel!
    
    override func viewDidLoad() {
        
        setupView()
        
        setupBinding()
        
    }
    
}

extension TEHomeController {
    
    // MARK: - Private Method
    private func setupView() {
        
        viewModel = TECardViewModel()
        
        setupCommentItem()
        
        // 配置滑动视图
        containner = TEPageableView(frame: view.bounds)
        containner.dataSource = self
        containner.viewDelegate = self
        
        diary = UIButton()
        diary.setImage(UIImage(named: "diary_default"), forState: .Normal)
        
        like = UIButton()
        like.setImage(UIImage(named: "like_default"), forState: .Normal)
        like.setImage(UIImage(named: "like_highlighted"), forState: .Highlighted)
        like.setImage(UIImage(named: "like_selected"), forState: .Selected)
        
        more = UIButton()
        more.setImage(UIImage(named: "shareImage"), forState: .Normal)
        
        let likeNum = UILabel()
        likeNum.textColor = UIColor.lightGrayColor()
        likeNum.textAlignment = .Left
        likeNum.font = UIFont.systemFontOfSize(13)
        likeNum.text = "2120"
        
        view.addSubview(diary)
        view.addSubview(like)
        view.addSubview(more)
        view.addSubview(likeNum)
        view.addSubview(containner)

        
        // Layout setup
        constrain(diary, like, more, likeNum) { (diary, like, more, likeNum) -> () in
            
            diary.width     == 53
            diary.height    == 21
            diary.left      == (diary.superview?.left)! + 10
            diary.bottom    == (diary.superview?.bottom)! - (tabBarController?.tabBar.bounds.height)! - 40
            
            more.width      == 44
            more.height     == 44
            more.right      == diary.superview!.right - 10
            more.centerY    == diary.centerY
            
            likeNum.right   == more.left
            likeNum.centerY == diary.centerY
            
            like.height     == 44
            like.right      == likeNum.left
            like.centerY    == diary.centerY
            
            
        }
        
        
    }
    
    private func setupBinding() {
        
        viewModel.active <~ isActive()
        
        viewModel.cards.signal.observeNext { [unowned self] (_) in
            self.containner.reloadData()
        }
    
        rac_signalForSelector(#selector(TEHomeController.viewWillAppear(_:)))
            .toSignalProducer()
            .startWithNext({ [unowned self] (_) in
                self.tabBarController!.navigationItem.titleView = UIImageView(image: UIImage(named: "nav_title"))
            })
        
        rac_signalForSelector(#selector(TEHomeController.viewWillDisappear(_:)))
            .toSignalProducer()
            .startWithNext({ [unowned self] (_) in
                self.tabBarController!.navigationItem.titleView = nil
            })
        
        
    }
}

extension TEHomeController: TEPageableDataSource,TEPageableDelegate {
    
    func pageableView(pageView: TEPageableView) -> NSInteger {
        return viewModel.cards.value.count
    }
    
    func pageableView(pageView: TEPageableView, cardCellForColumnAtIndexPath indexPath: NSIndexPath) -> UIView {

        var cell = pageView.dequeueReusableCell() as? TECardPageView
        let entity = viewModel.cards.value[indexPath.indexAtPosition(0)]
        
        if cell == nil { cell = TECardPageView() }
        
        cell?.author.text = entity.hp_author
        cell?.content.text = entity.hp_content
        cell?.VOL.text = entity.hp_title
        cell?.imageView.kf_setImageWithURL(NSURL(string: entity.hp_img_url!)!)
        cell?.markTime.text = (entity.hp_makettime! as NSString).substringToIndex(10)

        return cell!
    }
    
    func pageableViewFrame(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect {
        
        debugPrint("---\(indexPath.indexAtPosition(0))")
        
        let content = viewModel.cards.value[indexPath.indexAtPosition(0)].hp_content! as NSString
        
        let size = content.boundingRectWithSize(CGSizeMake(pageView.frame.width - 20, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: TEConfigure.card_content_font], context: nil).size
        
        return CGRectMake(10, 10, pageView.frame.width - 20, 350.0 + size.height)
    }
}


