//
//  LeaderboardCollectionViewCell.swift
//  DreamTeam
//
//  Created by Test on 03/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol openLEaderBoardPrview {
  func  sendLEaderBoardPReviewData(teamID: Int, challengeID: Int, userID: Int)
    func sendDatatoComapreTeam(team1ID:Int,team2ID:Int,challengeID:Int,userID:Int)
    
//    func sendDataforCompare(teamID: Int, challengeID: Int, userID: Int)
}

class LeaderboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var compareTeamLive: UIButton!
   
    @IBOutlet weak var compareView: UIView!
    @IBOutlet weak var liveImage: UIImageView!
    var teamID:Int?
    var selectedIndex = -1
    var challengeID:Int?
    var userID:Int?
    var getIndex : Int?
    var getZeroIndex:Int?
    var compareTeam = false
    var check = true
    var lastRow = 0
     var refreshControl = UIRefreshControl()
    @IBOutlet weak var aTableView: UITableView!
    var delegate:openLEaderBoardPrview?
     var leaderREsponsefiltr = [GetLEaderBoardResponse]()
    var leaderBoardUnfilteredArray = [GetLEaderBoardResponse]()
    @IBOutlet weak var downloadLbl: UILabel!
    @IBOutlet weak var downloadImageView: UIImageView!
    @IBOutlet weak var dowloadButton: UIButton!
    var leaderBoardRespnse = [GetLEaderBoardResponse]() {
        didSet {
//            dowloadButton.setTitle("Download (\(leaderBoardRespnse.count))", for: .normal)
            downloadLbl.text = "Download (\(leaderBoardRespnse.count))"
            if leaderBoardRespnse.count <= 1 {
                self.compareView.isHidden = true
            }
            else {
                self.compareView.isHidden = false
            for i in leaderBoardRespnse {

                if let user:Int = UserDefaults.standard.object(forKey: kUserId) as? Int {
                               if i.userid == user {
                                   leaderREsponsefiltr.append(i)
                               }
                               else {
                                leaderBoardUnfilteredArray.append(i)
                     }
                       }
                       }
                       print(leaderREsponsefiltr)
            
        }
            aTableView.reloadDataInMainQueue()
        }
    }
    
      func addPullToRefresh() {
               refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
               refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
               aTableView.refreshControl = refreshControl
           }
           
           @objc func refreshData(sender:AnyObject) {
             
    //          getMyContest()
    //           setNoDataLabel()
               aTableView.reloadData()
               self.refreshControl.endRefreshing()
           }
        
    var pdf: (() -> Void) = { }
    override func awakeFromNib() {
           super.awakeFromNib()
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
        addPullToRefresh()
       }
    
    var homeType: HomeType = .live
    @IBAction func compareTeam(_ sender: Any) {
        compareTeam = !compareTeam
        if leaderBoardRespnse.count > 0 {
        if compareTeam {
            compareTeamLive.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
//            liveImage.tint = #imageLiteral(resourceName: "compare")
            liveImage.tintColor = UIColor(red: 255, green: 195, blue: 145)
          
//            if leaderREsponsefiltr.count > 1 {
//            for i in 0..<leaderBoardRespnse.count  {
//                    let indexPath = IndexPath(row: i , section: 0)
//                if i <= lastRow {
//                    let getindexValue = aTableView.cellForRow(at: indexPath) as! LeaderBoardTeamTVCell
//                    if let data:Int = UserDefaults.standard.object(forKey: kUserId) as? Int {
//                    if leaderBoardRespnse[i].userid == data {
//
//                    getindexValue.isUserInteractionEnabled = true
////                    getindexValue.myTeamView.backgroundColor = UIColor(red: 220, green: 83, blue: 85)
//                    }
//
//                    else {
//                        getindexValue.isUserInteractionEnabled = true
//                        getindexValue.myTeamView.backgroundColor = .gray
//                    }
//                }
//                }
            
//             let indexPath = IndexPath(row: 0 , section: 0)
//                       let getindexValue = aTableView.cellForRow(at: indexPath) as! LeaderBoardTeamTVCell
//                                          getindexValue.compareView.isHidden = false
//
//
//                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
//                                                                getindexValue.compareView.isHidden = true
//                                                        })
            }
        
//        else {
//        let indexPath = IndexPath(row: getIndex ?? 0, section: 0)
//        let getindexValue = aTableView.cellForRow(at: indexPath) as! LeaderBoardTeamTVCell
//                selectedIndex = getIndex ?? -1
//        if let checkID = UserDefaults.standard.object(forKey: kUserId) as? Int {
//        for i in leaderBoardRespnse {
//            if i.userid == checkID {
//                challengeID = i.challenge_id
//                teamID = i.team_id
//                userID = i.userid
//                getindexValue.isUserInteractionEnabled = false
//                getindexValue.myTeamView.backgroundColor = UIColor(red: 220, green: 83, blue: 85)
//                getindexValue.compareView.isHidden = false
//                UIView.animate(withDuration: 1, delay: 5, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
//                                                                         getindexValue.compareView.alpha = 0
//                                                                            }, completion: { finished in
//                                                                        getindexValue.compareView.isHidden = true
//                                                                       })
////            }
//       }
//    }
//  }
// }
        else {
            selectedIndex = -1
            
            compareTeamLive.setTitleColor(UIColor(red: 255, green: 218, blue: 0), for: .normal)
            liveImage.tintColor = UIColor(red: 255, green: 218, blue: 0)
            if leaderREsponsefiltr.count > 0 {
                check = true
//
                
//                    for i in 0..<leaderBoardRespnse.count {
//                        for j in leaderREsponsefiltr {
//                            if leaderBoardRespnse[i].userid == j.userid  {
//                                let indexPath = IndexPath(row: i , section: 0)
//                                                        let getindexValue = aTableView.cellForRow(at: indexPath) as! LeaderBoardTeamTVCell
//                               getindexValue.isUserInteractionEnabled = true
//                                aTableView.reloadDataInMainQueue()
//                               getindexValue.myTeamView.backgroundColor = UIColor(red: 172, green: 135 , blue: 54)
                            }
                        }
//                    }
//                }
//                else {
//                   let indexPath = IndexPath(row: getIndex ?? 0, section: 0)
//                   let getindexValue = aTableView.cellForRow(at: indexPath) as! LeaderBoardTeamTVCell
//                    getindexValue.compareView.isHidden = true
////                        UIView.animate(withDuration: 1, delay: 5, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
////                                                          getindexValue.compareView.alpha = 0
////                                                             }, completion: { finished in
////                                                         getindexValue.compareView.isHidden = true
////                                                        })
//                       getindexValue.myTeamView.backgroundColor = UIColor(red: 172, green: 135 , blue: 54)
//                       getindexValue.isUserInteractionEnabled = true
//                }
//        }
//    }
    }
        aTableView.reloadDataInMainQueue()
    }
    @IBAction func downloadPDf(_ sender: Any) {
        pdf()
    }
    
}

extension LeaderboardCollectionViewCell:  UITableViewDelegate, UITableViewDataSource {
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
        
//        cell.homeTyp = homeType
       if let userid:Int = UserDefaults.standard.object(forKey: kUserId) as? Int {
           if leaderBoardRespnse[indexPath.row].userid == userid {
               getIndex = indexPath.row
           }
       }
       if selectedIndex == indexPath.row {
           cell.myTeamView.isHidden = false
           cell.myTeamView.backgroundColor = UIColor(red: 220, green: 83, blue: 85)
            cell.compareView.isHidden = false
           cell.isUserInteractionEnabled = false
       }
       else {
            cell.compareView.isHidden = true
            cell.myTeamView.isHidden = false
           cell.isUserInteractionEnabled = true
            cell.myTeamView.backgroundColor = UIColor(red: 172, green: 132, blue: 54)
       }
        if compareTeam {
            if indexPath.row == 0 {
                cell.compareView.isHidden = false
//                UIView.animate(withDuration: 2) {
//
//                   cell.compareView.alpha = 0
//                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   cell.compareView.isHidden = true
                }
            }
            else {
                  cell.compareView.isHidden = true
            }
        }
        else {
            if let userid:Int = UserDefaults.standard.object(forKey: kUserId) as? Int {
                      if leaderBoardRespnse[indexPath.row].userid == userid {
                          cell.isUserInteractionEnabled = true
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
       
        if compareTeam {
            

                if check {
                let data = leaderBoardRespnse[indexPath.row]
                 if let useridCheck:Int = UserDefaults.standard.object(forKey: kUserId) as? Int {
                    if useridCheck == data.userid {
                        self.teamID = data.team_id
                                       self.challengeID = data.challenge_id
                                       self.userID = data.userid
                        
                 for i in 0..<leaderBoardRespnse.count - 1 {
                    let indexPath = IndexPath(row: i , section: 0)
                    if i <= lastRow {
                    let getindexValue = aTableView.cellForRow(at: indexPath) as! LeaderBoardTeamTVCell
//                     getindexValue.compareView.isHidden = true
                    if leaderBoardRespnse[i].team_id == teamID {
                        selectedIndex = indexPath.row
                         getindexValue.isUserInteractionEnabled = false
                        
                         getindexValue.myTeamView.backgroundColor = UIColor(red: 220, green: 83, blue: 85)
//                    return
                    }
                    else {
                   
                    getindexValue.isUserInteractionEnabled = true
                    }
                }
                }
                check = false
                }
                    else {
                     let getindexValue = aTableView.cellForRow(at: indexPath) as! LeaderBoardTeamTVCell
                        getindexValue.compareView.isHidden = true
                                    Loader.showToast(message: "Please Select your team first", onView: self, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                               }
                           }
                }
            
           
                else {
                    
                    let data = leaderBoardRespnse[indexPath.row]
                    if let team2Id = data.team_id{
                      self.delegate?.sendDatatoComapreTeam(team1ID: teamID ?? 0, team2ID: team2Id, challengeID: challengeID ?? 0, userID: userID ?? 0)
                }
            }
            }
//            else {
//            let data = leaderBoardRespnse[indexPath.row]
//                              if let team2Id = data.team_id{
//                                self.delegate?.sendDatatoComapreTeam(team1ID: teamID ?? 0, team2ID: team2Id, challengeID: challengeID ?? 0, userID: userID ?? 0)
//            }
//            }
//         }
            
        
            
        
        else {
               if homeType != .upcomming {
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
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
               if indexPath == lastVisibleIndexPath {
                lastRow = indexPath.row
               }
           }
       }
}

