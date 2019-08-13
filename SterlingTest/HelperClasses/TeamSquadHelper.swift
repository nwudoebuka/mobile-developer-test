//
//  TeamSquadHelper.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/13/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ITeamSquad {
    func successful(responseJson:JSON,requestcode:Int,responseCode:Int)
    func failed(responseJson: JSON,requestcode:Int,responseCode:Int)
    func nilresponse()
}

class TeamsSquadHelper : IMakeAPICalls{
    
    
    
    var delegate : ITeamSquad!
    
    //URLs
    
    let TEAM_REQUEST_CODE: Int = 1;
    
    func doTeamSquadCall(_ endPartUrl:String) {
        APICalls.makeGetRequestWithHeader(endPartUrl, self, TEAM_REQUEST_CODE)
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
