//
//  JoinedContestTableViewCell.swift
//  Club11
//
//  Created by Developer on 29/05/19.
//

import UIKit

class JoinedContestTableViewCell: UITableViewCell {
//    @IBOutlet weak var notificationLbl: UILabel!
     
    
//      @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var bonusPercnt: NSLayoutConstraint!
    @IBOutlet weak var bonousign: UILabel!
    @IBOutlet weak var aTotalWinnerLabel: UILabel!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aEntreeFeeLabel: UILabel!
   
    @IBOutlet weak var winnerLbl: UILabel!
    @IBOutlet weak var aBonusLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var aConfirmLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var multiCountLbl: UILabel!
    
    @IBOutlet weak var multicountWidthContstranit: NSLayoutConstraint!
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
    var homeType: HomeType = .live
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
       aConfirmLabel.roundCornersLbl(cornerRadius: 3.0)
        aEntreeFeeLabel.roundCornersLbl(cornerRadius: 3.0)
             bonousign.roundCornersLbl(cornerRadius: 3.0)
             multiCountLbl.roundCornersLbl(cornerRadius: 3.0)
       
    }
    
    func configureCell(data: myjoinedContest) {
          multiCountLbl.text = "\(data.max_team_limit ?? 0)"
        challengeID = data.challenge_id ?? 0
        aEntreeFeeLabel.text =  kRupeeIcon + "\(data.entryfee ?? 0)"
  winnerLbl.text = "\(data.first_rank_prize ?? 0)"
        contestAmount = Double(data.entryfee ?? 0)
        aTotalWinnerLabel.text = "\(data.totalwinners ?? 0) Team win"
        aTotlaSpotsLabel.text = "\(data.maximum_user ?? 0) spots"
        aLeftSpotsLabel.text = "\(data.joinedusers ?? 0)"
        aAmountLabel.text = "\(data.win_amount ?? 0)"
//        self.notificationLbl.text = data.announcement ?? ""
//        if notificationLbl.text != "" {
//             self.notificationLbl.slideInFromLeft()
//        }
//        else {
//            self.animationView.isHidden = true
//        }
        if data.challenge_type == "gadget" {
                   aAmountLabel.text = data.first_rank_prizes
                    winnerLbl.text = "\(data.first_rank_prizes ?? "")"
               }
               else {
                     winnerLbl.text = "\(data.first_rank_prize ?? 0)"
                    aAmountLabel.text = "\(kRupeeIcon)\(data.win_amount ?? 0)"
                 
               }
        if data.confirmed_challenge == 1 {
            showConfirmView(show: true)
        } else {
            
            showConfirmView(show: false)
        }
        if data.is_bonus != 0 {
                   showBonusView(show: true)
            bonousign.text = "\(data.bonus_percent ?? 0)%"
               } else {
                   showBonusView(show: false)
               }
        if data.multi_entry == 1 {
            showMultipleView(show: true)
//            aJoinButton.setTitle("Join", for: .normal)
        } else {
//            aJoinButton.setTitle("Invite", for: .normal)
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
        bonousign.isHidden = !show
        bonusPercnt.constant = show ? 25 : 0
        aBonusLabelWidthConstraint.constant = show ? 20 : 0
    }
    
    fileprivate func showConfirmView(show: Bool) {
        aConfirmLabel.isHidden = !show
        aConfirmLabelWidthConstraint.constant = show ? 20 : 0
    }
    
    fileprivate func showMultipleView(show: Bool) {
        aMultipleLabel.isHidden = !show
        aMultipleLabelWidthConstraint.constant = show ? 20 : 0
        multiCountLbl.isHidden = !show
        
               multicountWidthContstranit.constant = show ? 20:0
              
    }
    @IBAction func joinButtonAction(_ sender: UIButton) {
//        if aJoinButton.titleLabel?.text == "Join" {
//            joinButtonClouser(challengeID, contestAmount)
//        } else {
//            inviteButtonClouser(inviteCode)
//        }
    }
    
    @IBAction func winnerButtonAction(_ sender: UIButton) {
        winnerButtonClouser(challengeID, winningAmmount)
    }
}
