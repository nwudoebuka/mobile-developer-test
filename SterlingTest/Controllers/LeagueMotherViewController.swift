//
//  LeagueMotherViewController.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/10/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol Igetstandings{
    func reloadData()
}

class LeagueMotherViewController: UIViewController,IStanding,ITeam,TSSlidingUpPanelStateDelegate{
 
  
     let slideUpPanelManager = TSSlidingUpPanelManager.with
    var loaderView: UIView = UIView();
    @IBOutlet var containerV: UIView!
    var db: OpaquePointer?
    @IBAction func backBtnAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    static var delegate:Igetstandings!
    @IBOutlet var tableBtnOutlt: UIButton!
    @IBAction func tableBtnAction(_ sender: Any) {
       
        showTables()
        slideUp()
       
        
    }
    func slideUp(){
        switch slideUpPanelManager.getSlideUpPanelState() {
        case .OPENED:
            slideUpPanelManager.changeSlideUpPanelStateTo(toState: .DOCKED)
            break
        case .CLOSED:
            slideUpPanelManager.changeSlideUpPanelStateTo(toState: .DOCKED)
            break
        case .DOCKED:
            slideUpPanelManager.changeSlideUpPanelStateTo(toState: .CLOSED)
            break
        }
    }
    @IBAction func fixtureBtnAction(_ sender: Any) {
        showFixtures()
    }
   
    @IBOutlet var fixtureBtnoutlt: UIButton!
    @IBAction func teamBtnAction(_ sender: Any) {
        showTeams()
    }
    
    @IBOutlet var teamBtnOutlt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loaderView = displaySpinner(onView: self.view)
         slideUpPanelManager.slidingUpPanelStateDelegate = self
       
      getStandings()
        
    }
   
    func getStandings(){
        let SELECTED_ID = String(UserDefaults.standard.integer(forKey: "selectedLeague"))
        let sqlitModel = SQLiteModel()
        sqlitModel.deleteStanding(db: self.db,id: SELECTED_ID)
        let STANDING_URL_END_PART: String = "/v2/competitions/"+SELECTED_ID+"/standings";
        print("url is \(STANDING_URL_END_PART)")
        let standingHelper = StandingsHelper()
        standingHelper.delegate = self
        standingHelper.doStandingCall(STANDING_URL_END_PART)
     
        
        
    }
    func showTables(){
        let newVC = UIStoryboard(name: "LeagueElements", bundle: nil).instantiateViewController(withIdentifier: "lgtablevc")
        changeView(newVC)
        setSelectedColor("table")
        LeagueMotherViewController.delegate.reloadData()
    }
    func showFixtures(){
        
        let newVC = UIStoryboard(name: "LeagueElements", bundle: nil).instantiateViewController(withIdentifier: "lgfixturevc")
        changeView(newVC)
        setSelectedColor("fixture")
    }
    func showTeams(){
        
        let newVC = UIStoryboard(name: "LeagueElements", bundle: nil).instantiateViewController(withIdentifier: "lgteamsvc")
        changeView(newVC)
        setSelectedColor("team")
    }
    
    func setSelectedColor(_ btn:String){
        switch btn {
        case "table":
            tableBtnOutlt.setTitleColor(UIColor.black, for: .normal)
            fixtureBtnoutlt.setTitleColor(UIColor.gray, for: .normal)
            teamBtnOutlt.setTitleColor(UIColor.gray, for: .normal)
        case "fixture":
            tableBtnOutlt.setTitleColor(UIColor.gray, for: .normal)
            fixtureBtnoutlt.setTitleColor(UIColor.black, for: .normal)
            teamBtnOutlt.setTitleColor(UIColor.gray, for: .normal)
        case "team":
            tableBtnOutlt.setTitleColor(UIColor.gray, for: .normal)
            fixtureBtnoutlt.setTitleColor(UIColor.gray, for: .normal)
            teamBtnOutlt.setTitleColor(UIColor.black, for: .normal)
        default:
            tableBtnOutlt.setTitleColor(UIColor.black, for: .normal)
            fixtureBtnoutlt.setTitleColor(UIColor.gray, for: .normal)
            teamBtnOutlt.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    func cycle(from oldVC: UIViewController, to newVC: UIViewController) {
        // Prepare the two view controllers for the change.
        oldVC.willMove(toParent: nil)
        addChild(newVC)
        
        // Get the final frame of the new view controller.
        newVC.view.frame = containerV.bounds
        
        // Queue up the transition animation.
        transition(from: oldVC, to: newVC, duration: 0.25, options: .transitionCrossDissolve, animations: {
            // this is intentionally blank; transitionCrossDissolve will do the work for us
        }, completion: { finished in
            oldVC.removeFromParent()
            newVC.didMove(toParent: self)
        })
    }
    
    func changeView(_ newVC:UIViewController) {
        let oldVC = children.first!
        
        
        cycle(from: oldVC, to: newVC)
    }
    
    func successful(responseJson: JSON, requestcode: Int, responseCode: Int) {
        
        switch requestcode {
        case 1:
             getTableValues(responseJson["standings"][0]["table"])
            getTeams()
        case 2:
            print("teams are \(responseJson)")
            for i in 0...responseJson["teams"].count{
            let SELECTED_ID = String(UserDefaults.standard.integer(forKey: "selectedLeague"))
            let logo = responseJson["teams"][i]["crestUrl"].stringValue
            let name = responseJson["teams"][i]["name"].stringValue
            let teamid = responseJson["teams"][i]["id"].stringValue
            let sqlitModel = SQLiteModel()
                 print("single team is \(logo) and \(name)")
                sqlitModel.insertTeams(db: self.db, logo: logo as NSString, name: name as NSString, leagueId: SELECTED_ID as NSString, teamid: teamid as NSString)
            }
            
            removeSpinner(spinner: loaderView)
        default:
            removeSpinner(spinner: loaderView)
        }
        
      
    }
    func getTeams(){
        let SELECTED_ID = String(UserDefaults.standard.integer(forKey: "selectedLeague"))
        let sqlitModel = SQLiteModel()
        sqlitModel.deleteTeams(db: self.db,id: SELECTED_ID)
        let TEAM_URL_END_PART: String = "/v2/competitions/"+SELECTED_ID+"/teams";
        let teamHelper = TeamsHelper()
        teamHelper.delegate = self
        teamHelper.doTeamCall(TEAM_URL_END_PART)
        
    }
    func getTableValues(_ tableResult:JSON){
        print("table results are \(tableResult)")
        if tableResult.count == 0 {
             LeagueMotherViewController.delegate.reloadData()
            return
        }
        for i in 0...tableResult.count - 1{
            let name = tableResult[i]["team"]["name"].stringValue
            let logo = tableResult[i]["team"]["crestUrl"].stringValue
            let win = String(tableResult[i]["won"].intValue)
            let draw = String(tableResult[i]["draw"].intValue)
            let lost = String(tableResult[i]["lost"].intValue)
            let position = String(tableResult[i]["position"].intValue)
            let leagueId = String(UserDefaults.standard.integer(forKey: "selectedLeague"))
            let sqliteModel = SQLiteModel()
            sqliteModel.insertStandings(db: self.db, logo: logo as NSString, team: name as NSString, win: win as NSString, draw: draw as NSString, lost: lost as NSString, position: position as NSString, leagueId: leagueId as NSString)
           
            LeagueMotherViewController.delegate.reloadData()

        }
    }
    func failed(responseJson: JSON, requestcode: Int, responseCode: Int) {
        removeSpinner(spinner: loaderView)
        print(responseJson)
    }
    func nilresponse() {
        removeSpinner(spinner: loaderView)
        Toast.showError(message: "Error...check internet", controller: self)
    }
    
    func slidingUpPanelStateChanged(slidingUpPanelNewState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
        print("[SUFirstScreenVC::slidingUpPanelStateChanged] slidingUpPanelNewState=\(slidingUpPanelNewState) yPos=\(yPos)")
    }
}
