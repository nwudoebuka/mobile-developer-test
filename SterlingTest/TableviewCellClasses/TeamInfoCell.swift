//
//  TeamInfoCell.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/13/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit

class TeamInfoCell: UITableViewCell {

    
        @IBOutlet weak var number: UILabel!
        @IBOutlet weak var name: UILabel!
        @IBOutlet weak var position: UILabel!
        override func prepareForReuse() {
       
            number.text = ""
            name.text = ""
            position.text = ""
          
        }
   


}
