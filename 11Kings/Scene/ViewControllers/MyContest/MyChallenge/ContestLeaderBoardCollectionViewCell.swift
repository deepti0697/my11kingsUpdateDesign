//
//  ContestLeaderBoardCollectionViewCell.swift
//  11Kings
//
//  Created by uu on 11/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol  openSelectionTeam {
    func OpenSelectionVc(join_id : Int?,
    challenge_id : Int?,
    team_id : Int?,
    userid : Int?)
}
class ContestLeaderBoardCollectionViewCell: UICollectionViewCell {
     @IBOutlet weak var compareTeamLive: UIButton!
       
        @IBOutlet weak var liveImage: UIImageView!
        var teamID:Int?
        var challengeID:Int?
        var userID:Int?
        var getIndex : Int?
        var getZeroIndex:Int?
        var compareTeam = false
        @IBOutlet weak var aTableView: UITableView!
        var delegate:openLEaderBoardPrview?
        @IBOutlet weak var downloadLbl: UILabel!
        @IBOutlet weak var downloadImageView: UIImageView!
        @IBOutlet weak var dowloadButton: UIButton!
    var delegates:openSelectionTeam?
        var leaderBoardRespnse = [GetLEaderBoardResponse]() {
            didSet {
                 downloadLbl.isHidden = false
                aTableView.reloadDataInMainQueue()
            }
        }
        override func awakeFromNib() {
               super.awakeFromNib()
            self.aTableView.setNeedsLayout()
            if homeType == .upcomming {
                downloadLbl.isHidden = true
                downloadImageView.isHidden = true
                dowloadButton.isHidden = true
                compareTeamLive.isHidden = true
                liveImage.isHidden = true
            
                    
                }
            else {
                dowloadButton.isHidden = false
                          compareTeamLive.isHidden = false
                          liveImage.isHidden = false
                      
                downloadLbl.isHidden = false
                downloadImageView.isHidden = false
                dowloadButton.isHidden = false
            }
               register()
           }
        var homeType: HomeType = .upcomming
       
        @IBAction func compareTeam(_ sender: Any) {
//            compareTeam = !compareTeam
//            let indexPath = IndexPath(row: getIndex ?? 0, section: 0)
//            let getindexValue = aTableView.cellForRow(at: indexPath) as! LeaderBoardTeamTVCell
//            if compareTeam {
//
//
//            if let checkID = UserDefaults.standard.object(forKey: kUserId) as? Int {
//
//            for i in leaderBoardRespnse {
//                if i.userid == checkID {
//
//                    challengeID = i.challenge_id
//                    teamID = i.team_id
//                    userID = i.userid
//                    getindexValue.isUserInteractionEnabled = false
//                    getindexValue.backgroundColor = UIColor(red: 220, green: 83, blue: 85)
//                    getindexValue.compareView.isHidden = false
//                }
//            }
//         }
//      }
//            else {
//                 getindexValue.compareView.isHidden = true
//                getindexValue.backgroundColor = UIColor(red: 8 / 255, green: 117 / 255, blue: 183 / 255, alpha: 0.25)
//                let indexPath = IndexPath(row: getIndex ?? 0, section: 0)
//                       let getindexValue = aTableView.cellForRow(at: indexPath)
//                       getindexValue?.isUserInteractionEnabled = true
//            }
//        }
    }
    }
    extension ContestLeaderBoardCollectionViewCell:  UITableViewDelegate, UITableViewDataSource {
        func register() {
               aTableView.register(UINib(nibName: LeaderBoardTeamTVCell.identifier(), bundle: nil), forCellReuseIdentifier: LeaderBoardTeamTVCell.identifier())

           }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return leaderBoardRespnse.count
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardTeamTVCell.identifier(), for: indexPath) as! LeaderBoardTeamTVCell
            cell.delegate = self
            cell.homeTyp = homeType
            if let checkID = UserDefaults.standard.object(forKey: kUserId) as? Int {
           
                if leaderBoardRespnse[indexPath.row].userid == checkID {
                    getIndex = indexPath.row
                    if indexPath.row == 0 {
                        getZeroIndex = indexPath.row
                    }
                    
                }
            }
            cell.configureCell(teams: leaderBoardRespnse[indexPath.row], homeType: homeType)
                        return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let data = leaderBoardRespnse[indexPath.row]
            if compareTeam {
                let data = leaderBoardRespnse[indexPath.row]
                                  if let team2Id = data.team_id{
                                    self.delegate?.sendDatatoComapreTeam(team1ID: teamID ?? 0, team2ID: team2Id, challengeID: challengeID ?? 0, userID: userID ?? 0)
                }
             }
                
            
                
            
            else {
                if let datas:Int = UserDefaults.standard.object(forKey: kUserId) as? Int {
                               
                    if data.userid == datas {
                       let data = leaderBoardRespnse[indexPath.row]
                       if let tID = data.team_id, let cID = data.challenge_id, let uID = data.userid {
                        self.delegate?.sendLEaderBoardPReviewData(teamID: tID, challengeID: cID, userID: uID)
                       }
                   }
                
                   else {
                
                    Loader.showToast(message: "You can preview team after match start", onView: self, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))

                   }
                }
            }
        }
           
    }
extension ContestLeaderBoardCollectionViewCell :openTeamViewController {
    func openTeam(join_id: Int?, challenge_id: Int?, team_id: Int?, userid: Int?) {
//        if let joind = leaderBoardRespnse[0] {
        self.delegates?.OpenSelectionVc(join_id: join_id, challenge_id: challenge_id, team_id: team_id, userid: userid)
//    }
    
    }
    
    
}


