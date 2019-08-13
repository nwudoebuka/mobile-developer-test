//
//  ApiCalls.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/8/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol IMakeAPICalls {
    func handleSuccessResponse(_ responseJson: JSON ,_ requestCode: Int,_ responseCode:Int)
    func handleFailureResponse(_ responseJson: JSON,_ requestCode: Int,_ responseCode:Int)
    func handlenilresponse()
}


class APICalls {
    
    static func makeGetRequestWithHeader (_ url : String ,_ listner : IMakeAPICalls,_ requestCode:Int) {
        
        let completeUrl : String = Constants.BASE_URL + url
        //"Authorization" :  "JWT "+Token2db+" "
        let headers: HTTPHeaders = [
            Constants.AUTH_HEADER_TYPE: Constants.API_KEY
        ]
        
        //my Webservice
        Alamofire.request(completeUrl,
                          method: .get,
                          headers: headers).responseJSON { response in
                            var responseCode = response.response?.statusCode
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                listner.handleSuccessResponse(json , requestCode, responseCode!)
                                
                            case .failure(let error):
                                let json = JSON(error)
                                if responseCode == nil{
                                    listner.handlenilresponse()
                                }else{
                                }
                            }
        }
    }
    
    
    
}
