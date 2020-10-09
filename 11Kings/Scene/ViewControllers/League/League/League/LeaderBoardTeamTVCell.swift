//
//  LeaderBoardTeamTVCell.swift
//  Club11
//
//  Created by Developer on 09/06/19.
//

import UIKit

class LeaderBoardTeamTVCell: UITableViewCell {

    @IBOutlet weak var aYouWonAmount: UILabel!
    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    @IBOutlet weak var aPointLabel: UILabel!
    @IBOutlet weak var aRankLabel: UILabel!
    @IBOutlet weak var aArrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureCell(teams: LeaderBoardResponse, homeType: HomeType) {
        switch homeType {
        case .upcomming:
            aRankLabel.isHidden = true
            aPointLabel.isHidden = true
            aArrowImageView.isHidden = true
            aYouWonAmount.isHidden = true
            aYouWonAmount.text = ""
            aYouWonAmount.textColor = UIColor(red: 93 / 255, green: 180 / 255, blue: 84 / 255, alpha: 1.0)
            self.backgroundColor = .white
        case .live:
            aRankLabel.isHidden = false
            aPointLabel.isHidden = false
            aArrowImageView.isHidden = true
            aYouWonAmount.isHidden = true
            aYouWonAmount.text = ""
            aYouWonAmount.textColor = UIColor(red: 93 / 255, green: 180 / 255, blue: 84 / 255, alpha: 1.0)
            if teams.rank == 1 {
                self.backgroundColor = UIColor(red: 255 / 255, green: 123 / 255, blue: 59 / 255, alpha: 0.25)
            } else {
                self.backgroundColor = .white
            }
        case .result:
            aRankLabel.isHidden = false
            aPointLabel.isHidden = false
            aArrowImageView.isHidden = true
            aYouWonAmount.isHidden = false
            aYouWonAmount.text = "You won \(kRupeeIcon)\(teams.winingamount ?? "0")"
            aYouWonAmount.textColor = UIColor(red: 93 / 255, green: 180 / 255, blue: 84 / 255, alpha: 1.0)
        }
        aTeamNameLabel.text = "\(teams.team_name ?? "Team")"
        aPointLabel.text = teams.points ?? "0.0"
        aRankLabel.text = "\(teams.rank ?? 0)"
        if let arrowName = teams.arrowname {
            if arrowName == "up-arrow" {
                aArrowImageView.image = UIImage(named: "arrow_up")
            } else {
                aArrowImageView.image = UIImage(named: "arrow_down")
            }
        }
    }
    
}
