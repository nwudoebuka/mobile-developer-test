//
//  LeagueTeamsViewController.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/10/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit

class LeagueTeamsViewController: UIViewController {
var db: OpaquePointer?
  
   static var selectedTeamLogo = UIImage()
    @IBOutlet var collectionV: UICollectionView!
    var collectionArray = [[String:String]]()
      var loaderView: UIView = UIView();
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let sqlitModel = SQLiteModel()
        let SELECTED_ID = String(UserDefaults.standard.integer(forKey: "selectedLeague"))
        collectionArray = sqlitModel.getTeams(db: self.db, leagueId: SELECTED_ID )
       collectionV.reloadData()
   
    }
    


}
