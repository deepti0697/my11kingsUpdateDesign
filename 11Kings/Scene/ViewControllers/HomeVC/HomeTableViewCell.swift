//
//  homeTableViewCell.swift
//  DreamTeam
//
//  Created by Test on 31/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import UIKit
class HomeTableViewCell : UITableViewCell {
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var timeLabl: UILabel!
    
    @IBOutlet weak var leaderboardHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leaderImageView: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team1image: UIImageView!
    
    @IBOutlet weak var matchStatusview: UIView!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var lineupView: UIView!
    @IBOutlet weak var team1Lbl: UILabel!
    @IBOutlet weak var shortMatchName: UILabel!
    @IBOutlet weak var team2Image: UIImageView!
    
    @IBOutlet weak var team2Lbl: UILabel!
    var isLaunched = true
    var celltype:MatchesType = .cricket
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    
    func configureMyContestCell(data: GetMatchDetails) {
        shortMatchName.text = data.seriesname  ?? ""
        team1Lbl.text = data.team1display
        team2Lbl.text = data.team2display ?? ""
        team1Name.text = data.team1name
        team2Name.text = data.team2name
        if data.is_leaderboard == 1 {
            self.leaderImageView.isHidden = false
        }
        else {
             self.leaderImageView.isHidden = true
        }
        if data.lineup == 1 {
            self.lineupView.isHidden = false
        }
        else {
            self.lineupView.isHidden = true
        }
         if let imagePath1 = data.team1logo {
                   let urlString1 = imagePath1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                   let imageUrl = URL(string: urlString1 ?? "")
                   team1image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                   }
               }
               if let imagePath2 = data.team2logo {
                   let urlString2 = imagePath2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                   let imageUrl = URL(string: urlString2 ?? "")
                   team2Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                   }
               }
       
               if let time = data.time_start {
//            if data.launch_status == "pending" {
//                timeLabl.text = "Peding"
//            }
//            else {
            setReleaseTime(releaseDateString: time)
//            }
        }

    }
    
    func configureMyContestCellKABADDI(data: GetMatchDetails) {
        shortMatchName.text = data.seriesname  ?? ""
        team1Lbl.text = data.team1display
        team2Lbl.text = data.team2display ?? ""
        team1Name.text = data.team1name
        team2Name.text = data.team2name
        if data.lineup == 1 {
            self.lineupView.isHidden = false
        }
        else {
            self.lineupView.isHidden = true
        }
        if data.is_leaderboard == 1 {
                   self.leaderImageView.isHidden = false
               }
               else {
                    self.leaderImageView.isHidden = true
               }
        if let imagePath1 = data.team1logo {
                          let urlString1 = imagePath1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                          let imageUrl = URL(string: urlString1 ?? "")
                          team1image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                          }
                      }
                      if let imagePath2 = data.team2logo {
                          let urlString2 = imagePath2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                          let imageUrl = URL(string: urlString2 ?? "")
                          team2Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                          }
                      }
               if team2Image.image == nil {
                   team2Image.image = #imageLiteral(resourceName: "team_placeholder")
               }
               if team1image.image == nil {
                   team1image.image = #imageLiteral(resourceName: "team_placeholder")
               }
        
       
                if let time = data.time_start {
//            if data.launch_status == "pending" {
//                timeLabl.text = "Peding"
//            }
//            else {
            setReleaseTime(releaseDateString: time)
//            }
        }

    }
    func configureMyContestCellFootball(data: GetMatchDetails) {
        shortMatchName.text = data.seriesname  ?? ""
        team1Lbl.text = data.team1display
        team2Lbl.text = data.team2display ?? ""
        team1Name.text = data.team1name
        team2Name.text = data.team2name
        if data.lineup == 1 {
            self.lineupView.isHidden = false
        }
        else {
            self.lineupView.isHidden = true
        }
        if data.is_leaderboard == 1 {
                   self.leaderImageView.isHidden = false
               }
               else {
                    self.leaderImageView.isHidden = true
               }
         if let imagePath1 = data.team1logo {
                                let urlString1 = imagePath1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                                let imageUrl = URL(string: urlString1 ?? "")
                                team1image?.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                                }
                            }
                            if let imagePath2 = data.team2logo {
                                let urlString2 = imagePath2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

                                let imageUrl = URL(string: urlString2 ?? "")
                                team2Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                                }
                            }
      
        if let time = data.time_start {
//            if data.launch_status == "pending" {
//                timeLabl.text = "Peding"
//            }
//            else {
            setReleaseTime(releaseDateString: time)
//            }
        }
    }
    
    
    fileprivate func setReleaseTime(releaseDateString: String) {
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        var day = diffDateComponents.day ?? 00
        var hour = diffDateComponents.hour ?? 00
        var minute = diffDateComponents.minute ?? 00
        var second = diffDateComponents.second ?? 00
        if day < 0 {
            day = 0
        }
        if hour < 0 {
            hour = 0
        }
        if minute < 0 {
            minute = 0
        }
        if second < 0 {
            second = 0
        }
        let countdown = "\(Utility.getStringFrom(seconds: hour))H : \(Utility.getStringFrom(seconds: minute))M : \(Utility.getStringFrom(seconds: second))S"
        timeLabl.text = countdown
        if day == 0 && hour == 0 && minute == 0 && second == 0 {
            countdownTimer.invalidate()
        }
    }
}





