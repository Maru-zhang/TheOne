//
//  TEHeaderCell.swift
//  TheOne
//
//  Created by Maru on 16/6/23.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography
import ReactiveSwift

class TEHeaderCell: TECleanCell {
    
    typealias ClickAction = (AnyObject) -> ()
    
    let detail = MutableProperty<TEMusicDetail?>(nil)
    
    let headerImage: UIImageView
    let authorBanner: TEMusicBanner
    let titleName: UILabel
    let story: UIButton
    let lyrics: UIButton
    let info: UIButton
    
    var storyAction: ClickAction?
    var lyricsAction: ClickAction?
    var infoAction: ClickAction?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        headerImage = UIImageView()
        authorBanner = UINib.init(nibName: String(describing: TEMusicBanner()), bundle: nil).instantiate(withOwner: nil, options: nil).first as! TEMusicBanner
        titleName = UILabel()
        story = UIButton()
        lyrics = UIButton()
        info = UIButton()

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleName.text = "歌曲信息"
        titleName.textColor = UIColor.lightGray
        titleName.font = UIFont.systemFont(ofSize: 12)
        
        lyrics.setImage(UIImage(named: "music_lyric_default"), for: .normal)
        lyrics.setImage(UIImage(named: "music_story_selected"), for: .selected)
        
        story.setImage(UIImage(named: "music_story_default"), for: .normal)
        story.setImage(UIImage(named: "music_story_selected"), for: .selected)
        story.isSelected = true
        
        info.setImage(UIImage(named: "music_about_default"), for: .normal)
        info.setImage(UIImage(named: "music_about_selected"), for: .selected)
        
        contentView.addSubview(headerImage)
        contentView.addSubview(titleName)
        contentView.addSubview(story)
        contentView.addSubview(lyrics)
        contentView.addSubview(info)
        contentView.addSubview(authorBanner)
        
//        story.rac_command =
//            
//            RACCommand(signalBlock: { [unowned self] (anyObj) -> RACSignal! in
//            guard self.story.selected != true else {
//                return RACSignal.empty()
//            }
//            self.resetSelect()
//            self.story.selected = true
//            self.storyAction?(anyObj)
//            return RACSignal.empty()
//        })
        
//        lyrics.rac_command = RACCommand(signalBlock: { [unowned self] (anyObj) -> RACSignal! in
//            guard self.lyrics.selected != true else {
//                return RACSignal.empty()
//            }
//            self.resetSelect()
//            self.lyrics.selected = true
//            self.lyricsAction?(anyObj)
//            return RACSignal.empty()
//        })
//        
//        info.rac_command = RACCommand(signalBlock: { [unowned self] (anyObj) -> RACSignal! in
//            guard self.info.selected != true else {
//                return RACSignal.empty()
//            }
//            self.resetSelect()
//            self.info.selected = true
//            self.infoAction?(anyObj)
//            return RACSignal.empty()
//        })
        
        
        constrain(headerImage, authorBanner, titleName) { (headerImage, authorBanner, titleName) in
            
            headerImage.top == (headerImage.superview?.top)!
            headerImage.left == (headerImage.superview?.left)!
            headerImage.right == (headerImage.superview?.right)!
            headerImage.bottom == (headerImage.superview?.bottom)! - 100
            
            titleName.left == headerImage.left + 8
            titleName.bottom == (titleName.superview?.bottom)! - 5
            
            authorBanner.left == (headerImage.superview?.left)! + 20
            authorBanner.right == (headerImage.superview?.right)! - 20
            authorBanner.bottom == (headerImage.superview?.bottom)! - 40
            authorBanner.height == 100
        }
        
        constrain(lyrics, story, info) { (lyrics, story, info) in
            
            info.width == 44
            info.height == 44
            info.right == (info.superview?.right)! - 3
            info.bottom == (info.superview?.bottom)! + 5
            
            lyrics.width == info.width
            lyrics.height == info.height
            lyrics.bottom == info.bottom
            lyrics.right == info.left - 5
            
            story.width == info.width
            story.height == info.height
            story.bottom == info.bottom
            story.right == lyrics.left - 5
            
            
        }
        
        detail.producer
            .start(on: UIScheduler())
            .filter({ (details) -> Bool in
                return details != nil
            })
      
            .startWithValues { [unowned self] (details) in
                self.headerImage.kf.setImage(with: NSURL.init(string: details!.cover!) as! Resource?)
                self.authorBanner.configWithEntity(entity: details!)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func resetSelect() {
        if story.isSelected == true {
            story.isSelected = false
        }
        if lyrics.isSelected == true {
            lyrics.isSelected = false
        }
        
        if info.isSelected == true {
            info.isSelected = false
        }
    }

}

extension TEHeaderCell {
    
    // MARK: - Public Method
    
    func configWithEntity(entity: MutableProperty<TEMusicDetail?>) {
        self.detail <~ entity
    }
}
