//
//  DataManager.swift
//  rcmdClient
//
//  Created by Song Zhou on 4/7/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

import Foundation

class DataManager {
    static let sharedInstance = DataManager()
    
    func getTopMovies(count: Int, completion: (AnyObject?, NSURLResponse?, NSError?) -> Void) {
        URLSession.GET("\(getTopNMovies)/\(count)", completion: completion)
    }
    
    func getMovieDetail(id: Int, completion: (AnyObject?, NSURLResponse?, NSError?) -> Void) {
        URLSession.GET("\(getMovieWithID)/\(id)", completion: completion)
    }
}