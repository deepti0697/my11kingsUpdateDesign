//
//  TeamTableViewCell.swift
//  TeamBanao
//
//  Created by Developer on 21/02/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit
protocol openPlayerProfile {
    func openProfile(playerResp:PlayerListResponses)
}

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var isUserPlaying: UILabel!
    @IBOutlet weak var backPlayerView: UIView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var DullView: UIView!
    @IBOutlet weak var openPlayerProfile: UIButton!
    @IBOutlet weak var removePlayer: UIImageView!
    @IBOutlet weak var addPlayerImage: UIImageView!
    @IBOutlet weak var aSelectionView: UIView!
    @IBOutlet weak var aPlayerImage: UIImageView!
    @IBOutlet weak var aPlayerNameLabel: UILabel!
    @IBOutlet weak var aPlayerTeamNameLabel: UILabel!
    @IBOutlet weak var aPointLabel: UILabel!
    @IBOutlet weak var aCreditLabel: UILabel!
    var playerId:PlayerListResponses?
     var check = false
      var notSelectedCell = false
      var delegate:openPlayerProfile?
    override func awakeFromNib() {
        super.awakeFromNib()
        aPlayerImage.setCornerRadiusImageView(value: 20)
        playerView.setCornerRadius(value: 3)
        backPlayerView.corner(radius: 2)
      
    }
     func configureCell(playerData: PlayerListResponses) {
            if check {
                aPlayerNameLabel.text = playerData.name ?? ""
                       if let pointText = playerData.series_points {
                           aPointLabel.text = "\(pointText)"
                       }
                
                aPlayerNameLabel.textColor = .white
                aPlayerTeamNameLabel.textColor = .white
                aPointLabel.textColor = .white
                aCreditLabel.textColor = .white
                aCreditLabel.text = playerData.credit ?? ""
                aPlayerTeamNameLabel.text = playerData.teamcode
                playerSelection(selected:true)

                       if let imagePath = playerData.image {
                           let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                           let imageUrl = URL(string: urlString ?? "")
                           aPlayerImage?.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                           }
                       }
                if  playerData.is_playing_show == 1 {
                if playerData.is_playing == 1 {
                    playerView.backgroundColor = UIColor(red: 93 / 255, green: 180 / 255, blue: 84 / 255, alpha: 1.0)
                    isUserPlaying.textColor = UIColor(red: 93 / 255, green: 180 / 255, blue: 84 / 255, alpha: 1.0)
                    isUserPlaying.text = "Playing"
                } else if playerData.is_playing == 0 {
                    playerView.backgroundColor = .red
                    isUserPlaying.textColor = .red
                    isUserPlaying.text = "Not Playing"
                } else {
                    backPlayerView.isHidden = true
                    playerView.isHidden = true
                    isUserPlaying.isHidden = true
                }
            }
                else {
                    backPlayerView.isHidden = true
                    playerView.isHidden = true
                    isUserPlaying.isHidden = true
                }
            }
            
            else if notSelectedCell {
                aPlayerNameLabel.text = playerData.name ?? ""
                           if let pointText = playerData.series_points {
                               aPointLabel.text = "\(pointText)"
                           }
                           aCreditLabel.text = playerData.credit ?? ""
                               aPlayerTeamNameLabel.text = playerData.teamcode
                         playerSelection(selected:false)
                
                self.DullView?.backgroundColor = .gray
                           if let imagePath = playerData.image {
                               let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                               let imageUrl = URL(string: urlString ?? "")
                               aPlayerImage?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                               }
                           }
                if playerData.is_playing_show == 1 {
                if playerData.is_playing == 1 {
//                    playerView.layer.borderWidth = 5.0
////                          playerView.layer.masksToBounds = false
                          playerView.backgroundColor = UIColor(red: 85, green: 174, blue: 58)

                    isUserPlaying.textColor = UIColor(red: 85, green: 174, blue: 58)
                    isUserPlaying.text = "Playing"
                } else if playerData.is_playing == 0 {
//                    isUserPlaying.backgroundColor = .red
                  
//                          playerView.layer.masksToBounds = false
                          playerView.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                         
                    
                    isUserPlaying.textColor = UIColor(red: 185, green: 33, blue: 36)
                    isUserPlaying.text = "Not Playing"
                } else {
                     backPlayerView.isHidden = true
                    playerView.isHidden = true
                    isUserPlaying.isHidden = true
                }
            }
                else {
                     backPlayerView.isHidden = true
                    playerView.isHidden = true
                    isUserPlaying.isHidden = true
                }
            }
            else {
            aPlayerNameLabel.text = playerData.name ?? ""
            if let pointText = playerData.series_points {
                aPointLabel.text = "\(pointText)"
            }
            aCreditLabel.text = playerData.credit ?? ""
                aPlayerTeamNameLabel.text = playerData.teamcode
          playerSelection(selected:false)

            if let imagePath = playerData.image {
                let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let imageUrl = URL(string: urlString ?? "")
                aPlayerImage?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                }
            }
                 if  playerData.is_playing_show == 1 {
                if playerData.is_playing == 1 {
                           playerView.backgroundColor = UIColor(red: 93 / 255, green: 180 / 255, blue: 84 / 255, alpha: 1.0)
                           isUserPlaying.textColor = UIColor(red: 93 / 255, green: 180 / 255, blue: 84 / 255, alpha: 1.0)
                           isUserPlaying.text = "Playing"
                       } else if playerData.is_playing == 0 {
                           playerView.backgroundColor = .red
                           isUserPlaying.textColor = .red
                           isUserPlaying.text = "Not Playing"
                       } else {
                     backPlayerView.isHidden = true
                           playerView.isHidden = true
                           isUserPlaying.isHidden = true
                       }
                   
                }
                else {
                backPlayerView.isHidden = true
                      playerView.isHidden = true
                      isUserPlaying.isHidden = true
                  }
     
                // aPlayerSelectionView.isHidden = true
              //  aPlayerSelectionLabel.isHidden = true
            }
        self.playerId = playerData
            
        }
        
    func playerSelection(selected: Bool) {
        aSelectionView.isHidden = !selected
        if aSelectionView.isHidden == false {
            aPlayerNameLabel.textColor = .white
            aPlayerTeamNameLabel.textColor = .white
            aPointLabel.textColor = .white
            aCreditLabel.textColor = .white
//            isUserPlaying.textColor = .white
            addPlayerImage.isHidden = true
        }
        else {
            aPlayerNameLabel.textColor = UIColor(red: 36, green: 36, blue: 36)
                       aPlayerTeamNameLabel.textColor = UIColor(red: 36, green: 36, blue: 36)
                       aPointLabel.textColor = UIColor(red: 36, green: 36, blue: 36)
                       aCreditLabel.textColor = UIColor(red: 36, green: 36, blue: 36)
            addPlayerImage.isHidden = false
        }
    }
    @IBAction func openPlayerStatisticView(_ sender: Any) {
        self.delegate?.openProfile(playerResp:playerId! )
    }
}

