//
//  URLSession.swift
//  rcmdClient
//
//  Created by Song Zhou on 4/7/16.
//  Copyright © 2016 Song Zhou. All rights
import Foundation

typealias NetworkCompletion = (AnyObject?, NSURLResponse?, NSError?) -> Void

class URLSession: NSURLSession {
    
    class func GET(method: String, completion: NetworkCompletion) -> NSURLSessionDataTask {
        
        let urlStr =  "\(API_URL)/" + "\(method)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.whitespaceCharacterSet().invertedSet)!
        
        let url = NSURL.init(string: urlStr)!
        
        let dataTask = URLSession.sharedSession().dataTaskWithURL(url,completionHandler: {
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
    
    class func GET(method: String, parameters: [String: AnyObject], completion: NetworkCompletion) -> NSURLSessionDataTask {
        let methodStr = method + "/" + parameterStrFromDcit(parameters)
        return URLSession.GET(methodStr, completion: completion)
    }
    
}

extension URLSession {
    class func parameterStrFromDcit(dict: [String: AnyObject]) -> String {
        var i = 0
        
        var result = ""
        for (key, value) in dict {
            i += 1
            result += "\(key)=\(value)"
            
            if i != dict.count {
                result += "&"
            }
        }
        
        return result
    }
}