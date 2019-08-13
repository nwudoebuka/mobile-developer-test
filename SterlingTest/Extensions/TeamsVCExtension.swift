//
//  TeamsVCExtension.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/11/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
extension LeagueTeamsViewController:UICollectionViewDelegate,UICollectionViewDataSource,ITeamSquad{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TeamsCollectionViewCell
        TeamInfoViewController.selectedteamIndex = collectionArray[indexPath.row]["logo"]!
        UserDefaults.standard.set(cell.teamid.text, forKey: "selectedSquad")
        UserDefaults.standard.set(cell.name.text, forKey: "team")
        let url = "/v2/teams/"+cell.teamid.text!
        getTeamSquad(url: url)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellteams", for: indexPath) as! TeamsCollectionViewCell
        cell.name.text = collectionArray[indexPath.row]["name"]
        cell.teamid.text = collectionArray[indexPath.row]["teamid"]
        
        if collectionArray[indexPath.row]["logo"] == ""{
            cell.logo.image = UIImage(named: "football")
        }else{
            getImagefromURL(collectionArray[indexPath.row]["logo"] as! String, cell.logo)
        }
        addShadow(cell.mainVH)
        cell.mainVH.layer.cornerRadius = 10
        return cell
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
    
    
    func getTeamSquad(url:String){
        
        loaderView = displaySpinner(onView: self.view)
        
        let teamSqaudHelper = TeamsSquadHelper()
        teamSqaudHelper.delegate = self
        teamSqaudHelper.doTeamSquadCall(url)
        
    }
    func successful(responseJson: JSON, requestcode: Int, responseCode: Int) {
        removeSpinner(spinner: loaderView)
        let teamId = UserDefaults.standard.string(forKey: "selectedSquad") as! String
        let sqliteHelper = SQLiteModel()
        sqliteHelper.deleteSquad(db: self.db, id: teamId  as String)
        for i in 0...responseJson["squad"].count - 1{
            
            let name = responseJson["squad"][i]["name"].stringValue
            let number = responseJson["squad"][i]["shirtNumber"].stringValue
            let position = responseJson["squad"][i]["position"].stringValue
            sqliteHelper.insertSquad(db: self.db, number: number as NSString, name: name as NSString, position: position as NSString, logo: "nil", teamid: teamId as! NSString)
            print(UserDefaults.standard.string(forKey: "selectedSquad"))
        }
        
        
        TeamInfoViewController.slidedelegate.performSlide()
    }
    
    func failed(responseJson: JSON, requestcode: Int, responseCode: Int) {
        removeSpinner(spinner: loaderView)
        Toast.showError(message: "something went wrong", controller: self)
    }
    
    func nilresponse() {
        removeSpinner(spinner: loaderView)
        Toast.showError(message: "Error...check internet", controller: self)
    }
}
