//
//  HomeVCCollectionCEll.swift
//  DreamTeam
//
//  Created by Test on 31/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import UIKit

protocol MatchTypeDetails {
    func sendgetMatchDetail(contstData:GetMatchDetails,matchType:String)
}

class HomeVCCollectionCEll : UICollectionViewCell {
    @IBOutlet weak var aTableView: UITableView!
       @IBOutlet weak var aNoDataLabel: UILabel!
    
    @IBOutlet weak var upcomingMatchLbl: UILabel!
    @IBOutlet weak var noMatchImageView: UIImageView!
    var isLaunched = false
    var contestFootballData = [GetMatchDetails]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var contestKabaddiData = [GetMatchDetails]() {
    didSet {
        aTableView.reloadDataInMainQueue()
    }
    }
    var delegate: MatchTypeDetails?
    var contestData = [GetMatchDetails]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var itematIndex = -1 {
           didSet {
               aTableView.reloadDataInMainQueue()
           }
       }
     var refreshControl = UIRefreshControl()
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
     var matchType: MatchesType = .cricket
    func showNoDataLabel(show: Bool, text: String) {
           aNoDataLabel.isHidden = !show
           aNoDataLabel.text = text
        noMatchImageView.isHidden = !show
        if aNoDataLabel.isHidden == true {
            upcomingMatchLbl.isHidden = false
//            upcomingMatchLbl.text = "Upcoming Matches"
        }
        else {
            upcomingMatchLbl.isHidden = true
        }
       }
      

        override func awakeFromNib() {
            super.awakeFromNib()
            registerCell()
             addPullToRefresh()
        }
        
        @objc private func refreshWeatherData(_ sender: Any) {
            aTableView.reloadDataInMainQueue()
        }
        
        fileprivate func registerCell() {
            aTableView.register(UINib(nibName: HomeTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: HomeTableViewCell.identifier())
        }
        
       
       
    }

    extension HomeVCCollectionCEll: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch itematIndex {
            case 0:
              return  contestData.count
            case 1:
               return contestFootballData.count
               
            case 2:
              return  contestKabaddiData.count
            default:
                  return contestData.count
            }
          
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:  HomeTableViewCell.identifier(), for: indexPath) as! HomeTableViewCell
                cell.celltype = self.matchType

            switch  itematIndex{
            case 0:
                if contestData.count > 0 {
                     cell.configureMyContestCell(data: contestData[indexPath.row])
                    if contestData[indexPath.row].launch_status == "pending" {
                        cell.matchStatusview.isHidden = false
                        cell.isLaunched = false
                        
                    }
                        
                    else {
                         cell.matchStatusview.isHidden = true
                         cell.isLaunched = true
                    }
                    if contestData[indexPath.row].is_leaderboard == 1 {
                                                     cell.leaderImageView.isHidden = false
                        cell.leaderboardHeightConstraint.constant = 25
                                                 }
                                                 else {
                         cell.leaderboardHeightConstraint.constant = 0
                                                      cell.leaderImageView.isHidden = true
                                                 }
                }
                
            case 1:
                if contestFootballData.count > 0 {
                                   cell.configureMyContestCellFootball(data: contestFootballData[indexPath.row])
                                   if contestFootballData[indexPath.row].launch_status == "pending" {
               //                                           cell.backgroundColor = UIColor.blue
                                                          cell.isLaunched = false
                                                           cell.matchStatusview.isHidden = false
                                                      }
                                   else {
                                        cell.matchStatusview.isHidden = true
                                       cell.isLaunched = true
                                       }
                    if contestFootballData[indexPath.row].is_leaderboard == 1 {
                        cell.leaderboardHeightConstraint.constant = 25
                                                                       cell.leaderImageView.isHidden = false
                                                                   }
                                                                   else {
                        cell.leaderboardHeightConstraint.constant = 0
                                                                        cell.leaderImageView.isHidden = true
                                                                   }
                               }
                
                 
            case 2:
               
                 
                 if contestKabaddiData.count > 0 {
                                    cell.configureMyContestCellKABADDI(data: contestKabaddiData[indexPath.row])
                                if contestKabaddiData[indexPath.row].launch_status == "pending" {
                //                                       cell.backgroundColor = UIColor.blue
                                                       cell.isLaunched = false
                                                        cell.matchStatusview.isHidden = false
                                                   }
                                else {
                                     cell.matchStatusview.isHidden = true
                                    cell.isLaunched = true
                                    }
                    if contestKabaddiData[indexPath.row].is_leaderboard == 1 {
                        cell.leaderboardHeightConstraint.constant = 25
                                                                       cell.leaderImageView.isHidden = false
                                                                   }
                                                                   else {
                        cell.leaderboardHeightConstraint.constant = 0
                                                                        cell.leaderImageView.isHidden = true
                                                                   }
                                }
            default:
                 cell.configureMyContestCell(data: contestData[indexPath.row])
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = aTableView.cellForRow(at: indexPath) as! HomeTableViewCell
          
            switch itematIndex {
                
            case 0:
                if cell.isLaunched {
                delegate?.sendgetMatchDetail(contstData: contestData[indexPath.row], matchType: "CRICKET")
                }
                else {
                    Loader.showToast(message: "To be available Soon", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                }
            case 1:

                  if cell.isLaunched {
                 delegate?.sendgetMatchDetail(contstData: contestFootballData[indexPath.row], matchType: "FOOTBALL")
                 }
                 else {
                     Loader.showToast(message: "To be available Soon", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                 }
            case 2:
                if cell.isLaunched {
                           delegate?.sendgetMatchDetail(contstData: contestKabaddiData[indexPath.row], matchType: "BASKETBALL")
                               }
                               else {
                                   Loader.showToast(message: "To be available Soon", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                               }
              
            default:
                break
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              switch itematIndex {
            case 0:
                if contestData[indexPath.row].is_leaderboard == 1 {
                   return 155
                }
                else {
                     return 140
                }
              case 1 :
                
                if contestFootballData[indexPath.row].is_leaderboard == 1 {
                              return 155
                           }
                else {
                     return 140
                }
              case 2 :
                if contestKabaddiData[indexPath.row].is_leaderboard == 1 {
                   return 155
                }
                else {
                     return 140
                }
                default:
                           return 140
                }
            }
            
           
          
          
           
        }
    


