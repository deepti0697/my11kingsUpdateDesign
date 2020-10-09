//
//  MyChallengeTableViewCell.swift
//  Club11
//
//  Created by Developer on 28/05/19.
//

import UIKit

class MyChallengeTableViewCell: UITableViewCell {

    @IBOutlet weak var aYourWinLabel: UILabel!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aWinnerLabel: UILabel!
    @IBOutlet weak var aPointsLabel: UILabel!
    @IBOutlet weak var aJoinWithLabel: UILabel!
    @IBOutlet weak var aWinningLabel: UILabel!
    @IBOutlet weak var aEntryFeeLabel: UILabel!
    @IBOutlet weak var aRankLabel: UILabel!
    @IBOutlet weak var aWinAmoutntHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aContainerView.setCornerRadius(value: 5)
    }
    
    func configureCell(challenge: ChallengeRespnse, homeType: HomeType) {
        aWinnerLabel.text = "\(challenge.totalwinners ?? "")"
        aPointsLabel.text = "\(challenge.joinedusers ?? 0)"
        aJoinWithLabel.text = challenge.join_with
        aWinningLabel.text = challenge.name as? String
        aEntryFeeLabel.text = "Rs.\(challenge.entryfee ?? 0)"
        aRankLabel.text = "#\(challenge.userrank ?? 0)"
        aWinAmoutntHeightConstraint.constant = homeType == .live ? 35 : 35
        aYourWinLabel.text = "\(kRupeeIcon)\(challenge.winning_amount ?? "0")"
        aYourWinLabel.isHidden = homeType == .live ? true : false
        
    }
    
    @IBAction func winnerButtonAction(_ sender: UIButton) {
        
    }
}
