//
//  FootballTeamCollectionViewCell.swift
//  DreamTeam
//
//  Created by Test on 06/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol openPlayerFootballStatisticProfile {
    func sendDatatoMainVc(player:PlayerListResponses)
}
class FootballTeamCollectionViewCell: UICollectionViewCell {
    
    
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
    var refreshControl = UIRefreshControl()
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
        aTableView.register(UINib(nibName: FootballTeamTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: FootballTeamTableViewCell.identifier())
    }
}


extension FootballTeamCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch playerDataIndex {
        case 0:
            return APP_DEL.FootballGoalKeeperArray.count
        case 1:
            return APP_DEL.FootballDefenderArray.count
        case 2:
            return APP_DEL.FootballMidFielderArray.count
        case 3:
            return APP_DEL.FootballFowordArray.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FootballTeamTableViewCell.identifier(), for: indexPath) as! FootballTeamTableViewCell
        cell.delegate = self
        switch playerDataIndex {
        case 0:
            
            let obj = APP_DEL.FootballGoalKeeperArray[indexPath.item]
            if APP_DEL.footballChoosedTeamArray.contains(where: {$0.id == obj.id}) {
                cell.DullView.alpha = 1
                cell.check = true
                
            }
            else {
                if APP_DEL.FootballchoosedGoalKeeperArray.count == 1  {
                    cell.backgroundImageView.image = nil
                    cell.DullView.alpha = 0.5
                }
                else {
                    cell.DullView.alpha = 1
                    cell.backgroundImageView.image = #imageLiteral(resourceName: "Path 22587")
                }
                cell.check = false
            }
            
            cell.configureCell(playerData: APP_DEL.FootballGoalKeeperArray[indexPath.item])
        case 1:
            let obj = APP_DEL.FootballDefenderArray[indexPath.item]
            if APP_DEL.footballChoosedTeamArray.contains(where: {$0.id == obj.id}) {
                cell.check = true
                cell.DullView.alpha = 1
            }
            else {
                if APP_DEL.FootballchoosedDefenderArray.count >= 2 && APP_DEL.FootballExtraPlayer == 0  {
                                   cell.backgroundImageView.image = nil
                    cell.DullView.alpha = 0.5
                               }
                else if APP_DEL.FootballchoosedDefenderArray.count == 6 {
                    cell.backgroundImageView.image = nil
                    cell.DullView.alpha = 0.5
                }
                               else {
                                   cell.DullView.alpha = 1
                                   cell.backgroundImageView.image = #imageLiteral(resourceName: "Path 22587")
                               }
                cell.check = false
            }
            
            cell.configureCell(playerData: APP_DEL.FootballDefenderArray[indexPath.item])
        case 2:
            let obj = APP_DEL.FootballMidFielderArray[indexPath.item]
            if APP_DEL.footballChoosedTeamArray.contains(where: {$0.id == obj.id}) {
                cell.check = true
           
               cell.DullView.alpha = 1
                         }
                         else {
                             if APP_DEL.FootballchoosedMidFielderArray.count >= 2 && APP_DEL.FootballExtraPlayer == 0  {
                                                cell.backgroundImageView.image = nil
                                cell.DullView.alpha = 0.5
                                            }
                             else if APP_DEL.FootballchoosedMidFielderArray.count == 6 {
                                cell.backgroundImageView.image = nil
                                cell.DullView.alpha = 0.5
                             }
                                            else {
                                                cell.DullView.alpha = 1
                                                cell.backgroundImageView.image = #imageLiteral(resourceName: "Path 22587")
                                            }
                cell.check = false
            }
            
            
            cell.configureCell(playerData: APP_DEL.FootballMidFielderArray[indexPath.item])
        case 3:
            let obj = APP_DEL.FootballFowordArray[indexPath.item]
            if APP_DEL.footballChoosedTeamArray.contains(where: {$0.id == obj.id}) {
                cell.check = true
              cell.DullView.alpha = 1
                         }
                         else {
                             if APP_DEL.FootballchoosedFowordArray.count >= 1 && APP_DEL.FootballExtraPlayer == 0  {
                                                cell.backgroundImageView.image = nil
                                cell.DullView.alpha = 0.5
                                            }
                             else if APP_DEL.FootballchoosedFowordArray.count == 3 {
                                cell.backgroundImageView.image = nil
                                cell.DullView.alpha = 0.5
                             }
                                            else {
                                                cell.DullView.alpha = 1
                                                cell.backgroundImageView.image = #imageLiteral(resourceName: "Path 22587")
                                            }
                cell.check = false
            }
            
            
            cell.configureCell(playerData: APP_DEL.FootballFowordArray[indexPath.item])
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1 - true 0 false
        let cell = tableView.cellForRow(at: indexPath) as! FootballTeamTableViewCell
        switch playerDataIndex {
        case 0:
            
            if cell.check {
                let obj =  APP_DEL.FootballGoalKeeperArray[indexPath.item]
                
                APP_DEL.FootballGoalKeeperArray[indexPath.row].isSelected = "0"
                
                wkSelectionTotal -= 1
                cell.isSelected = false
                cell.check = false
                if  (APP_DEL.FootballchoosedGoalKeeperArray.count > APP_DEL.minGoalKeeper) {
                    APP_DEL.FootballExtraPlayer =  APP_DEL.FootballExtraPlayer + 1
                }
                if let index2 = APP_DEL.footballChoosedTeamArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.footballChoosedTeamArray.remove(at: index2)
                }
                if let index = APP_DEL.FootballchoosedGoalKeeperArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.FootballchoosedGoalKeeperArray.remove(at: index)
                }
                
                removePlayerFromArray(player: APP_DEL.FootballGoalKeeperArray[indexPath.row])
                
            } else {
                cell.check = true
                if APP_DEL.footballChoosedTeamArray.count == 11 {
                    
                    Loader.showToast(message: "You can choose maximum 11 Player", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
                } else {
                    if playerTeamCountSeven(player: APP_DEL.FootballGoalKeeperArray[indexPath.row]) {
                        
                        Loader.showToast(message: "You can Select only 7 from a each team", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                    } else {
                        if checkCreaditLimitExceed(sPlayer: APP_DEL.FootballGoalKeeperArray[indexPath.row]) {
                            
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        } else {
                            if APP_DEL.FootballchoosedGoalKeeperArray.count != APP_DEL.maxGK {
                                if APP_DEL.FootballchoosedGoalKeeperArray.count < APP_DEL.minGoalKeeper || APP_DEL.FootballExtraPlayer > 0 {
                                    if APP_DEL.FootballchoosedGoalKeeperArray.count >= APP_DEL.minGoalKeeper {
                                        APP_DEL.FootballExtraPlayer = APP_DEL.FootballExtraPlayer - 1
                                    }
                                    let touple = toggle(selected: APP_DEL.FootballGoalKeeperArray[indexPath.row].isSelected == "1" ? true : false, total: wkSelectionTotal)
                                    APP_DEL.FootballGoalKeeperArray[indexPath.row].isSelected = touple.0
                                    wkSelectionTotal = touple.1
                                    addPlayerInArray(player: APP_DEL.FootballGoalKeeperArray[indexPath.row])
                                }
                                else {
                                    minimumPlayerWarning()
                                }
                            }
                            else {
                                Loader.showToast(message: "You can Select Only 1 GOALKEEPER", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                                
                                
                            }
                        }
                    }
                }
            }
        case 1:
            if cell.check {
                let obj =  APP_DEL.FootballDefenderArray[indexPath.item]
                
                APP_DEL.FootballDefenderArray[indexPath.row].isSelected = "0"
                if  (APP_DEL.FootballchoosedDefenderArray.count > APP_DEL.minDef) {
                    APP_DEL.FootballExtraPlayer =  APP_DEL.FootballExtraPlayer + 1;
                }
                batSelectionTotal -= 1
                cell.isSelected = false
                cell.check = false
                if let index2 = APP_DEL.footballChoosedTeamArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.footballChoosedTeamArray.remove(at: index2)
                }
                if let index = APP_DEL.FootballchoosedDefenderArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.FootballchoosedDefenderArray.remove(at: index)
                }
                
                
                removePlayerFromArray(player: APP_DEL.FootballDefenderArray[indexPath.row])
                
            } else {
                cell.check = true
                if APP_DEL.footballChoosedTeamArray.count == 11 {
                    
                    Loader.showToast(message: "You can choose maximum 11 Player", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                } else {
                    if playerTeamCountSeven(player: APP_DEL.FootballDefenderArray[indexPath.row]) {
                        Loader.showToast(message: "You can Select only 7 from a each team", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                    } else {
                        if checkCreaditLimitExceed(sPlayer: APP_DEL.FootballDefenderArray[indexPath.row]) {
                            
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        } else {
                            if APP_DEL.FootballchoosedDefenderArray.count != APP_DEL.maxDef {
                                if (APP_DEL.FootballchoosedDefenderArray.count < APP_DEL.minDef ||  APP_DEL.FootballExtraPlayer > 0) {
                                    if (APP_DEL.FootballchoosedDefenderArray.count >= APP_DEL.minDef) {
                                        APP_DEL.FootballExtraPlayer = APP_DEL.FootballExtraPlayer - 1
                                    }
                                    
                                    let touple = toggle(selected: APP_DEL.FootballDefenderArray[indexPath.row].isSelected == "1" ? true : false, total: batSelectionTotal)
                                    APP_DEL.FootballDefenderArray[indexPath.row].isSelected = touple.0
                                    batSelectionTotal = touple.1
                                    addPlayerInArray(player: APP_DEL.FootballDefenderArray[indexPath.row])
                                }
                                else {
                                    minimumPlayerWarning()
                                }
                            }else {
                                
                                Loader.showToast(message: "You can Select only  6 Defender", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                                
                            }
                        }
                    }
                }
            }
        case 2:
            if cell.check {
                let obj =  APP_DEL.FootballMidFielderArray[indexPath.item]
                APP_DEL.FootballMidFielderArray[indexPath.row].isSelected = "0"
                
                allSelectionTotal -= 1
                cell.isSelected = false
                cell.check = false
                if  (APP_DEL.FootballchoosedMidFielderArray.count > APP_DEL.minMid) {
                    APP_DEL.FootballExtraPlayer =  APP_DEL.FootballExtraPlayer + 1;
                }
                
                if let index2 = APP_DEL.footballChoosedTeamArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.footballChoosedTeamArray.remove(at: index2)
                }
                if let index = APP_DEL.FootballchoosedMidFielderArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.FootballchoosedMidFielderArray.remove(at: index)
                }
                removePlayerFromArray(player: APP_DEL.FootballMidFielderArray[indexPath.row])
                
            } else {
                cell.check = true
                
                if APP_DEL.footballChoosedTeamArray.count == 11 {
                    
                    Loader.showToast(message: "You can choose maximum 11 Player", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
                } else {
                    if playerTeamCountSeven(player: APP_DEL.FootballMidFielderArray[indexPath.row]) {
                        
                        Loader.showToast(message: "You can Select only 7 from a each team", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                        
                    } else {
                        if checkCreaditLimitExceed(sPlayer: APP_DEL.FootballMidFielderArray[indexPath.row]) {
                            
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        } else {
                            if APP_DEL.FootballchoosedMidFielderArray.count != APP_DEL.maxMid {
                                
                                if (APP_DEL.FootballchoosedMidFielderArray.count < APP_DEL.minMid ||  APP_DEL.FootballExtraPlayer > 0) {
                                    if (APP_DEL.FootballchoosedMidFielderArray.count >= APP_DEL.minMid) {
                                        APP_DEL.FootballExtraPlayer = APP_DEL.FootballExtraPlayer - 1
                                    }
                                    let touple = toggle(selected: APP_DEL.FootballMidFielderArray [indexPath.row].isSelected == "1" ? true : false, total: allSelectionTotal)
                                    
                                    APP_DEL.FootballMidFielderArray[indexPath.row].isSelected = touple.0
                                    allSelectionTotal = touple.1
                                    addPlayerInArray(player: APP_DEL.FootballMidFielderArray[indexPath.row])
                                }
                                else {
                                    minimumPlayerWarning()
                                }
                            }else {
                                
                                Loader.showToast(message: "You can Select only 6 MIDFIELDER", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            }
                        }
                    }
                }
            }
        case 3:
            if cell.check {
                let obj =  APP_DEL.FootballFowordArray[indexPath.item]
                
                APP_DEL.FootballFowordArray[indexPath.row].isSelected = "0"
                if  (APP_DEL.FootballchoosedFowordArray.count > APP_DEL.minForword) {
                    APP_DEL.FootballExtraPlayer =  APP_DEL.FootballExtraPlayer + 1;
                }
                bowSelectionTotal -= 1
                cell.isSelected = false
                cell.check = false
                if let index2 = APP_DEL.footballChoosedTeamArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.footballChoosedTeamArray.remove(at: index2)
                }
                if let index = APP_DEL.FootballchoosedFowordArray.firstIndex(where: {$0.id == obj.id}) {
                    APP_DEL.FootballchoosedFowordArray.remove(at: index)
                }
                removePlayerFromArray(player: APP_DEL.FootballFowordArray[indexPath.row])
                
            } else {
                cell.check = true
                
                if APP_DEL.footballChoosedTeamArray.count == 11 {
                    
                    Loader.showToast(message: "You can choose maximum 11 Player", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
                } else {
                    if playerTeamCountSeven(player: APP_DEL.FootballFowordArray[indexPath.row]) {
                        
                        Loader.showToast(message: "You can Select only 7 from a each team", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                        
                    } else {
                        if checkCreaditLimitExceed(sPlayer: APP_DEL.FootballFowordArray[indexPath.row]) {
                            
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                            return
                        } else {
                            if  APP_DEL.FootballchoosedFowordArray.count != 3 {
                                let touple = toggle(selected: APP_DEL.FootballFowordArray[indexPath.row].isSelected == "1" ? true : false, total: bowSelectionTotal)
                                if (APP_DEL.FootballchoosedFowordArray.count < APP_DEL.minForword ||  APP_DEL.FootballExtraPlayer > 0) {
                                    if (APP_DEL.FootballchoosedFowordArray.count >= APP_DEL.minForword) {
                                        APP_DEL.FootballExtraPlayer = APP_DEL.FootballExtraPlayer - 1
                                    }
                                    APP_DEL.FootballFowordArray[indexPath.row].isSelected = touple.0
                                    bowSelectionTotal = touple.1
                                    addPlayerInArray(player: APP_DEL.FootballFowordArray[indexPath.row])
                                }
                                else {
                                    minimumPlayerWarning()
                                }
                            } else {
                                
                                Loader.showToast(message: "You can Select only 6 Forword", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                                
                                
                                
                                
                                
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
    func minimumPlayerWarning() {
        if (APP_DEL.FootballchoosedDefenderArray.count < 2) {
            Loader.showToast(message:"You must select at least 2 Defender.", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
        } else if (APP_DEL.FootballchoosedMidFielderArray.count < 2) {
            Loader.showToast(message: "You must select at least 2 MidFielder.", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
        } else if (APP_DEL.FootballchoosedGoalKeeperArray.count < 1) {
            Loader.showToast(message: "You must select at least 1 Goal-Keepers.", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
        } else if (APP_DEL.FootballchoosedFowordArray.count < 1) {
            Loader.showToast(message: "You must select at least 1 Forword.", onView: self, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
            
        }
    }
    func addPlayerInArray(player: PlayerListResponses) {
        
        if player.role == "Forward" {
            APP_DEL.FootballchoosedFowordArray.append(player)
        }
        
        if player.role == "Defender" {
            APP_DEL.FootballchoosedDefenderArray.append(player)
        }
        if player.role == "Midfielder" {
            APP_DEL.FootballchoosedMidFielderArray.append(player)
        }
        if player.role == "Goalkeeper" {
            APP_DEL.FootballchoosedGoalKeeperArray.append(player)
        }
        // APP_DEL.editChoosedTeamArray.append(player)
        APP_DEL.footballChoosedTeamArray.append(player)
        playerCountClouser(APP_DEL.footballChoosedTeamArray.count)
        print("Add \(APP_DEL.footballChoosedTeamArray.count)")
        playerCreditCount()
        playerChoosedClouser()
    }
    func playerTeamCountSeven(player: PlayerListResponses) -> Bool {
        var tempFirstTotalPlayerCount = 0
        var tempSecondTotalPlayerCount = 0
        let players = APP_DEL.footballChoosedTeamArray
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
        print("rem\(APP_DEL.footballChoosedTeamArray.count)")
        APP_DEL.footballChoosedTeamArray = APP_DEL.footballChoosedTeamArray.filter({ $0.name != player.name})
        playerCountClouser(APP_DEL.footballChoosedTeamArray.count)
        print("remo\(APP_DEL.footballChoosedTeamArray.count)")
        playerCreditCount()
        playerChoosedClouser()
    }
    
    func playerCreditCount() {
        playerCreditTotal = 0.0
        let players = APP_DEL.footballChoosedTeamArray
        for player in players {
            if let playerCredit = player.credit {
                let pCr = Float(playerCredit) ?? 0.0
                playerCreditTotal += Double(pCr)
            }
        }
    }
    
    func checkCreaditLimitExceed(sPlayer: PlayerListResponses) -> Bool {
        var currentCredit = 0.0
        let players = APP_DEL.footballChoosedTeamArray
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

extension FootballTeamCollectionViewCell: openfootballPlayerProfile {
    func openProfile(playerResp: PlayerListResponses) {
        self.delgate?.sendDatatoMainVc(player:playerResp)
    }
    
}
