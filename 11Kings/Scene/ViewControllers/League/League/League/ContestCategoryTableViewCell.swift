//
//  ContestCategoryTableViewCell.swift
//  FantasyCrick2Part
//
//  Created by Developer on 09/05/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ContestCategoryTableViewCell: UITableViewCell {
    
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
    var challengeID = 0
    var contestAmount = 0.0
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
    
    func configureCell(league: Leagues) {
        challengeID = league.id ?? 0
        aEntreeFeeLabel.text = kRupeeIcon + "\(league.entryfee ?? 0.0)"
        aTotalWinnerLabel.text = "Winners \(Int(league.totalwinners ?? "0") ?? 0)"
        aTotlaSpotsLabel.text = "\(league.maximum_user ?? 0) Teams"
        aAmountLabel.text = "\(kRupeeIcon)\(league.win_amount ?? 0)"
        winningAmmount = league.win_amount ?? 0
        contestAmount = league.entryfee ?? 0.0
        if league.is_bonus != 0 {
            showBonusView(show: true)
        } else {
            showBonusView(show: false)
        }
        if league.confirmed_challenge != 0 {
            showConfirmView(show: true)
        } else {
            showConfirmView(show: false)
        }
        if league.multi_entry != 0 {
            showMultipleView(show: true)
        } else {
            showMultipleView(show: false)
        }
        let totalSpot = Float(league.maximum_user ?? 0)
        let joinedSpot = Float(league.joinedusers ?? 0)
        let remainingSpot = totalSpot - joinedSpot
        if totalSpot == joinedSpot {
            aLeftSpotsLabel.text = "Challenge Closed"
        } else {
            aLeftSpotsLabel.text = "Only \(Int(remainingSpot)) Spot left"
        }
        let progressValue = joinedSpot / totalSpot
        aProgressView.progress = Float(progressValue)
    }
    
    fileprivate func showBonusView(show: Bool) {
        aBonusLabel.isHidden = !show
        aBonusLabelWidthConstraint.constant = show ? 15 : 0
    }
    
    fileprivate func showConfirmView(show: Bool) {
        aConfirmLabel.isHidden = !show
        aConfirmLabelWidthConstraint.constant = show ? 15 : 0
    }
    
    fileprivate func showMultipleView(show: Bool) {
        aMultipleLabel.isHidden = !show
        aMultipleLabelWidthConstraint.constant = show ? 15 : 0
    }
    
    @IBAction func joinButtonAction(_ sender: UIButton) {
        joinButtonClouser(challengeID, contestAmount)
    }
    
    @IBAction func winnerButtonAction(_ sender: UIButton) {
        winnerButtonClouser(challengeID, winningAmmount)
    }
}
