//
//  CompetitionViewController.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/8/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit
import SwiftyJSON
import  SQLite3
class CompetitionViewController: UIViewController{
  
    
    @IBOutlet var topVHolder: UIView!
    @IBOutlet var tableV: UITableView!
    var lgName = ""
    var lgid = ""
    var lgnumber = ""
    var leagueArray:[[String:String]] = [[String:String]]()
       let availableCompetetions:[Int] =  [2000,2001,2002,2003,2013,2014,2015,2016,2017,2018,2019,2021]
     var loaderView: UIView = UIView();
   
    var db: OpaquePointer?
   
    internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow(topVHolder)
        tableV.estimatedRowHeight = 110.5
        tableV.tableFooterView = UIView()
        tableV.reloadData()
        showAlertbox("Free API", "please note: not all leagues are available for free APIs from https://api.football-data.org")
        
    }

 
 
}
