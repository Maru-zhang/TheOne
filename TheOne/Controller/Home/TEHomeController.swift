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
import JTSImageViewController

let widgetSpace: CFloat = 20

class TEHomeController: UIViewController {

    var diary: UIButton!
    var like : UIButton!
    var more : UIButton!
    var likeNum: UILabel!
    
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
        
        likeNum = UILabel()
        likeNum.textColor = UIColor.lightGrayColor()
        likeNum.textAlignment = .Left
        likeNum.font = UIFont.systemFontOfSize(13)
        
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
            diary.bottom    == (diary.superview?.bottom)! - (tabBarController?.tabBar.bounds.height)! - 20
            
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
        
        viewModel.refreshObserver.sendNext()
        
        containner.leftAction = { [unowned self] refresh in
            self.viewModel.refreshObserver.sendNext()
            refresh.stopIndicatorAnimation()
        }
        
        viewModel.cards.signal.observeNext { [unowned self] (_) in
            self.containner.reloadData()
        }
        
        viewModel.praiseSignal.startWithNext { [unowned self] (number) in
            self.likeNum.text = String(number)
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

        var cell = pageView.dequeueReusableCell() as? UIScrollView
        let entity = viewModel.cards.value[indexPath.indexAtPosition(0)]
        
        if cell == nil {
            cell = UIScrollView()
            cell?.alwaysBounceVertical = true
            cell?.showsVerticalScrollIndicator = false
            cell?.backgroundColor = UIColor.clearColor()
            cell?.contentSize = CGSizeMake(pageView.frame.width, pageView.frame.height + 200)
            let homePageView = HomePageView()
            homePageView.showClosure = { [unowned self] in
                let imageInfo = JTSImageInfo()
                imageInfo.image = homePageView.imageView.image
                imageInfo.referenceRect = (homePageView.imageView.frame)
                imageInfo.referenceView = cell
                let showVC = JTSImageViewController(imageInfo: imageInfo, mode: JTSImageViewControllerMode.init(rawValue: 0)!, backgroundStyle: JTSImageViewControllerBackgroundOptions.init(rawValue: 2))
                showVC.showFromViewController(self, transition: JTSImageViewControllerTransition.FromOriginalPosition)
            }
            cell?.addSubview(homePageView)
            
        }
        
        (cell?.subviews.first as! HomePageView).configWithEntity(entity)
        
        return cell!
    }
    
    func pageableViewWillShowReuseView(pageView: TEPageableView, reuseView: UIView, indexPath: NSIndexPath) {
        let content = viewModel.cards.value[indexPath.indexAtPosition(0)].hp_content! as NSString
        let sizeH = content.boundingRectWithSize(CGSizeMake(pageView.frame.width - 20, CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: TEConfigure.card_content_font], context: nil).size.height + 350.0
        let scrollView = reuseView as! UIScrollView
        let home = scrollView.subviews.first as! HomePageView
        scrollView.contentOffset = CGPointZero
        home.frame = CGRectMake(10, 10, pageView.frame.width - 20, sizeH)
    }
    
    func pageableViewFrame(pageView: TEPageableView, atIndexPath indexPath: NSIndexPath) -> CGRect {
        return CGRectMake(0, 0, pageView.frame.width, pageView.frame.height)
    }
    
    func pageableViewDidEndScroll(pageView: TEPageableView, toIndexPath indexPath: NSIndexPath) {

        let number = viewModel.cards.value[indexPath.indexAtPosition(0)].praisenum
        
        viewModel.praiseObserver.sendNext(number!)
        
    }
}


