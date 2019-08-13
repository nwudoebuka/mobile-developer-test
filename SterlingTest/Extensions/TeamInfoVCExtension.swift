//
//  TeamInfoVCExtension.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/13/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import Foundation
import UIKit
extension TeamInfoViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamMembersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cellteaminfo", for: indexPath) as! TeamInfoCell
        
        cell.number.text = teamMembersArray[indexPath.row]["number"]
        cell.name.text = teamMembersArray[indexPath.row]["name"]
        cell.position.text = teamMembersArray[indexPath.row]["position"]
        return cell
    }
    

}
