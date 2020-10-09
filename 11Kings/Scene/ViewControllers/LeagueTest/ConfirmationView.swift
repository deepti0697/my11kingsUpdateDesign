//
//  ConfirmationView.swift
//  Club11
//
//  Created by Developer on 29/05/19.
//

import UIKit

class ConfirmationView: UIView {
    
    
    @IBOutlet weak var toPay: UILabel!
    @IBOutlet weak var aContainerView: UIView!
        @IBOutlet weak var aJoinButton: UIButton!
        @IBOutlet weak var aTeamNameLabel: UILabel!
     //   @IBOutlet weak var aSelectTeamButton: UIButton!
        @IBOutlet weak var aAvailableBalance: UILabel!
        @IBOutlet weak var aUsableBalance: UILabel!
        @IBOutlet weak var aJoiningBalance: UILabel!
      var teamPopoverVC: TeamPopoverViewController?
        var availableBalance = ""
        var usableBalance = ""
        var closeButtonClouser: (() -> Void) = { }
        var termsConditionButtonClouser: (() -> Void) = { }
        var joinButtonClouser: ((Int) -> Void) = { _ in}
        var myTeamsData = [MyTeamResponses]()
        var teamId = 0
        var entryFees = 0.0 {
            didSet {
                setupBalanceData()
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
//            aSelectTeamButton.setBorderButton(color: .lightGray, size: 1)
//            aSelectTeamButton.setCornerRadiusButton(value: 5)
//            aJoinButton.setCornerRadiusButton(value: 5)
        }
        
        func setupBalanceData() {
            aAvailableBalance.text = availableBalance
            aUsableBalance.text = usableBalance
            aJoiningBalance.text = kRupeeIcon + "\(entryFees)"
          
            guard let usblc = Double(usableBalance) else {return}
            
            let payblc = entryFees - usblc
            toPay.text = kRupeeIcon + "\(payblc)"
        }
        
        @IBAction func joinButtonAction(_ sender: UIButton) {
            joinButtonClouser(teamId)
        }
        
        @IBAction func selectTeamAction(_ sender: UIButton) {
            if myTeamsData.count > 0 {
                presentPopOverController(sender: sender)
            } else {
                Loader.showToast(message: "No team", onView: self, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
            }
        }
        
        @IBAction func closeButtonAction(_ sender: Any) {
            removePopOverVC()
            closeButtonClouser()
        }
        
        fileprivate func presentPopOverController(sender: UIButton) {
            if teamPopoverVC == nil {
                teamPopoverVC = Bundle.main.loadNibNamed("TeamPopoverViewController", owner: self, options: nil)?.first as? TeamPopoverViewController
                teamPopoverVC?.myTeamsData = myTeamsData
                teamPopoverVC?.preferredContentSize = CGSize(width: self.frame.width - 30, height: CGFloat(myTeamsData.count * 50))
                teamPopoverVC?.modalPresentationStyle = .popover
                if let pres = teamPopoverVC?.presentationController {
                    pres.delegate = self
                }
                if let pop = teamPopoverVC?.popoverPresentationController {
                    pop.sourceView = (sender as UIView)
                    pop.sourceRect = (sender as UIView).bounds
                }
                teamPopoverVC?.view.frame = CGRect(x: 15, y: ((aContainerView.frame.origin.y + aTeamNameLabel.frame.origin.y) - CGFloat(myTeamsData.count * 50)), width: self.frame.width - 30, height: CGFloat(myTeamsData.count * 50))
                self.addSubview(teamPopoverVC!.view)
                teamPopoverVC?.teamSelectionClousure = {[weak self] tID, num in
                    if let strongSelf = self {
                        strongSelf.teamId = tID
                        strongSelf.aTeamNameLabel.text = "Team \(num)"
                        strongSelf.removePopOverVC()
                    }
                }
}
        }
        
        func removePopOverVC() {
//            teamPopoverVC?.view.removeFromSuperview()
//            teamPopoverVC = nil
        }
        @IBAction func openTermConditionAction(_ sender: UIButton) {
            termsConditionButtonClouser()
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            removePopOverVC()
        }
    }
    // MARK: PopOver Delegate Method
    extension ConfirmationView: UIPopoverPresentationControllerDelegate {
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
    }


