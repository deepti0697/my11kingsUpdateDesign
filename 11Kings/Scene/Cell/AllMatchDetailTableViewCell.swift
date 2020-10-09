//
//  AllMatchDetailTableViewCell.swift
//  DreamTeam
//
//  Created by Test on 12/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SDWebImage
import Kingfisher
class AllMatchDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var timeLabl: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30))
    }
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    @IBOutlet weak var team1image: UIImageView!
    
    @IBOutlet weak var team1Lbl: UILabel!
    @IBOutlet weak var shortMatchName: UILabel!
    @IBOutlet weak var team2Image: UIImageView!
 
    @IBOutlet weak var team2Lbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureMyContestCell(data: GetMatchDetails) {
        shortMatchName.text = data.seriesname  ?? ""
        team1Lbl.text = data.team1display 
           team2Lbl.text = data.team2display ?? ""
           
//           if let imagePath1 = data.team1logo {
//               let urlString1 = imagePath1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//
//            let imageUrl = URL(string: imagePath1 )
//              team1image.kf.setImage(with: imageUrl)
//            KingfisherManager.shared.retrieveImage(with: imageUrl!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
//
//            })
////               team1image?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
////               }
//           }
//
//           if let imagePath2 = data.team2logo {
//               //let urlString2 = imagePath2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//
//            let imageUrl = URL(string: data.team2logo! )
//            team2Image.kf.setImage(with: imageUrl)
////               team2Image?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
////               }
//           }
        if let time = data.time_start {
                setReleaseTime(releaseDateString: time)
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
               let countdown = "\(Utility.getStringFrom(seconds: hour))H \(Utility.getStringFrom(seconds: minute))M \(Utility.getStringFrom(seconds: second))S"
            timeLabl.text = countdown
               if day == 0 && hour == 0 && minute == 0 && second == 0 {
                   countdownTimer.invalidate()
               }
           }
       }



