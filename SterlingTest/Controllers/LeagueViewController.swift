//
//  LeagueViewController.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/9/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit

class LeagueViewController: UIViewController,Igetstandings {

    @IBOutlet var tableV: UITableView!
    @IBOutlet var noResult: UILabel!
    var numberOfStandings = Int()
    var standingsArray = [[String:String]]()
    var db: OpaquePointer?
    override func viewDidLoad() {
        super.viewDidLoad()
       LeagueMotherViewController.delegate = self
        let sqliteModel = SQLiteModel()
        sqliteModel.deleteAllTeams(db: self.db)
        tableV.tableFooterView = UIView()
       
    }

    func reloadData(){
        let leagueId = String(UserDefaults.standard.integer(forKey: "selectedLeague"))
        let sqliteModel = SQLiteModel()
        standingsArray = sqliteModel.getStandings(db: self.db, leagueId: leagueId)
        numberOfStandings = sqliteModel.getStandings(db: self.db, leagueId: leagueId).count
        print("standings now are \(numberOfStandings)")
        if numberOfStandings == 0{
            noResult.isHidden = false
            tableV.isHidden = true
        }
         tableV.reloadData()
    }
}
