//
//  LeaderBoardContestTVCell.swift
//  Club11
//
//  Created by Developer on 09/06/19.
//

import UIKit

class LeaderBoardContestTVCell: UITableViewCell {

//    @IBOutlet weak var aLineView: UIView!
//    @IBOutlet weak var aMultipleInfoLabel: UILabel!
//    @IBOutlet weak var aBonusInfoLabel: UILabel!
//    @IBOutlet weak var aConfirmInfoLabel: UILabel!
//    @IBOutlet weak var aTotalWinnerLabel: UILabel!
//    @IBOutlet weak var aContainerView: UIView!
//    @IBOutlet weak var aEntreeFeeLabel: UILabel!
//    @IBOutlet weak var aBonusLabelHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var aConfirmLabelHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var aMultipleLabelHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var aBonusLabel: UILabel!
//    @IBOutlet weak var aConfirmLabel: UILabel!
//    @IBOutlet weak var aMultipleLabel: UILabel!
//    @IBOutlet weak var aTotlaSpotsLabel: UILabel!
//    @IBOutlet weak var aLeftSpotsLabel: UILabel!
//    @IBOutlet weak var aAmountLabel: UILabel!
//    @IBOutlet weak var aProgressView: UIProgressView!
//    @IBOutlet weak var aWinnersButton: UIButton!
//    @IBOutlet weak var aDownloadButton: UIButton!
//
//    var winnerButtonClouser: ((Int, Double) -> Void) = { _, _ in}
//    var downloadButtonClouser: (() -> Void) = { }
//    var challengeID = 0
//    var winningAmmount = 0.0
//    var homeType: HomeType = .live
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setCornerRadius()
//    }
//
//    fileprivate func setCornerRadius() {
//        aContainerView.setCornerRadius(value: 5)
//        aDownloadButton.setCornerRadius(value: 5)
//        aBonusLabel.setCornerRadius(value: 2)
//        aConfirmLabel.setCornerRadius(value: 2)
//        aMultipleLabel.setCornerRadius(value: 2)
//        aBonusLabel.setBorder(color: .lightGray, size: 1)
//        aConfirmLabel.setBorder(color: .lightGray, size: 1)
//        aMultipleLabel.setBorder(color: .lightGray, size: 1)
//        aProgressView.transform = aProgressView.transform.scaledBy(x: 1, y: 2)
//    }
//
//
//    func configureCell(homeType: HomeType, entryFee: Double, amount: Double, chalID: Int, winning: String, winners: Int) {
//        switch homeType {
//        case .live, .result:
//            setupForOthers()
//            challengeID = chalID
//            winningAmmount = amount
//            aAmountLabel.text = winning
//            aEntreeFeeLabel.text = kRupeeIcon + "\(entryFee)"
//            aTotalWinnerLabel.text = "\(winners)"
//        case .upcomming:
//            break
//        }
//    }
//
//    func configureCellForUpcommimg(league: Any, homeType: HomeType) {
//        switch homeType {
//        case .live, .result:
//           break
//        case .upcomming:
//            if let data = league as? Leagues {
//                challengeID = data.id ?? 0
//                aAmountLabel.text = "\(data.name ?? "")"
//                aEntreeFeeLabel.text = kRupeeIcon + "\(data.entryfee ?? 0.0)"
//                aTotalWinnerLabel.text = "\(Int(data.totalwinners ?? "0") ?? 0)"
//                aTotlaSpotsLabel.text = "\(data.maximum_user ?? 0) Teams"
//                aLeftSpotsLabel.text = "Only \(data.joinedusers ?? 0) Spot left"
//                winningAmmount = data.win_amount ?? 0.0
//                if data.is_bonus != 0 {
//                    showBonusView(show: true)
//                } else {
//                    showBonusView(show: false)
//                }
//                if data.confirmed_challenge != 0 {
//                    showConfirmView(show: true)
//                } else {
//                    showConfirmView(show: false)
//                }
//                if data.multi_entry != 0 {
//                    showMultipleView(show: true)
//                } else {
//                    showMultipleView(show: false)
//                }
//                let totalSpot = Float(data.maximum_user ?? 0)
//                let joinedSpot = Float(data.joinedusers ?? 0)
//                let remainingSpot = totalSpot - joinedSpot
//                if totalSpot == joinedSpot {
//                    aLeftSpotsLabel.text = "Challenge Closed"
//                } else {
//                    aLeftSpotsLabel.text = "Only \(Int(remainingSpot)) Spot left"
//                }
//                let progressValue = joinedSpot / totalSpot
//                aProgressView.progress = Float(progressValue)
//            } else if let data = league as? joinedLeaguesResponse {
//                challengeID = data.challenge_id ?? 0
//                aAmountLabel.text = "\(data.winamount ?? 0)"
//                aEntreeFeeLabel.text = kRupeeIcon + "\(data.entryfee ?? 0.0)"
//                aTotalWinnerLabel.text = "\(Int(data.totalwinners ?? 0))"
//                aTotlaSpotsLabel.text = "\(data.maximum_user ?? 0) Teams"
//                aLeftSpotsLabel.text = "Only \(data.joinedusers ?? 0) Spot left"
//                winningAmmount = data.winamount ?? 0.0
////                if data.is_bonus != 0 {
////                    showBonusView(show: true)
////                } else {
//                    showBonusView(show: false)
////                }
//                if data.confirmed != 0 {
//                    showConfirmView(show: true)
//                } else {
//                    showConfirmView(show: false)
//                }
//                if data.multi_entry != 0 {
//                    showMultipleView(show: true)
//                } else {
//                    showMultipleView(show: false)
//                }
//                let totalSpot = Float(data.maximum_user ?? 0)
//                let joinedSpot = Float(data.joinedusers ?? 0)
//                let remainingSpot = totalSpot - joinedSpot
//                if totalSpot == joinedSpot {
//                    aLeftSpotsLabel.text = "Challenge Closed"
//                } else {
//                    aLeftSpotsLabel.text = "Only \(Int(remainingSpot)) Spot left"
//                }
//                let progressValue = joinedSpot / totalSpot
//                aProgressView.progress = Float(progressValue)
//            }
//        }
//    }
//
//    fileprivate func showBonusView(show: Bool) {
//        aBonusLabel.isHidden = !show
//        aBonusInfoLabel.isHidden = !show
//        aBonusLabelHeightConstraint.constant = show ? 20 : 0
//    }
//
//    fileprivate func showConfirmView(show: Bool) {
//        aConfirmLabel.isHidden = !show
//        aConfirmInfoLabel.isHidden = !show
//        aConfirmLabelHeightConstraint.constant = show ? 20 : 0
//    }
//
//    fileprivate func showMultipleView(show: Bool) {
//        aMultipleLabel.isHidden = !show
//        aMultipleInfoLabel.isHidden = !show
//        aMultipleLabelHeightConstraint.constant = show ? 20 : 0
//    }
//
//    @IBAction func winnerButtonAction(_ sender: UIButton) {
//        winnerButtonClouser(challengeID, winningAmmount)
//    }
//
//    @IBAction func downloadButtonAction(_ sender: UIButton) {
//        switch homeType {
//        case .live, .result:
//            downloadButtonClouser()
//        case .upcomming:
//            Loader.showToast(message: "You can download all teams after match start", onView: self, bottomMargin: 200, color: .red)
//        }
//    }
//
//    func setupForOthers() {
//        aMultipleInfoLabel.isHidden = true
//        aBonusInfoLabel.isHidden = true
//        aConfirmInfoLabel.isHidden = true
//        aBonusLabelHeightConstraint.constant = 0
//        aConfirmLabelHeightConstraint.constant = 0
//        aMultipleLabelHeightConstraint.constant = 0
//        aBonusLabel.isHidden = true
//        aConfirmLabel.isHidden = true
//        aMultipleLabel.isHidden = true
//        aTotlaSpotsLabel.isHidden = true
//        aLeftSpotsLabel.isHidden = true
//        aProgressView.isHidden = true
//        aLineView.isHidden = true
//    }
//}
}
