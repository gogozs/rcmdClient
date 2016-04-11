//
//  URLSession.swift
//  rcmdClient
//
//  Created by Song Zhou on 4/7/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

import Foundation

class URLSession: NSURLSession {
    
    class func GET(method: String, completion: (AnyObject?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        
        let dataTask = URLSession.sharedSession().dataTaskWithURL(NSURL.init(string: "\(API_URL)/\(method)")!,completionHandler: {
            (let data: NSData?, let response: NSURLResponse?, let error: NSError?) in
            var responseObject: AnyObject?
            if let _ = error {
            } else {
                if let d = data {
                    do {
                        responseObject = try NSJSONSerialization.JSONObjectWithData(d, options: .AllowFragments)
                    } catch {
                        
                    }
                    
                }
            }
            completion(responseObject, response, error)
        } )
        
        dataTask.resume()
        
        return dataTask
    }
    
}