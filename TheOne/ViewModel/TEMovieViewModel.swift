//
//  TEMovieViewModel.swift
//  TheOne
//
//  Created by Maru on 16/3/19.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Kingfisher
import ReactiveCocoa
import Result

class TEMovieViewModel: TETableModelType {
    
    typealias CellType = TEMovieCardCell
    
    /// DataSource
    private var movies: [TEMovieCardModel] = []
    

    func updateCell(cell: CellType, index: NSIndexPath) {
        cell.scorlLable.text = movies[index.row].score
        cell.coverImage.kf_setImageWithURL(NSURL(string: movies[index.row].cover!)!)
    }
    
    func cellForHeightAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return 190;
    }

    
}