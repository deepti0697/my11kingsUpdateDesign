//
//  LeaderboardTournamentFirstTableViewCell.swift
//  11Kings
//
//  Created by uu on 27/08/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class LeaderboardTournamentFirstTableViewCell: UITableViewCell {

    @IBOutlet weak var rankImageView: UIImageView!
        @IBOutlet weak var nameLbl: UILabel!
        @IBOutlet weak var pointLbl: UILabel!
        @IBOutlet weak var rankLbl: UILabel!
        @IBOutlet weak var profileImageView: UIImageView!
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        override func layoutSubviews() {
              super.layoutSubviews()

              contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
          }
        func configureCellLeader(seriesResponse:LeaderBoardSeriesDetail) {
            profileImageView.layer.borderWidth = 1.0
                  profileImageView.layer.masksToBounds = false
                  profileImageView.layer.borderColor = UIColor.clear.cgColor
                  profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
                  profileImageView.clipsToBounds = true
            nameLbl.text = seriesResponse.team
            pointLbl.text = "\(seriesResponse.points ?? 0)"
            rankLbl.text = "#\(seriesResponse.rank ?? 0)"
            if let imageStr = seriesResponse.image{
                      print(imageStr)
                     
                      let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                      let imageUrl = URL(string: urlString ?? "")
                      profileImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                      }
                  }
            if profileImageView.image == nil {
                profileImageView.image = #imageLiteral(resourceName: "Profile")
            }
            if seriesResponse.rank == 1 {
                rankImageView.image = #imageLiteral(resourceName: "Rank1")
                rankImageView.isHidden = false
            }
           if seriesResponse.rank == 2 {
              rankImageView.image = #imageLiteral(resourceName: "Rank2")
                rankImageView.isHidden = false
            }
            if seriesResponse.rank == 3 {
                rankImageView.image = #imageLiteral(resourceName: "Rank3")
                rankImageView.isHidden = false
            }
            else {
                rankImageView.isHidden = true
            }
        }
    }
