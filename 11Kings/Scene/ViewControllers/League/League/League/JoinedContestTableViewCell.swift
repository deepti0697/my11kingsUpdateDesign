//
//  JoinedContestTableViewCell.swift
//  Club11
//
//  Created by Developer on 29/05/19.
//

import UIKit

class JoinedContestTableViewCell: UITableViewCell {

    @IBOutlet weak var aTotalWinnerLabel: UILabel!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aEntreeFeeLabel: UILabel!
    @IBOutlet weak var aJoinButton: UIButton!
    @IBOutlet weak var aBonusLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var aConfirmLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var aMultipleLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var aBonusLabel: UILabel!
    @IBOutlet weak var aConfirmLabel: UILabel!
    @IBOutlet weak var aMultipleLabel: UILabel!
    @IBOutlet weak var aTotlaSpotsLabel: UILabel!
    @IBOutlet weak var aLeftSpotsLabel: UILabel!
    @IBOutlet weak var aAmountLabel: UILabel!
    @IBOutlet weak var aProgressView: UIProgressView!
    @IBOutlet weak var aWinnersButton: UIButton!
    
    var winnerButtonClouser: ((Int, Double) -> Void) = { _, _ in}
    var joinButtonClouser: ((Int, Double) -> Void) = { _, _ in}
    var inviteButtonClouser: ((String) -> Void) = { _ in}
    var challengeID = 0
    var contestAmount = 0.0
    var inviteCode = ""
    var winningAmmount = 0.0

    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadius()
        setInitialSetup()
        aProgressView.transform = aProgressView.transform.scaledBy(x: 1, y: 2)
    }

    fileprivate func setInitialSetup() {
        showBonusView(show: false)
        showConfirmView(show: false)
        showMultipleView(show: false)
    }
    
    fileprivate func setCornerRadius() {
        aContainerView.setCornerRadius(value: 5)
        self.setCornerRadius(value: 10)
        aBonusLabel.setCornerRadius(value: 2)
        aConfirmLabel.setCornerRadius(value: 2)
        aMultipleLabel.setCornerRadius(value: 2)
        aBonusLabel.setBorder(color: .lightGray, size: 1)
        aConfirmLabel.setBorder(color: .lightGray, size: 1)
        aMultipleLabel.setBorder(color: .lightGray, size: 1)
        aJoinButton.setBorderButton(color: .orange, size: 1)
        aJoinButton.setCornerRadiusButton(value: 3)
    }
    
    func configureCell(data: JoinLeagueResponse) {
        challengeID = data.challenge_id ?? 0
        aEntreeFeeLabel.text = "\(data.entryfee ?? 0)"
        contestAmount = data.entryfee ?? 0
        aTotalWinnerLabel.text = "Winners \(data.totalwinners ?? 0)"
        aTotlaSpotsLabel.text = "\(data.maximum_user ?? 0) Teams"
        aLeftSpotsLabel.text = "\(data.joinedusers ?? 0)"
        aAmountLabel.text = "\(data.winamount ?? 0)"
        winningAmmount = data.winamount ?? 0
//        if data.is_bonus != 0 {
//            showBonusView(show: true)
//        }
        if data.confirmed == 1 {
            showConfirmView(show: true)
        } else {
            showConfirmView(show: false)
        }
        if data.multi_entry == 1 {
            showMultipleView(show: true)
            aJoinButton.setTitle("Join", for: .normal)
        } else {
            aJoinButton.setTitle("Invite", for: .normal)
            showMultipleView(show: false)
        }
        let totalSpot = Float(data.maximum_user ?? 0)
        let joinedSpot = Float(data.joinedusers ?? 0)
        let remainingSpot = totalSpot - joinedSpot
        if totalSpot == joinedSpot {
            aLeftSpotsLabel.text = "Challenge Closed"
        } else {
            aLeftSpotsLabel.text = "Only \(Int(remainingSpot)) Spot left"
        }
        let progressValue = joinedSpot / totalSpot
        aProgressView.progress = Float(progressValue)
        inviteCode = data.refercode ?? ""
    }
    
    fileprivate func showBonusView(show: Bool) {
        aBonusLabel.isHidden = !show
        aBonusLabelWidthConstraint.constant = show ? 20 : 0
    }
    
    fileprivate func showConfirmView(show: Bool) {
        aConfirmLabel.isHidden = !show
        aConfirmLabelWidthConstraint.constant = show ? 20 : 0
    }
    
    fileprivate func showMultipleView(show: Bool) {
        aMultipleLabel.isHidden = !show
        aMultipleLabelWidthConstraint.constant = show ? 20 : 0
    }
    @IBAction func joinButtonAction(_ sender: UIButton) {
        if aJoinButton.titleLabel?.text == "Join" {
            joinButtonClouser(challengeID, contestAmount)
        } else {
            inviteButtonClouser(inviteCode)
        }
    }
    
    @IBAction func winnerButtonAction(_ sender: UIButton) {
        winnerButtonClouser(challengeID, winningAmmount)
    }
}
