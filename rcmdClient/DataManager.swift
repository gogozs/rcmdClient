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
    
    func getTopMovies(count: Int, completion: NetworkCompletion) {
        URLSession.GET("\(getTopNMovies)/\(count)", completion: completion)
    }
    
    func getMovieDetail(id: Int, completion: NetworkCompletion) {
        URLSession.GET("\(getMovieWithID)/\(id)", completion: completion)
    }
    
    func getUserUserCF(userID: Int, completion: NetworkCompletion) {
        URLSession.GET("\(getUserUserCFKey)/\(userID)", completion: completion)
    }
    
    func getItemItemCF(itemID: Int, count: Int, completion: NetworkCompletion) {
        URLSession.GET("\(getItemItemCFKey)/\(itemID)/\(count)", completion: completion)
    }
}