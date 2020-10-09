//
//  TeamPopoverTableViewCell.swift
//  Club11
//
//  Created by Developer on 09/06/19.
//

import UIKit

class TeamPopoverTableViewCell: UITableViewCell {

    @IBOutlet weak var aTeamNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(team: MyTeamResponse) {
        aTeamNameLabel.text = "Team \(team.teamnumber ?? 0)"
    }
    
}
