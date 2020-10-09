//
//  PlayerStaticsTVCell.swift
//  Club11
//
//  Created by Developer on 26/06/19.
//

import UIKit

class playerDetailMatchTVCell: UITableViewCell {

    @IBOutlet weak var aPointsLabel: UILabel!
    @IBOutlet weak var aActualLabel: UILabel!
    @IBOutlet weak var aEventLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(data: PlayerPointBreakup) {
        aPointsLabel.text = "\(data.actual_points )"
        aActualLabel.text = data.actual ?? ""
        aEventLabel.text = data.event_name ?? ""
    }
    
}
