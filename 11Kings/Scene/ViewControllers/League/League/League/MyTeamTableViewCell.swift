//
//  MyTeamTableViewCell.swift
//  Club11
//
//  Created by Developer on 28/05/19.
//

import UIKit

class MyTeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aTeamName: UILabel!
    @IBOutlet weak var aCaptainNameLabel: UILabel!
    @IBOutlet weak var aViceCaptainNameLabel: UILabel!
    @IBOutlet weak var aWKLabel: UILabel!
    @IBOutlet weak var aBatLabel: UILabel!
    @IBOutlet weak var aARLabel: UILabel!
    @IBOutlet weak var aBowlLabel: UILabel!
    @IBOutlet weak var aFirstInningP1: UILabel!
    @IBOutlet weak var aFirstInningP2: UILabel!
    @IBOutlet weak var aFirstInningP3: UILabel!
    @IBOutlet weak var aSecondInningP1: UILabel!
    @IBOutlet weak var aSecondInningP2: UILabel!
    @IBOutlet weak var aSecondInningP3: UILabel!

    var cloneButtonClouser: ((Int) -> Void) = { _ in}
    var previewButtonClouser: ((Int) -> Void) = { _ in}
    var editButtonClouser: ((Int) -> Void) = { _ in}
    var teamId = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aContainerView.setCornerRadius(value: 5)
    }

    @IBAction func previewButtonAction(_ sender: Any) {
        previewButtonClouser(teamId)
    }
    
    @IBAction func cloneButtonAction(_ sender: Any) {
        cloneButtonClouser(teamId)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        editButtonClouser(teamId)
    }
    
    func configureCell(data: MyTeamResponse) {
        var wkCount = 0
        var batCount = 0
        var arCount = 0
        var bowlCount = 0
        aTeamName.text = "Team \(data.teamnumber ?? 0)"
        if let players = data.player {
            for player in players {
                if player.captain == 1 {
                    aCaptainNameLabel.text = player.player_name
                }
                if player.vicecaptain == 1 {
                    aViceCaptainNameLabel.text = player.player_name
                }
                if player.role == "batsman" {
                    batCount += 1
                }
                if player.role == "allrounder" {
                    arCount += 1
                }
                if player.role == "bowler" {
                    bowlCount += 1
                }
                if player.role == "keeper" {
                    wkCount += 1
                }
            }
            aWKLabel.text = "\(wkCount)"
            aBowlLabel.text = "\(bowlCount)"
            aBatLabel.text = "\(batCount)"
            aARLabel.text = "\(arCount)"
            teamId = data.teamid ?? 0
        }
//        if let powerPlayArr = data.powerplay {
//            let ff = powerPlayAr
//            for powerPlay in powerPlayArr {
//                let f1p1 = powerPlay[0]
//                let f1p2 = powerPlay[1]
//                let f1p3 = powerPlay[2]
//                let f2p1 = powerPlay[0]
//                let f2p2 = powerPlay[0]
//                let f2p3 = powerPlay[0]
//
//            }
//        }
    }
}
