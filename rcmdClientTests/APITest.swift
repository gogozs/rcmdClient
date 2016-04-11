//
//  APITest.swift
//  rcmdClient
//
//  Created by Song Zhou on 4/7/16.
//  Copyright © 2016 Song Zhou. All rights reserved.
//

import Foundation
import XCTest
@testable import rcmdClient

class APITest: XCTestCase {
    
    override func setUp() {
    }
    
//    func testGetTopMovies() {
//        let expect = self.expectationWithDescription("get top movies")
//        DataManager.sharedInstance.getTopMovies(20) { (let data: NSData?, let response: NSURLResponse?, let error: NSError?) in
//            if let e = error {
//               print("\(e)")
//                expect.fulfill()
//            } else {
//                if let d = data {
//                    do {
//                        let responseObject = try NSJSONSerialization.JSONObjectWithData(d, options: .AllowFragments)
//                        print("\(responseObject)")
//                        expect.fulfill()
//                    } catch {
//                        
//                    }
//                    
//                }
//             }
//        }
//        self.waitForExpectationsWithTimeout(3.0, handler: nil)
//    }
}