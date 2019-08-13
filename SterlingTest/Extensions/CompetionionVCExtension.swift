//
//  CompetionionVCExtension.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/8/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import UIKit
import SQLite3
extension CompetitionViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaults.standard.integer(forKey: "numberofcompetitions")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let sqliteModel = SQLiteModel()
        print(sqliteModel.getCompetitions(db: self.db))
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "competitionCell", for: indexPath) as! CompetetionTableViewCell
        let data = sqliteModel.getCompetitions(db: self.db)
        cell.ID.text = data[indexPath.row]["id"]
        cell.competetionNumber.text = data[indexPath.row]["number"]
        cell.competetionName.text = data[indexPath.row]["name"]
        if !checkIfAvailableForFreeApi(Int(cell.ID.text!)!){
            cell.competetionName.textColor = UIColor.gray
            cell.competetionNumber.textColor = UIColor.gray
        }else{
            cell.competetionName.textColor = UIColor.black
            cell.competetionNumber.textColor = UIColor.black
        }
        return cell
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CompetetionTableViewCell
        
        if !checkIfAvailableForFreeApi(Int(cell.ID.text!)!){
            Toast.showInfo(message: "Unavailable for free APIs", controller: self)
        }else{
            UserDefaults.standard.set(Int(cell.ID.text!)!, forKey: "selectedLeague")
            customPresentVC("Main", "slidetab")
        }
    }
    
    func checkIfAvailableForFreeApi(_ id:Int)->Bool{
        
        for i in 0...availableCompetetions.count - 1{
            if id == availableCompetetions[i]{
                return true
                break
            }
        }
        
        return false
    }
    
    
}


