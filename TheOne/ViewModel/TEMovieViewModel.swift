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

class TEMovieViewModel {
    
    /// DataSource
    var movies: [TEMovieCardModel] = []
    
    
    func fetchMovieData(successHandler: () -> Void,failureHandler:() -> Void){
        
        Alamofire.request(.GET, TEConfigure.API_MOVIE).responseJSON { (response) -> Void in
            
            self.movies.removeAll()
            
            switch response.result{
                
                case .Success:
                
                    let json = JSON(response.result.value!)
                    
                    for (_,jsonItem) in json["data"] {
                        
                        var model = TEMovieCardModel()
                        
                        model.score = jsonItem["score"].stringValue
                        model.cover = jsonItem["cover"].stringValue
                        
                        self.movies.append(model)
                        
                    }
                    
                    successHandler()
                    
                    break
                
                case .Failure:
                
                    failureHandler()
                
                    break
                
            }
            
        }
    }
    
    func updating(cell: TEMovieCardCell,index: NSIndexPath) {
        cell.scorlLable.text = movies[index.row].score
        cell.coverImage.kf_setImageWithURL(NSURL(string: movies[index.row].cover!)!)
    }
    
    func cellForHeightAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        return 190;
    }
}