
//
//  HomePageView.swift
//  TheOne
//
//  Created by Maru on 16/6/2.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class HomePageView: TEPageableView {

    var entities: [TEPaperModel]!
    
    convenience init(frame: CGRect,entities: [TEPaperModel]) {
        self.init(frame: frame)
        self.entities = entities
    }
    
//    override init(frame: CGRect) {6yikm
//        entities = []
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    

}
