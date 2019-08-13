//
//  TeamInfoViewController.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/12/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit
protocol Islide {
    func performSlide()
    
}
class TeamInfoViewController: UIViewController,TSSlidingUpPanelDraggingDelegate,TSSlidingUpPanelAnimationDelegate,Islide{
 
    @IBOutlet var teamName: UILabel!
    @IBAction func cancleBtnAction(_ sender: Any) {
         slidingUpManager.changeSlideUpPanelStateTo(toState: .DOCKED)
        view.isHidden = true
    }
    @IBOutlet var tableV: UITableView!
    @IBAction func slideAction(_ sender: Any) {
        
        if slidingUpManager.getSlideUpPanelState() == .DOCKED {
            slidingUpManager.changeSlideUpPanelStateTo(toState: .OPENED)
        } else {
            slidingUpManager.changeSlideUpPanelStateTo(toState: .DOCKED)
        }
    }
    @IBOutlet var topBar: UIView!
    @IBOutlet var logo: UIImageView!
    static var slidedelegate:Islide!
    let slidingUpManager: TSSlidingUpPanelManager = TSSlidingUpPanelManager.with
    var teamMembersArray = [[String:String]]()
    static var selectedteamIndex = String()
    var db: OpaquePointer?
    var teamInfoArray = [[String:String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = LeagueTeamsViewController.selectedTeamLogo
      
     
       addShadow(topBar)
        TeamInfoViewController.slidedelegate = self
        view.isHidden = true
        slidingUpManager.slidingUpPanelDraggingDelegate = self
        slidingUpManager.slidingUpPanelAnimationDelegate = self
        tableV.tableFooterView = UIView()
        // Do any additional setup after loading the view.
   
    }
    func setLogo(){
        let sqlitModel = SQLiteModel()
        let SELECTED_ID = String(UserDefaults.standard.integer(forKey: "selectedLeague"))
        teamInfoArray = sqlitModel.getTeams(db: self.db, leagueId: SELECTED_ID )
        
        if TeamInfoViewController.selectedteamIndex == ""{
            logo.image = UIImage(named: "football")
        }else{
            getImagefromURL(TeamInfoViewController.selectedteamIndex as! String, logo)
        }
    }
    func performSlide(){
        view.isHidden = false
           slidingUpManager.changeSlideUpPanelStateTo(toState: .OPENED)
        let sqliteModel = SQLiteModel()
         teamMembersArray =  sqliteModel.getSquad(db: self.db, teamId: UserDefaults.standard.string(forKey: "selectedSquad") as! String)
       teamName.text = UserDefaults.standard.string(forKey: "team")
        tableV.reloadData()
        setLogo()

    }
    func slidingUpPanelStartDragging(startYPos: CGFloat) {
        
    }
    
    func slidingUpPanelDraggingFinished(delta: CGFloat) {
        
    }
    
    func slidingUpPanelDraggingVertically(yPos: CGFloat) {
        let dismissBtnRotationDegree = slidingUpManager.scaleNumber(oldValue: yPos, newMin: 0, newMax: CGFloat(Double.pi))
        
        //slideBtn.transform = CGAffineTransform(rotationAngle: dismissBtnRotationDegree)
    }
    
    func slidingUpPanelAnimationStart(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
        
        var rotationAngle: CGFloat = 0.0
        print("[SUSlidingUpVC::animationStart] sliding Up Panel state=\(slidingUpCurrentPanelState) yPos=\(yPos)")
        
        switch slidingUpCurrentPanelState {
            
        case .OPENED:
            rotationAngle = CGFloat(Double.pi)
            break
        case .DOCKED:
            rotationAngle = 0.0
            break
        case .CLOSED:
            rotationAngle = CGFloat(Double.pi)
            break;
        }
        
        UIView.animate(withDuration: withDuration, animations: {
            //self.slideBtn.transform = CGAffineTransform(rotationAngle: rotationAngle)
        })
        
    }
    
    func slidingUpPanelAnimationFinished(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
        print("[SUSlidingUpVC::animationFinished] sliding Up Panel state=\(slidingUpCurrentPanelState) yPos=\(yPos)")
        
    }
    
    
    func getImagefromURL(_ urlString:String,_ imgView:UIImageView){
        
        
        let session = URLSession(configuration: .default)
        
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: URL(string:urlString)!) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                
            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    
                    //checking if the response contains an image
                    if let imageData = data {
                        
                        //getting the image
                        let image = UIImage(data: imageData)
                        let last3 = urlString.suffix(3)
                        self.setImage(img: image ?? UIImage(named: "football")!, imgView: imgView, imgExtension: String(last3),data:data!)
                        
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        
        //starting the download task
        getImageFromUrl.resume()
        
    }
    
    func setImage(img:UIImage,imgView:UIImageView,imgExtension:String,data:Data){
        DispatchQueue.main.async {
            if imgExtension == "svg"{
                
                if let anSVGImage: SVGKImage = SVGKImage(data: data){
                    imgView.image = anSVGImage.uiImage
                }else{
                    imgView.image = UIImage(named: "football")
                }
            }else{
                imgView.image = img
            }
        }
        
    }
    
}
