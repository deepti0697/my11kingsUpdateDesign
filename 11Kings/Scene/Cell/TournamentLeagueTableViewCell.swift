//
//  TournamentLeagueTableViewCell.swift
//  11Kings
//
//  Created by uu on 24/08/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class TournamentLeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var tournamentLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
    }
    func configureCell(response:TournamentLeaderBoardResponse) {
        tournamentLbl.text = response.name
    }

}
