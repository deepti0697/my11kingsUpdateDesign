//
//  TeamCollectionViewCell.swift
//  TeamBanao
//
//  Created by Developer on 21/02/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit
protocol TableViewCellLongPressDelegate {
    func tableViewCellHadLongPress(_ cell: TeamCollectionViewCell)
}
protocol openPlayerStatisticProfile {
    func sendDatatoMainVc(player:PlayerListResponses)
}

class TeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var aTableView: UITableView!
    var firstTeamName = ""
    var secondTeamName = ""
    var batIndexArray = [Int]()
    var bowIndexArray = [Int]()
    var allIndexArray = [Int]()
    var wkIndexArray = [Int]()
    var batSelectionClouser: ((Int) -> Void) = {_ in}
    var bowlSelectionClouser: ((Int) -> Void) = {_ in}
    var wkSelectionClouser: ((Int) -> Void) = {_ in}
    var allSelectionClouser: ((Int) -> Void) = {_ in}
    var playerCountClouser: ((Int) -> Void) = {_ in}
    var playerCreditClouser: ((Float) -> Void) = {_ in}
    var playerChoosedClouser: (() -> Void) = { }
    var delgate:openPlayerStatisticProfile?
     var refreshControl = UIRefreshControl()
    var playerDataIndex = -1 {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var batSelectionTotal = 0 {
        didSet {
            batSelectionClouser(batSelectionTotal)
        }
    }
    var bowSelectionTotal = 0 {
        didSet {
            bowlSelectionClouser(bowSelectionTotal)
        }
    }
    var allSelectionTotal = 0 {
        didSet {
            allSelectionClouser(allSelectionTotal)
        }
    }
    var wkSelectionTotal = 0 {
        didSet {
            wkSelectionClouser(wkSelectionTotal)
        }
    }
    var playerCreditTotal = 0.0 {
        didSet {
            playerCreditClouser(Float(playerCreditTotal))
        }
    }
    var playerSelectionTotal = 0
    var remainingCr = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerCell()
        addPullToRefresh()
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
    func registerCell() {
        aTableView.register(UINib(nibName: TeamTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: TeamTableViewCell.identifier())
    }
}


extension TeamCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch playerDataIndex {
        case 0:
            return APP_DEL.wkMansArray.count
        case 1:
            return APP_DEL.batMansArray.count
        case 2:
            return APP_DEL.allMansArray.count
        case 3:
            return APP_DEL.bowlMansArray.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier(), for: indexPath) as! TeamTableViewCell
        cell.delegate = self
        switch playerDataIndex {
        case 0:

            let obj = APP_DEL.wkMansArray[indexPath.item]
            if APP_DEL.choosedTeamArray.contains(where: {$0.id == obj.id}) {
                cell.check = true
                 cell.DullView.alpha = 1
            }
            else {
                if   APP_DEL.choosedWkMansArray.count >= 1  &&  APP_DEL.extraPlayer == 0{
                    cell.backgroundImage.image = nil
                    cell.DullView.alpha = 0.5
                }
                else if  APP_DEL.choosedWkMansArray.count >= 2 {
                    cell.backgroundImage.image = nil
                                       cell.DullView.alpha = 0.5
                }
               
                else {
                    cell.DullView.alpha = 1
                    cell.backgroundImage.image = #imageLiteral(resourceName: "Path 22587")
                }
                cell.notSelectedCell = false
                cell.check = false
            }
            cell.configureCell(playerData: APP_DEL.wkMansArray[indexPath.item])
        
        case 1:
//            playerDataIndex = 1
            let obj = APP_DEL.batMansArray[indexPath.item]
            if APP_DEL.choosedTeamArray.contains(where: {$0.id == obj.id}) {
                cell.check = true
                cell.notSelectedCell = false
            }
            else {
                if APP_DEL.choosedBatMansArray.count >= 2 && APP_DEL.extraPlayer == 0 {
                     cell.backgroundImage.image = nil
                    cell.DullView.alpha = 0.5
                }
                else {
                     cell.DullView.alpha = 1
                    cell.backgroundImage.image = #imageLiteral(resourceName: "Path 22587")
                }
                cell.check = false
                
            }
            
            cell.configureCell(playerData: APP_DEL.batMansArray[indexPath.item])
        case 2:
//            playerDataIndex = 2
            let obj = APP_DEL.allMansArray[indexPath.item]
            if APP_DEL.choosedTeamArray.contains(where: {$0.id == obj.id}) {
                cell.check = true
                cell.notSelectedCell = false
            }
            else {
               
                     if APP_DEL.chossedAllMansArray.count >= 2 && APP_DEL.extraPlayer == 0 {
                     cell.backgroundImage.image = nil
                        cell.DullView.alpha = 0.5
                    
                               }
                    else {
                     cell.DullView.alpha = 1
                                   cell.backgroundImage.image = #imageLiteral(resourceName: "Path 22587")
                               }
                cell.notSelectedCell = false
                cell.check = false
                
            }
            
            cell.configureCell(playerData: APP_DEL.allMansArray[indexPath.item])
        case 3:
//            playerDataIndex = 3
            let obj = APP_DEL.bowlMansArray[indexPath.item]
            if APP_DEL.choosedTeamArray.contains(where: {$0.id == obj.id}) {
                cell.check = true
                cell.notSelectedCell = false
                cell.DullView.alpha = 1
            }
            else {
                 if APP_DEL.choosedBowlMansArray.count >= 2 && APP_DEL.extraPlayer == 0 {
                    cell.DullView.alpha = 0.5
                     cell.backgroundImage.image = nil
                           }
                else {
                     cell.DullView.alpha = 1
                    cell.backgroundImage.image = #imageLiteral(resourceName: "Path 22587")
                           }
                cell.check = false
            }
            
            cell.configureCell(playerData: APP_DEL.bowlMansArray[indexPath.item])
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func checkWkSelection(){
        if APP_DEL.choosedWkMansArray.count < APP_DEL.minWk || APP_DEL.extraPlayer > 0 {
            if APP_DEL.choosedWkMansArray.count >= APP_DEL.minWk {
                APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
            }


        }
    }
    
    func checkBatSelection() {
        if (APP_DEL.choosedBatMansArray.count < APP_DEL.minBat ||  APP_DEL.extraPlayer > 0) {

      
            if (APP_DEL.choosedBatMansArray.count >= APP_DEL.minBat) {
            APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
        }
    }
    }
        
        func checkBowlSelection() {
            if (APP_DEL.choosedBowlMansArray.count < APP_DEL.minBowl ||  APP_DEL.extraPlayer > 0) {

                 
                       if (APP_DEL.choosedBowlMansArray.count >= APP_DEL.minBowl) {
                       APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                   }
        }
        }
            func checkAllPlayerSelection() {
                if (APP_DEL.chossedAllMansArray.count < APP_DEL.minAll ||  APP_DEL.extraPlayer > 0) {

                         
                               if (APP_DEL.chossedAllMansArray.count >= APP_DEL.minAll) {
                               APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                           }
                }
            }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1 - true 0 false
        let cell = tableView.cellForRow(at: indexPath) as! TeamTableViewCell
        switch playerDataIndex {
        case 0:
            if cell.check  {
               
                let obj =  APP_DEL.wkMansArray[indexPath.item]
                
                APP_DEL.wkMansArray[indexPath.row].isSelected = "0"
                
                wkSelectionTotal -= 1
                cell.isSelected = false
                cell.check = false
                if  (APP_DEL.choosedWkMansArray.count > APP_DEL.minWk) {
                    APP_DEL.extraPlayer =  APP_DEL.extraPlayer + 1
                }
                if let index2 = APP_DEL.choosedTeamArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.choosedTeamArray.remove(at: index2)
                }
                if let index = APP_DEL.choosedWkMansArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.choosedWkMansArray.remove(at: index)
                }
                
                removePlayerFromArray(player: APP_DEL.wkMansArray[indexPath.row])

                
            } else {
                cell.check = true
                
                if APP_DEL.choosedTeamArray.count == 11 {
                    
                    Loader.showToast(message: "You can choose maximum 11 Player", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                } else {
                    if playerTeamCountSeven(player: APP_DEL.wkMansArray[indexPath.row]) {
                        
                        Loader.showToast(message: "You can Select only 7 from a each team", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                        
                    } else {
                        if checkCreaditLimitExceed(sPlayer: APP_DEL.wkMansArray[indexPath.row]) {
                            
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        } else {
                            print(APP_DEL.maxWk)
                            
                            if APP_DEL.choosedWkMansArray.count != APP_DEL.maxWk {
                                if APP_DEL.choosedWkMansArray.count < APP_DEL.minWk || APP_DEL.extraPlayer > 0 {
                                    if APP_DEL.choosedWkMansArray.count >= APP_DEL.minWk {
                                        APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                                    }

                                let touple = toggle(selected: APP_DEL.wkMansArray[indexPath.row].isSelected == "1" ? true : false, total: wkSelectionTotal)
                                APP_DEL.wkMansArray[indexPath.row].isSelected = touple.0
                                wkSelectionTotal = touple.1
                                addPlayerInArray(player: APP_DEL.wkMansArray[indexPath.row])
//                                checkSelectionStatus()
                                } else {
                                minimumPlayerWarning()
                                }
                            }
                            else {
                                
                                
                                Loader.showToast(message: "You can Select only 2 Wicket-Keepers", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            }
                        }
                    }
                }
            }
        case 1:
            if  cell.check {
                
                let obj =  APP_DEL.batMansArray[indexPath.item]
                
                APP_DEL.batMansArray[indexPath.row].isSelected = "0"
                
                batSelectionTotal -= 1
                cell.isSelected = false
                cell.check = false
                if  (APP_DEL.choosedBatMansArray.count > APP_DEL.minBat) {
                    APP_DEL.extraPlayer =  APP_DEL.extraPlayer + 1;
                }
                if let index2 = APP_DEL.choosedTeamArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.choosedTeamArray.remove(at: index2)
                }
                if let index = APP_DEL.choosedBatMansArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.choosedBatMansArray.remove(at: index)
                }
                
                removePlayerFromArray(player: APP_DEL.batMansArray[indexPath.row])
//                checkBatManSelectionStatus()
                
            } else {
                cell.check = true
                if APP_DEL.choosedTeamArray.count == 11 {
                    
                    Loader.showToast(message: "You can choose maximum 11 Player", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                } else {
                    if playerTeamCountSeven(player: APP_DEL.batMansArray[indexPath.row]) {
                        
                        Loader.showToast(message: "You can Select only 7 from a each team", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                    } else {
                        if checkCreaditLimitExceed(sPlayer: APP_DEL.batMansArray[indexPath.row]) {
                            
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        } else {
                            print(APP_DEL.maxBat)
                            
                            if APP_DEL.choosedBatMansArray.count != APP_DEL.maxBat {
                                if (APP_DEL.choosedBatMansArray.count < APP_DEL.minBat ||  APP_DEL.extraPlayer > 0) {

                                  
                                        if (APP_DEL.choosedBatMansArray.count >= APP_DEL.minBat) {
                                        APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                                    }
                                
                                let touple = toggle(selected: APP_DEL.batMansArray[indexPath.row].isSelected == "1" ? true : false, total: batSelectionTotal)
                                APP_DEL.batMansArray[indexPath.row].isSelected = touple.0
                                batSelectionTotal = touple.1
                                addPlayerInArray(player: APP_DEL.batMansArray[indexPath.row])
//                                checkBatManSelectionStatus()
                            }
                                else {
                                minimumPlayerWarning()
                                }
                        }else {
                                
                                Loader.showToast(message: "You can Select only 6 Batsman", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            }
                        }
                    }
                }
            }
        case 2:
            if  cell.check  {
                let obj =  APP_DEL.allMansArray[indexPath.item]
                
                APP_DEL.allMansArray[indexPath.row].isSelected = "0"
                
                allSelectionTotal -= 1
                cell.isSelected = false
                cell.check = false
                if  (APP_DEL.chossedAllMansArray.count > APP_DEL.minAll) {
                                   APP_DEL.extraPlayer =  APP_DEL.extraPlayer + 1;
                               }
                if let index2 = APP_DEL.choosedTeamArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.choosedTeamArray.remove(at: index2)
                }
                if let index = APP_DEL.chossedAllMansArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.chossedAllMansArray.remove(at: index)
                }
                removePlayerFromArray(player: APP_DEL.allMansArray[indexPath.row])
//                checkAllSelectionStatus()
            } else {
                cell.check = true
                
                if APP_DEL.choosedTeamArray.count == 11 {
                    
                    Loader.showToast(message: "You can choose maximum 11 Player", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
                } else {
                    if playerTeamCountSeven(player: APP_DEL.allMansArray[indexPath.row]) {
                        
                        Loader.showToast(message: "You can Select only 7 from a each team", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                    } else {
                        if checkCreaditLimitExceed(sPlayer: APP_DEL.allMansArray[indexPath.row]) {
                            
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        } else {
                            if APP_DEL.chossedAllMansArray.count != APP_DEL.maxAll {
                                if (APP_DEL.chossedAllMansArray.count < APP_DEL.minAll ||  APP_DEL.extraPlayer > 0) {

                                                
                                                      if (APP_DEL.chossedAllMansArray.count >= APP_DEL.minAll) {
                                                      APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                                                  }
                                let touple = toggle(selected: APP_DEL.allMansArray[indexPath.row].isSelected == "1" ? true : false, total: allSelectionTotal)
                                APP_DEL.allMansArray[indexPath.row].isSelected = touple.0
                                allSelectionTotal = touple.1
                                addPlayerInArray(player: APP_DEL.allMansArray[indexPath.row])
//                                checkAllSelectionStatus()
                                } else {
                                minimumPlayerWarning()
                                }
                            } else {
                                
                                Loader.showToast(message: "You can Select only  6 All Rounder", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            }
                        }
                    }
                }
            }
        case 3:
            if  cell.check  {
                
                let obj =  APP_DEL.bowlMansArray[indexPath.item]
                APP_DEL.bowlMansArray[indexPath.row].isSelected = "0"
                bowSelectionTotal -= 1
                cell.isSelected = false
                cell.check = false
                if  (APP_DEL.choosedBowlMansArray.count > APP_DEL.minBowl) {
                    APP_DEL.extraPlayer =  APP_DEL.extraPlayer + 1;
                }
                if let index2 = APP_DEL.choosedTeamArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.choosedTeamArray.remove(at: index2)
                }
                if let index = APP_DEL.choosedBowlMansArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.choosedBowlMansArray.remove(at: index)
                }
                removePlayerFromArray(player: APP_DEL.bowlMansArray[indexPath.row])
//                checkBallManSelectionStatus()
            } else {
                cell.check = true
                
                if APP_DEL.choosedTeamArray.count == 11 {
                    
                    Loader.showToast(message: "You can choose maximum 11 Player", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
                } else {
                    if playerTeamCountSeven(player: APP_DEL.bowlMansArray[indexPath.row]) {
                        
                        Loader.showToast(message: "You can Select only 7 from a each team", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                    } else {
                        if checkCreaditLimitExceed(sPlayer: APP_DEL.bowlMansArray[indexPath.row]) {
                            
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        } else {
                            print(APP_DEL.maxBall)
                            if  APP_DEL.choosedBowlMansArray.count != APP_DEL.maxBall  {
                                if (APP_DEL.choosedBowlMansArray.count < APP_DEL.minBowl ||  APP_DEL.extraPlayer > 0) {

                                
                                      if (APP_DEL.choosedBowlMansArray.count >= APP_DEL.minBowl) {
                                      APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                                  }
                                let touple = toggle(selected: APP_DEL.bowlMansArray[indexPath.row].isSelected == "1" ? true : false, total: bowSelectionTotal)
                                APP_DEL.bowlMansArray[indexPath.row].isSelected = touple.0
                                bowSelectionTotal = touple.1
                                addPlayerInArray(player: APP_DEL.bowlMansArray[indexPath.row])
//                                checkBallManSelectionStatus()
                                }
                                else {
                                minimumPlayerWarning()
                                }
                            }
                            else {
                                
                                Loader.showToast(message: "You can Select only  6 Bowler", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                                
                            }
                        }
                    }
                }
            }
        default:
            break
        }
        aTableView.reloadDataInMainQueue()
    }
    func minimumPlayerWarning() {
        if (APP_DEL.choosedBowlMansArray.count < 2) {
             Loader.showToast(message:"You must select at least 2 Bowlers.", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))

          } else if (APP_DEL.choosedBatMansArray.count < 2) {
Loader.showToast(message: "You must select at least 2 Batsmen.", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
             
          } else if (APP_DEL.choosedWkMansArray.count < 1) {
Loader.showToast(message: "You must select at least 1 Wicket-Keepers.", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
          } else if (APP_DEL.chossedAllMansArray.count < 2) {
            Loader.showToast(message: "You must select at least 2 All-Rounders.", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))

            
          }
      }
    func toggle(selected: Bool, total: Int) -> (String,Int) {
        if selected == true {
            playerSelectionTotal += 1
            return ("0", total - 1)
        }
        playerSelectionTotal -= 1
        if playerSelectionTotal <= 0 {
            playerSelectionTotal = 0
        }
        return ("1", total + 1)
    }
    
    //    func addPlayerInArray(player: PlayerListResponses) {
    //        APP_DEL.choosedTeamArray.append(player)
    //        playerCountClouser(APP_DEL.choosedTeamArray.count)
    //        print("Add \(APP_DEL.choosedTeamArray.count)")
    //        playerCreditCount()
    //        playerChoosedClouser()
    //    }
    func addPlayerInArray(player: PlayerListResponses) {
        
        if player.role == "bowler" {
            APP_DEL.choosedBowlMansArray.append(player)
        }
        
        if player.role == "batsman" {
            APP_DEL.choosedBatMansArray.append(player)
        }
        if player.role == "allrounder" {
            APP_DEL.chossedAllMansArray.append(player)
        }
        if player.role == "keeper" {
            APP_DEL.choosedWkMansArray.append(player)
        }
        // APP_DEL.editChoosedTeamArray.append(player)
        APP_DEL.choosedTeamArray.append(player)
        playerCountClouser(APP_DEL.choosedTeamArray.count)
        print("Add \(APP_DEL.choosedTeamArray.count)")
        playerCreditCount()
        playerChoosedClouser()
    }
    func playerTeamCountSeven(player: PlayerListResponses) -> Bool {
        var tempFirstTotalPlayerCount = 0
        var tempSecondTotalPlayerCount = 0
        let players = APP_DEL.choosedTeamArray
        for player in players {
            guard let platerTeam = player.team else {
                return false
            }
            if (platerTeam == "team1") {
                tempFirstTotalPlayerCount += 1
            } else if (platerTeam == "team2") {
                tempSecondTotalPlayerCount += 1
            }
        }
        guard let platerTeam = player.team else {
            return false
        }
        if (platerTeam == "team1") {
            if tempFirstTotalPlayerCount  == 7 {
                return true
            } else {
                return false
            }
        } else {
            if tempSecondTotalPlayerCount  == 7 {
                return true
            } else {
                return false
            }
        }
    }
    
    func removePlayerFromArray(player: PlayerListResponses) {
        print("rem\(APP_DEL.choosedTeamArray.count)")
        APP_DEL.choosedTeamArray = APP_DEL.choosedTeamArray.filter({ $0.name != player.name})
        playerCountClouser(APP_DEL.choosedTeamArray.count)
        print("remo\(APP_DEL.choosedTeamArray.count)")
        playerCreditCount()
        playerChoosedClouser()
    }
    
    func playerCreditCount() {
        playerCreditTotal = 0.0
        let players = APP_DEL.choosedTeamArray
        for player in players {
            if let playerCredit = player.credit {
                let pCr = Float(playerCredit) ?? 0.0
                playerCreditTotal += Double(pCr)
            }
        }
    }
    
    func checkCreaditLimitExceed(sPlayer: PlayerListResponses) -> Bool {
        var currentCredit = 0.0
        let players = APP_DEL.choosedTeamArray
        for player in players {
            if let playerCredit = player.credit {
                let pCr = Double(playerCredit) ?? 0.0
                currentCredit += pCr
            }
        }
        remainingCr = 100.0 - currentCredit
        if let selectedPlayerCreadit = sPlayer.credit {
            if let sPCr = Double(selectedPlayerCreadit) {
                if remainingCr >= sPCr {
                    return false
                } else {
                    return true
                }
            }
        }
        return false
    }
    
}
extension TeamCollectionViewCell: openPlayerProfile {
    func openProfile(playerResp: PlayerListResponses) {
        self.delgate?.sendDatatoMainVc(player:playerResp)
    }
    
}


