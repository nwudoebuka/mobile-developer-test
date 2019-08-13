//
//  LeagueVCExtension.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/9/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import UIKit
extension LeagueViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfStandings
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellleague", for: indexPath) as! LeagueTableViewCell
        cell.teamname.text = standingsArray[indexPath.row]["name"]
        cell.win.text = standingsArray[indexPath.row]["win"]
        cell.draw.text = standingsArray[indexPath.row]["draw"]
        cell.lost.text = standingsArray[indexPath.row]["lost"]
        cell.position.text = standingsArray[indexPath.row]["position"]
        if standingsArray[indexPath.row]["logo"] == ""{
            cell.logo.image = UIImage(named: "football")
        }else{
        getImagefromURL(standingsArray[indexPath.row]["logo"] as! String, cell.logo)
        }
       
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
}
