//
//  ContestCategoryTableViewCell.swift
//  FantasyCrick2Part
//
//  Created by Developer on 09/05/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
protocol openConfirmationView {
    func openVC(challengeid :Int,contestAmount : Double,EntryType:Bool,maxLimit:Int)
  func openwinningView(challengeid:Int,winningAmount:Double,matchKey:String)
}
class ContestCategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mulitEntryTeam: UILabel!
    @IBOutlet weak var animationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var notificationLbl: UILabel!
    @IBOutlet weak var winnerLbl: UILabel!
    @IBOutlet weak var maxTeamHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var bonousLblPercentWidthContraint: NSLayoutConstraint!
    @IBOutlet weak var bonusLblPercent: UILabel!
    @IBOutlet weak var aTotalWinnerLabel: UILabel!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aEntreeFeeLabel: UILabel!
    var delegate:openConfirmationView?
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
    
    var joinCreateTeamVC : (())
    var winnerButtonClouser: ((Int, Double) -> Void) = { _, _ in}
    var joinButtonClouser: ((Int, Double) -> Void) = { _, _ in}
    var challengeID = 0
    var challengeCategoryID = 0
    var contestAmount = 0.0
    var winningAmmount = 0.0
    var matchKey = ""
    var hometype:HomeType = .upcomming
    var mulitEntry = false
    var maxUSer: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadius()
        setInitialSetup()
        aContainerView.roundCorners(cornerRadius: 5)
//       self.notificationLbl.slideInFromLeft()
        aEntreeFeeLabel.roundCornersLbl(cornerRadius: 3.0)
        bonusLblPercent.roundCornersLbl(cornerRadius: 3.0)
        mulitEntryTeam.roundCornersLbl(cornerRadius: 3.0)
        aConfirmLabel.roundCornersLbl(cornerRadius: 3.0)
        aProgressView.transform = aProgressView.transform.scaledBy(x: 1, y: 2)
    }
    
    fileprivate func setInitialSetup() {
        showBonusView(show: false)
        showConfirmView(show: false)
        showMultipleView(show: false)
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }
    fileprivate func setCornerRadius() {
        aContainerView.setCornerRadius(value: 5)
        self.setCornerRadius(value: 10)
        aBonusLabel.setCornerRadius(value: 2)
        aConfirmLabel.setCornerRadius(value: 2)
        aMultipleLabel.setCornerRadius(value: 2)
        aBonusLabel.setBorder(color: UIColor(red: 240, green: 136, blue: 33), size: 1)
        aConfirmLabel.setBorder(color: UIColor(red: 23, green: 179, blue: 219), size: 1)
        mulitEntryTeam.setBorder(color: UIColor(red: 107, green: 61, blue: 49), size: 1)
        bonusLblPercent.setCornerRadius(value: 2)
//        aJoinButton.setBorderButton(color: .orange, size: 1)
//        aJoinButton.setCornerRadiusButton(value: 3)
    }
    
    func configureCell(league:MyLeague) {
        mulitEntryTeam.text = "\(league.max_team_limit ?? 0)"
        challengeID = league.id ?? 0
//
        if league.challenge_type == "gadget" {
            aAmountLabel.text = league.first_rank_prizes
             winnerLbl.text = "\(league.first_rank_prizes ?? "")"
        }
        else {
              winnerLbl.text = "\(league.first_rank_prize ?? 0)"
             aAmountLabel.text = "\(kRupeeIcon)\(league.win_amount ?? 0)"
//
            
        }
//
//        league.challenge_type
        challengeCategoryID = league.challenge_category_id ?? 0
        aEntreeFeeLabel.text = kRupeeIcon + "\(league.entryfee ?? Int(0.0))"
        aTotalWinnerLabel.text = "\(Int(league.totalwinners ?? "0") ?? 0) Team win"
        aTotlaSpotsLabel.text = "\(league.maximum_user ?? 0) spots"
       
        winningAmmount = Double(league.win_amount ?? 0)
        contestAmount = Double(league.entryfee ?? Int(0.0))
        self.matchKey = league.matchkey ?? ""
        self.maxUSer = league.max_team_limit ?? 0
      
        self.notificationLbl.text = league.announcement ?? ""
               if notificationLbl.text != "" {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
                  self.notificationLbl.slideInFromLeft()
//                }
                self.animationHeightConstraint.constant = 30
               self.animationView.isHidden = false
            
               }
               else {
                self.animationHeightConstraint.constant = 0
                   self.animationView.isHidden = true
               }
        if league.is_bonus != 0 {
            showBonusView(show: true)
            bonusLblPercent.text = league.bonus_percent
        } else {
            showBonusView(show: false)
        }
        if league.confirmed_challenge != 0 {
            showConfirmView(show: true)
        } else {
            showConfirmView(show: false)
        }
        if league.multi_entry != 0 {
            mulitEntry = true
          
            showMultipleView(show: true)
        } else {
            mulitEntry = false
            showMultipleView(show: false)
        }
        let totalSpot = Float(league.maximum_user ?? 0)
        let joinedSpot = Float(league.joinedusers ?? 0)
        let remainingSpot = totalSpot - joinedSpot
        if totalSpot == joinedSpot {
            aLeftSpotsLabel.text = "Challenge Closed"
        } else {
            aLeftSpotsLabel.text = " \(Int(remainingSpot)) Spots left"
        }
        let progressValue = joinedSpot / totalSpot
        aProgressView.progress = Float(progressValue)
//        if league.announcement != "" {
       
            
//        }
       
   }

    
    fileprivate func showBonusView(show: Bool) {
        aBonusLabel.isHidden = !show
        bonusLblPercent.isHidden = !show
        
        aBonusLabelWidthConstraint.constant = show ? 22 : 0
        bonousLblPercentWidthContraint.constant = show ? 27 : 0
    }
    
    fileprivate func showConfirmView(show: Bool) {
        aConfirmLabel.isHidden = !show
        aConfirmLabelWidthConstraint.constant = show ? 20 : 0
    }
    
    fileprivate func showMultipleView(show: Bool) {
        aMultipleLabel.isHidden = !show
        
        mulitEntryTeam.isHidden = !show
        maxTeamHeightConstraint.constant = show ? 20:0
        aMultipleLabelWidthConstraint.constant = show ? 20 : 0
    }
    
    @IBAction func joinButtonAction(_ sender: UIButton) {
      joinButtonClouser(challengeID, contestAmount)
        delegate?.openVC(challengeid: challengeID, contestAmount: contestAmount, EntryType: mulitEntry, maxLimit: maxUSer ?? 0)
    }
    
    @IBAction func winnerButtonAction(_ sender: UIButton) {
        winnerButtonClouser(challengeID, winningAmmount)
        delegate?.openwinningView(challengeid: challengeID, winningAmount: winningAmmount, matchKey: matchKey)
    }

   
}
extension UIView {
func roundCorners(cornerRadius: Double) {
    self.layer.cornerRadius = CGFloat(cornerRadius)
    self.clipsToBounds = true
}
}
extension UILabel {
    func roundCornersLbl(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
}
