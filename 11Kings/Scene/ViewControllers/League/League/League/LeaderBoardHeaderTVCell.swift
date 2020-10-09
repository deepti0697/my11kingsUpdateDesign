//
//  LeaderBoardHeaderTVCell.swift
//  Club11
//
//  Created by Developer on 10/06/19.
//

import UIKit

class LeaderBoardHeaderTVCell: UITableViewCell {

    @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var aPointLabel: UILabel!
    @IBOutlet weak var aRankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configureCell(count: Int, homeType: HomeType) {
        aLabel.text = "Teams(\(count))"
        if homeType == .upcomming {
            aRankLabel.isHidden = true
            aPointLabel.isHidden = true
        } else {
            aRankLabel.isHidden = false
            aPointLabel.isHidden = false
        }
    }
    
}
