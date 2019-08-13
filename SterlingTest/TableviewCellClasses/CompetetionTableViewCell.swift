//
//  CompetetionTableViewCell.swift
//  SterlingTest
//
//  Created by Nwudo Ebuka on 8/8/19.
//  Copyright © 2019 Nuture Tech. All rights reserved.
//

import UIKit

class CompetetionTableViewCell: UITableViewCell {
    @IBOutlet weak var competetionNumber: UILabel!
    @IBOutlet weak var competetionName: UILabel!
    @IBOutlet weak var ID: UILabel!
    override func prepareForReuse() {
        competetionNumber.textColor = UIColor.gray
        competetionNumber.text = ""
        competetionName.text = ""
        competetionName.textColor = UIColor.gray
    }
}
