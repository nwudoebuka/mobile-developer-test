//
//  TodayFixtureVCExtension.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/11/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import UIKit
extension TodayFixtureViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfFixtures
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "celltodayfixture", for: indexPath) as! TodayFixtureTableTableViewCell
        let sqliteModel = SQLiteModel()
        print("data is \(sqliteModel.getTodayFix(db: self.db))")
        cell.hometeam.text = sqliteModel.getTodayFix(db: self.db)[indexPath.row]["hometeam"]
        cell.awayteam.text = sqliteModel.getTodayFix(db: self.db)[indexPath.row]["awayteam"]
        cell.fullhomescore.text = sqliteModel.getTodayFix(db: self.db)[indexPath.row]["fullhomescore"]
        cell.fullawayscore.text = sqliteModel.getTodayFix(db: self.db)[indexPath.row]["fullawayscore"]
        let rawTime = sqliteModel.getTodayFix(db: self.db)[indexPath.row]["time"]
        cell.time.text = formatTime(rawTime!)
        
        cell.halfscore.text = sqliteModel.getTodayFix(db: self.db)[indexPath.row]["fullhomescore"]!+" "+sqliteModel.getTodayFix(db: self.db)[indexPath.row]["fullawayscore"]!
        cell.status.text = sqliteModel.getTodayFix(db: self.db)[indexPath.row]["status"]
        return cell
    }

    func formatTime(_ str:String)->String{
        let fullString = str
        let fullTimeArr = fullString.split{$0 == "T"}.map(String.init)
        return fullTimeArr[1].replacingOccurrences(of: "Z", with: "") // Last
    }
}
