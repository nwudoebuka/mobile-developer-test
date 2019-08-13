//
//  TodayFixtureViewController.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/11/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit
import SwiftyJSON
class TodayFixtureViewController: UIViewController,ICompetition,ITodayFixture {
  
     var db: OpaquePointer?
     var loaderView: UIView = UIView();
    var numberOfFixtures = Int()
    let Today_Fixture_Request_Code = 2
    @IBOutlet var tableV: UITableView!
    @IBOutlet var noMatchLbl: UILabel!
    @IBOutlet var topVHolder: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tabBarController?.tabBar.isHidden = true
        let sqliteModel = SQLiteModel()
        sqliteModel.setUpSQlite(db: self.db)
        addShadow(topVHolder)
        
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0), execute: {
                self.loaderView = self.displaySpinner(onView: self.view)
                })
            
        tableV.tableFooterView = UIView()
        getAllcompetetions()
    }
    private func getAllcompetetions(){
        let competetionHelper =  CompetitionHelper()
        competetionHelper.delegate = self
        competetionHelper.doCompetetionCall()
    }

    private func gettodayFixtures(){
        let todayFixtureHelper = TodayFixtureHelper()
        todayFixtureHelper.delegate = self
        todayFixtureHelper.doTodayfixtureCall()
    }
    func successful(responseJson: JSON, requestcode: Int, responseCode: Int) {
        switch requestcode {
        case 1:
            handlesCompetitionResponse(responseJson: responseJson, requestcode: requestcode
                , responseCode: responseCode)
            gettodayFixtures()
        case 2:
            print("today is \(responseJson["count"].intValue)")
            if responseJson["count"].intValue < 1{
                tableV.isHidden = true
                noMatchLbl.isHidden = false
            }else{
                tableV.isHidden = false
                noMatchLbl.isHidden = true
                numberOfFixtures = responseJson["count"].intValue
                for i in 0...responseJson["count"].intValue - 1{
                    let status = responseJson["matches"][i]["status"].stringValue as NSString
                    let time = responseJson["matches"][i]["utcDate"].stringValue as NSString
                    let homeTeam = responseJson["matches"][i]["homeTeam"]["name"].stringValue  as NSString
                    let awayTeam =  responseJson["matches"][i]["awayTeam"]["name"].stringValue  as NSString
                    let fullHomeScore = responseJson["matches"][i]["score"]["fullTime"]["homeTeam"].stringValue  as NSString
                    let fullAwayScore = responseJson["matches"][i]["score"]["fullTime"]["awayTeam"].stringValue  as NSString
                    let halfHomeScore = responseJson["matches"][i]["score"]["halfTime"]["homeTeam"].stringValue  as NSString
                    let halfAwayScore = responseJson["matches"][i]["score"]["halfTime"]["awayTeam"].stringValue  as NSString
                     let sqliteModel = SQLiteModel()
                    sqliteModel.insertTodayFix(db: self.db, status: status, time: time, hometeam: homeTeam, awayteam: awayTeam, fullhomescore: fullHomeScore, fullawayscore: fullAwayScore, halfhomescore: halfHomeScore, halfawayscore: halfAwayScore)
                    
                   
                }
                
                
            }
           
            removeSpinner(spinner: loaderView)
            self.tabBarController?.tabBar.isHidden = false
            tableV.reloadData()
        default:
            handlesCompetitionResponse(responseJson: responseJson, requestcode: requestcode
                , responseCode: responseCode)
        }
        
    }
    
    func failed(responseJson: JSON, requestcode: Int, responseCode: Int) {
        removeSpinner(spinner: loaderView)
        Toast.showError(message: "Something went wrong", controller: self)
    }
    
    func nilresponse() {
        removeSpinner(spinner: loaderView)
        Toast.showError(message: "Error...check internet", controller: self)
    }
    
    func handlesCompetitionResponse(responseJson: JSON, requestcode: Int, responseCode: Int){
        print(responseJson)
        saveJSON(json: responseJson, key: "competetionObject")
        var numberOFCompettitions = UserDefaults.standard.set(getJSON("competetionObject")["competitions"].count, forKey: "numberofcompetitions")
        print("num is \(UserDefaults.standard.integer(forKey: "numberofcompetitions"))")
        
        if responseCode == 403{
            removeSpinner(spinner: loaderView)
            showAlertbox("Quota Exhausted", "free api quota has been exhausted")
            return
        }
        
      
        
        //
        
        
        for i in 0...UserDefaults.standard.integer(forKey: "numberofcompetitions") - 1{
            let name = getJSON("competetionObject")["competitions"][i]["name"].stringValue as NSString
            let leagueId =  getJSON("competetionObject")["competitions"][i]["id"].stringValue as NSString
            
            let sqliteModel = SQLiteModel()
            sqliteModel.insertCompetetions(db: self.db, name: name, leagueId: leagueId)
            
        }
    }
    
    
    
}
