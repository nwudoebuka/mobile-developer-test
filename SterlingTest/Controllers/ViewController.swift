//
//  ViewController.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/8/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    
    @IBOutlet var logoCenterConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        removeAllSavedInstance()
        //testalamo()
      animateLogo()
    }

    func removeAllSavedInstance(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    func animateLogo(){
        let screenSize = UIScreen.main.bounds
        let halfScreenHeight = -screenSize.height/2
        
        UIView.animate(withDuration: 2) {
            self.logoCenterConstraint.constant = halfScreenHeight
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 2) {
            self.logoCenterConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.customPresentVC("Main", "competetionTab")
        }
        
    }
}

