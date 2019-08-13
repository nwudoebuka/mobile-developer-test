//
//  TodayFixtureHelper.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/12/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ITodayFixture {
    func successful(responseJson:JSON,requestcode:Int,responseCode:Int)
    func failed(responseJson: JSON,requestcode:Int,responseCode:Int)
    func nilresponse()
}

class TodayFixtureHelper : IMakeAPICalls{
    
    
    
    var delegate : ITodayFixture!
    
    //URLs
    
    let TODAY_FIXTURE_REQUEST_CODE: Int = 2;
    let TODAY_FIXTURE_END_URL = "/v2/matches"
    
    func doTodayfixtureCall() {
        APICalls.makeGetRequestWithHeader(TODAY_FIXTURE_END_URL, self, TODAY_FIXTURE_REQUEST_CODE)
    }
    
    func handleSuccessResponse(_ responseJson: JSON ,_ requestCode: Int,_ responseCode:Int) {
        delegate.successful(responseJson: responseJson, requestcode: requestCode, responseCode: responseCode)
    }
    
    func handleFailureResponse(_ responseJson: JSON ,_ requestCode: Int,_ responseCode:Int) {
        delegate.failed(responseJson: responseJson, requestcode: requestCode, responseCode: responseCode)
    }
    func handlenilresponse() {
        delegate.nilresponse()
    }
}

