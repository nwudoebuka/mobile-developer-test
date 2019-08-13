//
//  UIViewControllerExtension.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/8/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import SwiftGifOrigin
import SQLite3

extension UIViewController{
    
    

    func customPresentVC(_ storyBoardName:String,_ identifier:String){
        
            let vc = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
            self.present(vc, animated: false, completion: nil)
        
    }
    //a method to save json to userdefalts as string
    func saveJSON(json: JSON, key:String){
        let defaults = UserDefaults.standard
        let jsonString = json.rawString()!
        defaults.setValue(jsonString, forKey: key)
        defaults.synchronize()
    }
    
    // a method to get json from userdefaults string
    func getJSON(_ key: String)->JSON {
        var p = ""
        let defaults = UserDefaults.standard
        if let buildNumber = defaults.value(forKey: key) as? String {
            p = buildNumber
        }else {
            p = ""
        }
        if  p != "" {
            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                return try! JSON(data: json)
            } else {
                return JSON("nil")
            }
        } else {
            return JSON("nil")
        }
    }
    

    func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)

        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.color = UIColor.black
        ai.startAnimating()
        ai.center = spinnerView.center
   
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            
            spinner.removeFromSuperview()
        }
    }
    
    func showAlertbox(_ title:String,_ msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func addShadow(_ view:UIView){
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = 1
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
}
