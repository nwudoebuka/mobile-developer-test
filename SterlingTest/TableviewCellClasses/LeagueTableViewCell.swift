//
//  LeagueTableViewCell.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/9/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var teamname: UILabel!
    @IBOutlet weak var win: UILabel!
    @IBOutlet weak var draw: UILabel!
    @IBOutlet weak var lost: UILabel!
    @IBOutlet weak var position: UILabel!
    
    override func prepareForReuse() {
        logo.image = UIImage(named: "football")
        teamname.text = ""
        win.text = ""
        draw.text = ""
        lost.text = ""
        position.text = ""
    }

}
