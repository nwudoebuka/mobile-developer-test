//
//  StandingsHelper.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/11/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol IStanding {
    func successful(responseJson:JSON,requestcode:Int,responseCode:Int)
    func failed(responseJson: JSON,requestcode:Int,responseCode:Int)
    func nilresponse()
}

class StandingsHelper : IMakeAPICalls{
   
    
    
    var delegate : IStanding!
    
    //URLs
   
    let STANDING_REQUEST_CODE: Int = 1;
    
    func doStandingCall(_ endPartUrl:String) {
        APICalls.makeGetRequestWithHeader(endPartUrl, self, STANDING_REQUEST_CODE)
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
