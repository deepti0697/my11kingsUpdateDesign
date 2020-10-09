//
//  CompareTableViewCell.swift
//  11Kings
//
//  Created by uu on 09/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class CompareTableViewCell: UITableViewCell {
    @IBOutlet weak var team1Image: UIImageView!
    
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Point: UILabel!
   
    @IBOutlet weak var team2Captain: UILabel!
    @IBOutlet weak var team1Captain: UILabel!
    @IBOutlet weak var team1Detail: UILabel!
    @IBOutlet weak var team2detail: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team1Point: UILabel!
    @IBOutlet weak var team2Image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        team1Captain.setCornerRadius(value: 10)
        team2Captain.setCornerRadius(value: 10)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
