//
//  MyTests.swift
//  MyTests
//
//  Created by Nwudo Ebuka on 8/14/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import XCTest
@testable import SterlingTest
class MyTests: XCTestCase {
    func testApiKey(){
        let API_KEY : String = "84e2580c41714c338186242bd17f7fb2"
        let API_KEY_IN_USE:String = Constants.API_KEY
        XCTAssertEqual(API_KEY, API_KEY_IN_USE)
    }
    
    func testBaseUrl(){
        let BASE_URL = "https://api.football-data.org"
        let GIVEN_BASE_URL = Constants.BASE_URL
        XCTAssertEqual(BASE_URL, GIVEN_BASE_URL)
    }
}
