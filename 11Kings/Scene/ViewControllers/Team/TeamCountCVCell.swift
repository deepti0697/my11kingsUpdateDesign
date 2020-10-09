//
//  TeamCountCVCell.swift
//  Club11
//
//  Created by Developer on 27/05/19.
//

import UIKit

class TeamCountCVCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var aimageView: UIImageView!
    @IBOutlet weak var aLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aLabel.setCornerRadius(value: ScreenSize.SCREEN_WIDTH / 30)
       contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0))
    }
    
    func configureCell(index: Int) {
        if index == 10 {
            aLabel.text = "11"
            aLabel.textColor = .white
            aLabel.backgroundColor = .clear
               aimageView.image = #imageLiteral(resourceName: "countUnfill")
        } else {
            aLabel.textColor = .clear
            aLabel.backgroundColor = .clear
            aimageView.image = #imageLiteral(resourceName: "countUnfill")
            
        }
        for (num, _) in APP_DEL.choosedTeamArray.enumerated() {
            if index <= num {
                aLabel.text = "\(index + 1)"
                aLabel.textColor = .white
                aimageView.image = #imageLiteral(resourceName: "countFill")
               // aLabel.backgroundColor = UIColor(red: 240, green: 136, blue: 33)
            }
        }
    }
    
}
