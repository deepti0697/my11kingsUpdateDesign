//
//  SelectMultipleTeamTableViewCell.swift
//  11Kings
//
//  Created by uu on 17/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol sendDataToSelectAll {
//    func sendTeamCount(check:Bool,teamCount:Int)

func openEditViewController(arrayOfPlayerID:[Int],vcID:Int,captainId:Int,teamID:Int,check:Bool)
   func openPreviewData(teamResponse:MyTeamResponses,teamName:String,teamID:Int)
}
class SelectMultipleTeamTableViewCell: UITableViewCell {

     @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var frwrdText: UILabel!
    
    @IBOutlet weak var cloneView: UIView!
    @IBOutlet weak var frwrdLbl: UILabel!
    @IBOutlet weak var forwordView: UIView!
    @IBOutlet weak var bowlTextLbl: UILabel!
      @IBOutlet weak var wkTextLbl: UILabel!
      @IBOutlet weak var arTextLbl: UILabel!
      @IBOutlet weak var batLbl: UILabel!
      @IBOutlet weak var bowlView: UIView!
      @IBOutlet weak var aContainerView: UIView!
      @IBOutlet weak var aTeamName: UILabel!
      @IBOutlet weak var aCaptainNameLabel: UILabel!
      @IBOutlet weak var aViceCaptainNameLabel: UILabel!
      @IBOutlet weak var aWKLabel: UILabel!
      @IBOutlet weak var aBatLabel: UILabel!
      @IBOutlet weak var aARLabel: UILabel!
      @IBOutlet weak var aBowlLabel: UILabel!
      var check = false
       var delegate:sendDataToSelectAll?
        var storeOnePlayerData: MyTeamResponses!
        var teamResponse = [Int]()
        var cloneButtonClouser: ((Bool) -> Void) = { _ in}
        var previewButtonClouser: ((Int) -> Void) = { _ in}
        var editButtonClouser: ((Bool) -> Void) = { _ in}
        var teamId = 0
        var vcid = 0
        var captainId = 0
    var teamJoinedCount = 0
    
        override func awakeFromNib() {
            super.awakeFromNib()
            aContainerView.setCornerRadius(value: 5)
            
        }
       override func prepareForReuse() {
            super.prepareForReuse()

            
        }
    
    @IBAction func selectTeam(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected {
//            selectTeamButton(true)
//            self.teamJoinedCount = teamJoinedCount+1
//            sender.setImage(#imageLiteral(resourceName: "Group 9310"), for: .selected)
//            self.delegate?.sendTeamCount(check: true, teamCount: teamJoinedCount)
//        }
//        else {
//            self.teamJoinedCount = teamJoinedCount - 1
//              selectTeamButton(false)
//             self.delegate?.sendTeamCount(check: false, teamCount: teamJoinedCount)
//            sender.setImage(#imageLiteral(resourceName: "Rectangle 3568"), for: .normal)
//        }
    }
    
    
    
    @IBAction func previewButtonAction(_ sender: Any) {
            self.delegate?.openPreviewData(teamResponse: storeOnePlayerData, teamName: aTeamName.text ?? "", teamID: teamId)
        }
        override func layoutSubviews() {
            super.layoutSubviews()

            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        @IBAction func cloneButtonAction(_ sender: Any) {
          // cloneButtonClouser(true)
            delegate?.openEditViewController(arrayOfPlayerID: teamResponse,vcID:vcid,captainId:captainId, teamID: teamId, check: false)

        }
        
        @IBAction func editButtonAction(_ sender: Any) {
            editButtonClouser(true)
            delegate?.openEditViewController(arrayOfPlayerID: teamResponse,vcID:vcid,captainId:captainId, teamID: teamId, check: true)
                }
        
        func configureCell(data: MyTeamResponses) {
            forwordView.isHidden = true
            var wkCount = 0
            var batCount = 0
            var arCount = 0
            var bowlCount = 0
            teamResponse.removeAll()
            storeOnePlayerData = data
            aTeamName.text = "Team \(data.teamnumber ?? 0)"
            if let players = data.players {
                for player in players {
                  
                    if player.captain == 1 {
                        aCaptainNameLabel.text = player.name
                        captainId = player.id ?? 0
                    }
                    if player.vicecaptain == 1 {
                        aViceCaptainNameLabel.text = player.name
                        vcid = player.id ?? 0
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
                    
                      teamResponse.append(player.id ?? 0)
                }
                
                aWKLabel.text = "(\(wkCount))"
                aBowlLabel.text = "(\(bowlCount))"
                aBatLabel.text = "(\(batCount))"
                aARLabel.text = "(\(arCount))"
                teamId = data.teamid ?? 0
            }

        }
        func configureCellKabbaddi(data: MyTeamResponses) {
            forwordView.isHidden = false
             var wkCount = 0
                      var batCount = 0
                      var arCount = 0
                     var bowlCount = 0
                  var C = 0
                      teamResponse.removeAll()
                      storeOnePlayerData = data
                      aTeamName.text = "Team \(data.teamnumber ?? 0)"
                      if let players = data.players {
                          for player in players {
                            
                              if player.captain == 1 {
                                  aCaptainNameLabel.text = player.name
                                  captainId = player.id ?? 0
                              }
                              if player.vicecaptain == 1 {
                                  aViceCaptainNameLabel.text = player.name
                                  vcid = player.id ?? 0
                              }
                                if player.role == "Small forward" {
                                                batCount += 1
                                            }
                                            if player.role == "Shooting guard" {
                                                arCount += 1
                                            }
                                            
                                            if player.role == "Point guard" {
                                                wkCount += 1
                                            }
                              if player.role == "Power forward" {
                                                 bowlCount += 1
                                             }
                              if player.role == "Center" {
                                  C += 1
                              }
                                teamResponse.append(player.id ?? 0)
                          }
                          
                          aWKLabel.text = "(\(wkCount))"
                          arTextLbl.text = "SF"
                          wkTextLbl.text = "PG"
                          batLbl.text = "SG"
                          bowlTextLbl.text = "PF"
                          frwrdLbl.text = "C"
                          frwrdText.text = "(\(C))"
                          aBowlLabel.text = "\(bowlCount)"
                          aBatLabel.text = "(\(batCount))"
                          aARLabel.text = "(\(arCount))"
                          teamId = data.teamid ?? 0
                      }


            }
        func configureCellFootball(data: MyTeamResponses) {
            forwordView.isHidden = true
                var wkCount = 0
                     var batCount = 0
                     var arCount = 0
                     var bowlCount = 0
                     teamResponse.removeAll()
                     storeOnePlayerData = data
                     aTeamName.text = "Team \(data.teamnumber ?? 0)"
                     if let players = data.players {
                         for player in players {
                           
                             if player.captain == 1 {
                                 aCaptainNameLabel.text = player.name
                                 captainId = player.id ?? 0
                             }
                             if player.vicecaptain == 1 {
                                 aViceCaptainNameLabel.text = player.name
                                 vcid = player.id ?? 0
                             }
                             if player.role == "Defender" {
                                 batCount += 1
                             }
                             if player.role == "Forward" {
                                 arCount += 1
                             }
                             if player.role == "Midfielder" {
                                 bowlCount += 1
                             }
                             if player.role == "Goalkeeper" {
                                 wkCount += 1
                             }
                             
                               teamResponse.append(player.id ?? 0)
                         }
                        aWKLabel.text = "(\(wkCount))"
                                       arTextLbl.text = "MID"
                                       wkTextLbl.text = "GK"
                                       batLbl.text = "DEF"
                                       bowlTextLbl.text = "ST"
                                       aBatLabel.text = "(\(batCount))"
                                       aARLabel.text = "(\(arCount))"
                                      aBowlLabel.text = "(\(bowlCount))"
                                       teamId = data.teamid ?? 0
            }
    }
    }
