//
//  KabaddiTeamcountCollectionViewCell.swift
//  DreamTeam
//
//  Created by Test on 05/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class KabaddiTeamCountCollectionViewCell: UICollectionViewCell {
    

    
    @IBOutlet weak var aimageView: UIImageView!
    @IBOutlet weak var aLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aLabel.setCornerRadius(value: ScreenSize.SCREEN_WIDTH / 30)
    }
    
    func configureCell(index: Int) {
        if index == 8 {
            aLabel.text = "8"
            aLabel.textColor = .clear
            aLabel.backgroundColor = .clear
               aimageView.image = #imageLiteral(resourceName: "countUnfill")
        } else {
            aLabel.textColor = .clear
            aLabel.backgroundColor = .clear
            aimageView.image = #imageLiteral(resourceName: "countUnfill")
            
        }
        for (num, _) in APP_DEL.kabbaddiChoosedTeamArray.enumerated() {
            if index <= num {
                aLabel.text = "\(index + 1)"
                aLabel.textColor = .clear
                aimageView.image = #imageLiteral(resourceName: "countFill")
                           }
        }
    }
}

