//
//  CaptainTableViewCell.swift
//  TeamBanao
//
//  Created by Developer on 21/02/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit
protocol openCaptainProfile {
    func openProfile(playerResp:PlayerListResponses)
}
class CaptainTableViewCell: UITableViewCell {

    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var viceCaptainSelectedBy: UILabel!
    @IBOutlet weak var captainSelectedBy: UILabel!
    @IBOutlet weak var aNameLabel: UILabel!
    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    @IBOutlet weak var aPointsLabel: UILabel!
    @IBOutlet weak var aVCButton: UIButton!
    @IBOutlet weak var aCButton: UIButton!
     @IBOutlet weak var aVCWidth: NSLayoutConstraint!
    var delegate:openCaptainProfile?
     var playerId:PlayerListResponses?
    var captainClooseClouser: (() -> Void) = {}
    var vCaptainClooseClouser: (() -> Void) = {}
    var matchTypeC:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        setCornerRadius()
    }
    
    func configureCell(player: PlayerListResponses) {
        let nameFormatter = PersonNameComponentsFormatter()
        if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.givenName?.first {
                           
                           let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                           aTeamNameLabel.text = sortName
                       }
   
        if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                           
                           let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                           aNameLabel.text = sortName
                       }
        playerType.text = "\(player.role ?? "")"
//        aNameLabel.text = "\(player.name ?? "")"
        aPointsLabel.text = "\(player.series_points ?? 0.0)"
//        aTeamNameLabel.text = player.name
        captainSelectedBy.text = player.captain_selected_by
//        if matchTypeC == "BASKETBALL" {
//            viceCaptainSelectedBy.isHidden = true
//        }
//        else {
//             viceCaptainSelectedBy.isHidden = false
//        }
        viceCaptainSelectedBy.text = player.vice_captain_selected_by
        playerId = player
        if aVCButton.isHidden == true {
            aVCWidth.constant = 1
        }
        else {
            aVCWidth.constant = 30
        }
    }
    
    func setCornerRadius() {
        aCButton.setCornerRadius(value: 15)
        aVCButton.setCornerRadius(value: 15)
        aCButton.setBorderButton(color: .black, size: 1)
        aVCButton.setBorderButton(color: .black, size: 1)
    }
    
    func selectCaptain(select: Bool) {
        aCButton.backgroundColor = select ? UIColor(red: 240, green: 75, blue: 80) : .white
        aCButton.setTitleColor(select ? .white : .lightGray, for: .normal)
        aCButton.setBorderButton(color: select ? UIColor(red: 240, green: 75, blue: 80): .darkGray, size: 1)
    }
    
    func selectVCaptain(select: Bool) {
        aVCButton.backgroundColor = select ? UIColor(red: 49, green: 139, blue: 22) : .white
        aVCButton.setTitleColor(select ? .white : .lightGray, for: .normal)
        aVCButton.setBorderButton(color: select ? UIColor(red: 49, green: 139, blue: 22) : .darkGray, size: 1)
    }
    
    @IBAction func vCaptainButtonAction(_ sender: Any) {
        vCaptainClooseClouser()
    }
    
    @IBAction func captainButtonAction(_ sender: Any) {
        captainClooseClouser()
    }
    
    @IBAction func openProfile(_ sender: Any) {
        self.delegate?.openProfile(playerResp:playerId! )
    }
}
