//
//  PlayerStaticsTVCell.swift
//  Club11
//
//  Created by Developer on 26/06/19.
//

import UIKit

class PlayerStaticsTVCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var aPointsLabel: UILabel!
    @IBOutlet weak var aActualLabel: UILabel!
    @IBOutlet weak var aEventLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(data: PlayerDetailInfoTable) {
        date.text = data.matchdate
        aPointsLabel.text = data.total_points
        aEventLabel.text = data.short_name
        aActualLabel.text = data.selectper
          aActualLabel.isHidden = false
    }
    
    func ConfigureMatchCell(data:GetMatchleaderBoard) {
        date.text = data.created
        aPointsLabel.text = data.points
        aEventLabel.text = data.name
        aActualLabel.isHidden = true
//        aActualLabel.text = data.selectper
    }
}
