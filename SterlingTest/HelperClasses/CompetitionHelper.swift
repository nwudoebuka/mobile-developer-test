//
//  CompetitionHelper.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/8/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ICompetition {
    func successful(responseJson:JSON,requestcode:Int,responseCode:Int)
    func failed(responseJson: JSON,requestcode:Int,responseCode:Int)
    func nilresponse()
}

class CompetitionHelper : IMakeAPICalls{
 
    
    var delegate : ICompetition!
    
    //URLs
    let COMPETETION_URL_END_PART: String = "/v2/competitions";
    let COMPETETION_REQUEST_CODE: Int = 1;
    
    func doCompetetionCall() {
        APICalls.makeGetRequestWithHeader(COMPETETION_URL_END_PART, self, COMPETETION_REQUEST_CODE)
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
