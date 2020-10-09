//
//  KABADDITeamViewController.swift
//  DreamTeam
//
//  Created by Test on 05/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class KABADDITeamViewController: BaseClass {
    
    
      var fromTeamSelection = false
     @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var centerLbl: UILabel!
    @IBOutlet weak var centerValue: UILabel!
    @IBOutlet weak var pgValue: UILabel!
    @IBOutlet weak var pgLbl: UILabel!
    
    @IBOutlet weak var raiderrOutlt: UIButton!
    @IBOutlet weak var defenderOutlt: UIButton!
    @IBOutlet weak var arOutlt: UIButton!
    var remainingCr = 0.0
    @IBOutlet weak var timeLbl: UILabel!
    var createTeam: (() -> Void) = { }
    @IBOutlet weak var aPlayerCountContainerView: UIView!
    @IBOutlet weak var totalPlayer: UILabel!
    @IBOutlet weak var aMatchDetailContainerView: UIView!
    @IBOutlet weak var aCountContainerView: UIView!
    @IBOutlet weak var aWKLabel: UILabel!
    @IBOutlet weak var aBatLabel: UILabel!
    @IBOutlet weak var aARLabel: UILabel!
    @IBOutlet weak var aPlayerCollectionView: UICollectionView!
    @IBOutlet weak var aCountCollectionView: UICollectionView!
    @IBOutlet weak var aFirstTeamImageView: UIImageView!
    @IBOutlet weak var aSecondTeamImageView: UIImageView!
    @IBOutlet weak var aFirstTeamNameLabel: UILabel!
    @IBOutlet weak var aSecondTeamNameLabel: UILabel!
    @IBOutlet weak var aFirstTeamValueLabel: UILabel!
    @IBOutlet weak var aSecondTeamValueLabel: UILabel!
    @IBOutlet weak var aSelectionView: UIView!
    @IBOutlet weak var aCreditValue: UILabel!
    
    @IBOutlet weak var aAllValue: UILabel!
    @IBOutlet weak var aBatValue: UILabel!
    @IBOutlet weak var aWkValue: UILabel!
    @IBOutlet weak var aNextButton: UIButton!
    @IBOutlet weak var aCreditImageView: UIImageView!
    @IBOutlet weak var aPointsImageView: UIImageView!
    
    
    
     var contestLiveData:MyContestLiveLeagues?
    var delegate:deleteAllDaata?
    @IBOutlet weak var choosePlayerLbl: UILabel!
    var fromEditVC = false
    var playerId:Int?
    var fromPreview = false
    var sortingIndex:Int?
    var firstTeamName = ""
    var secondTeamName = ""
    var allRounderCount = 0
    var batsManCount = 0
    var teamId = 0
    var arrayOFPlayer = [Int]()
    var viceCaptian = 0
    var Captain = 0
    var ruleView:SelectionRuleForKabaddi?
    
    var wKeeperCount = 0
    var centerCount = 0
    var pgCount = 0
    var totalcredit = 100.0
    var teamNumber = ""
    var playerCountArray = ["1", "2", "3", "4", "5", "6", "7","8"]
    var totalSelectedArray:String?
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var contestData: GetMatchDetails?
    var matchKey = "" {
        didSet {
            //    getPlayerList(matchKey: matchKey)
        }
    }
    
    var playerDetail = [PlayerListResponses]()
    var visibleCellIndex = 0 {
        didSet {
            moveSelectionView(index: visibleCellIndex)
        }
    }
    var tempRaiderArray = [PlayerListResponses]()
    var tempDefenderArray = [PlayerListResponses]()
    var tempAllrounderArray = [PlayerListResponses]()
    var tempCenterArray = [PlayerListResponses]()
    var tempPointGuardArray = [PlayerListResponses]()
           
    
    
    func registerCell() {
        aCountCollectionView.register(UINib(nibName: KabaddiTeamCountCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: KabaddiTeamCountCollectionViewCell.identifier())
        aPlayerCollectionView.register(UINib(nibName: KabaddiCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: KabaddiCollectionViewCell.identifier())
    }
    
    func setupUI() {
        choosePlayerLbl.text   =  "Pick 1-4 Point-GUARD "
    }
    
    @IBAction func backButton(_ sender: Any) {
          self.removeChangePassView()
              for controller in self.navigationController!.viewControllers as Array {
                  if fromTeamSelection {
                  if controller.isKind(of: SelectMultipleTeamViewController.self) {
                      
                      self.navigationController!.popToViewController(controller, animated: true)
                      break
                  }
                  if controller.isKind(of: MyTeamViewController.self) {
                                     
                                     self.navigationController!.popToViewController(controller, animated: true)
                                     break
                                 }
                  }
                  else {
                  if controller.isKind(of: LeagueCollectionViewController.self) {
                      
                      self.navigationController!.popToViewController(controller, animated: true)
                      break
                  }
                    if controller.isKind(of: SelectMultipleTeamViewController.self) {
                        
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                    if controller.isKind(of: MyTeamViewController.self) {
                                       
                                       self.navigationController!.popToViewController(controller, animated: true)
                                       break
                                   }
                    }
                  
                 
              }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        resetAllData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerStatusView.isHidden = true
        registerCell()
        setContestData()
       
        if !fromPreview {
            setupUI()
             APP_DEL.KabaddiExtraPlayer = 3
            getPlayerList(matchKey: matchKey)
        }
        
    
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeChangePassView()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    override func handleBackButtonAction() -> Void {
        self.removeChangePassView()
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: LeagueCollectionViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    override func handleBinButtonAction() -> Void {
        self.removeChangePassView()
        guard let totlpayr = Int(totalPlayer.text ?? "8") else { return}
        if totlpayr > 0 {
            ShowimportantAlert(title: "Alert!", message: "Are you sure you want to clear Selected team??", handlerOK: { action in
                print("Action Called")
                self.totalPlayer.text = "0"
                self.aCreditValue.text = "100.0"
                self.resetAllData()
                self.arrayOFPlayer.removeAll()
                self.Captain = 0
                self.viceCaptian = 0
                self.totalcredit = 100.0
                self.wKeeperCount = 0
                self.allRounderCount = 0
                self.batsManCount = 0
                APP_DEL.KabaddiExtraPlayer = 3
                self.getPlayerList(matchKey: self.matchKey)
                self.aFirstTeamValueLabel.text = "0"
                self.aSecondTeamValueLabel.text = "0"
                self.aWkValue.text = "0"
                self.aBatValue.text = "0"
                self.aAllValue.text = "0"
                
                self.playerDetail.removeAll()
                self.aPlayerCollectionView.reloadDataInMainQueue()
                self.aCountCollectionView.reloadDataInMainQueue()
                
            }, handlerCancle: {actionCanel in
                print("Action cancel called")
            })
        }
        else {
            
            Loader.showToast(message: "No player Selected to clear", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
        }
    }
    fileprivate func resetAllData() {
        APP_DEL.KabaddiChoosedPGArray.removeAll()
        APP_DEL.kabaddiChoosedCenterArray.removeAll()
        APP_DEL.KabaddiPgArray.removeAll()
        APP_DEL.KabaddiCenterArray.removeAll()
        APP_DEL.kabbaddiChoosedTeamArray.removeAll()
        APP_DEL.kabaddichoosedAllrounderArray.removeAll()
        APP_DEL.kabaddichossedRaiderArray.removeAll()
        APP_DEL.kabaddichoosedDefenderArray.removeAll()
        APP_DEL.KabaddiRaiders.removeAll()
        APP_DEL.KabaddiDefender.removeAll()
        APP_DEL.kabaddiAllrounder.removeAll()
        APP_DEL.allMansArray.removeAll()
        APP_DEL.wkMansArray.removeAll()
        APP_DEL.bowlMansArray.removeAll()
        APP_DEL.batMansArray.removeAll()
        APP_DEL.choosedTeamArray.removeAll()
        APP_DEL.i1p1os = 0
        APP_DEL.i1p1oe = 0
        APP_DEL.i1p2os = 0
        APP_DEL.i1p2oe = 0
        APP_DEL.i1p3os = 0
        APP_DEL.i1p3oe = 0
        APP_DEL.i2p1os = 0
        APP_DEL.i2p1oe = 0
        APP_DEL.i2p2os = 0
        APP_DEL.i2p2oe = 0
        APP_DEL.i2p3os = 0
        APP_DEL.i2p3oe = 0
      
       
        tempRaiderArray.removeAll()
         tempDefenderArray.removeAll()
         tempAllrounderArray.removeAll()
         tempCenterArray.removeAll()
         tempPointGuardArray.removeAll()
        APP_DEL.editBatMansArray.removeAll()
        APP_DEL.editBowlMansArray.removeAll()
        APP_DEL.editAllMansArray.removeAll()
        APP_DEL.editWkMansArray.removeAll()
        APP_DEL.editChoosedTeamArray.removeAll()
        APP_DEL.choosedBatMansArray.removeAll()
        APP_DEL.choosedBowlMansArray.removeAll()
        APP_DEL.chossedAllMansArray.removeAll()
        APP_DEL.choosedWkMansArray.removeAll()
    }
    
    fileprivate func setContestData() {
        if let contest = contestData  {
            setReleaseTime(releaseDateString: contest.time_start ?? "0")
            matchKey = contest.matchkey ?? ""
            aFirstTeamNameLabel.text = "\(contest.team1display)"
            aSecondTeamNameLabel.text = "\(contest.team2display ?? "")"
            firstTeamName = "\(contest.team1display )"
            secondTeamName = "\(contest.team2display ?? "")"
            if let imagePath1 = contest.team1logo {
                let urlString1 = imagePath1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                let imageUrl = URL(string: urlString1 ?? "")
                aFirstTeamImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                }
            }
            
            if let imagePath2 = contest.team2logo {
                let urlString2 = imagePath2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                let imageUrl = URL(string: urlString2 ?? "")
                aSecondTeamImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                }
            }
            
        }
        if let contest = contestLiveData  {
            setReleaseTime(releaseDateString: contest.time_start ?? "0")
            matchKey = contest.matchkey ?? ""
            aFirstTeamNameLabel.text = "\(contest.team1display ?? "")"
            aSecondTeamNameLabel.text = "\(contest.team2display ?? "")"
            firstTeamName = "\(contest.team1display ?? "" )"
            secondTeamName = "\(contest.team2display ?? "")"
            if let imagePath1 = contest.team1logo {
                let urlString1 = imagePath1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                let imageUrl = URL(string: urlString1 ?? "")
                aFirstTeamImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                }
            }
            
            if let imagePath2 = contest.team2logo {
                let urlString2 = imagePath2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                let imageUrl = URL(string: urlString2 ?? "")
                aSecondTeamImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
                }
            }
            
        }
        
    }
    
    fileprivate func setReleaseTime(releaseDateString: String) {
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    var playerCheck = false
    @IBAction func PlayerFilter(_ sender: UIButton){
        aCreditImageView.image = nil
        aPointsImageView.image = nil
        if playerCheck {

            playerImageView.image =  #imageLiteral(resourceName: "up")
            APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                ($0.name ?? "0")  >  ($1.name ?? "0")
                
            }
            APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                ($0.name ?? "0")  >  ($1.name ?? "0")
                
            }
            APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                ($0.name ?? "0")  >  ($1.name ?? "0")
                
            }
            APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                ($0.name ?? "0")  >  ($1.name ?? "0")
                
            }
            APP_DEL.KabaddiPgArray =  APP_DEL.KabaddiPgArray.sorted {
                           ($0.name ?? "0")  >  ($1.name ?? "0")
                           
                       }
        }
            
        else {
            playerImageView.image = #imageLiteral(resourceName: "down")

                      APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                           ($0.name ?? "0")  <  ($1.name ?? "0")
                           
                       }
                       APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                           ($0.name ?? "0")  <  ($1.name ?? "0")
                           
                       }
                       APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                           ($0.name ?? "0")  <  ($1.name ?? "0")
                           
                       }
                       APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                           ($0.name ?? "0")  <  ($1.name ?? "0")
                           
                       }
                       APP_DEL.KabaddiPgArray =  APP_DEL.KabaddiPgArray.sorted {
                                      ($0.name ?? "0")  <  ($1.name ?? "0")
                                      
                           
                       }
        }
        playerCheck = !playerCheck
        aPlayerCollectionView.reloadDataInMainQueue()
        
    }
    
    @IBAction func teamPreviewVC(_ sender: Any) {
        print(APP_DEL.choosedTeamArray)
        previewAction()
        
    }
    func previewAction() {
        openViewController(controller: KabaddiPreviewViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            //            vc.teamId = teamID
            vc.contestData = self.contestData
            //                vc.isFromCreateTEam = true
            vc.delegate = self
            vc.captainID = "\(self.Captain)"
            vc.cId = self.Captain
            vc.vcID = self.viceCaptian
            vc.viceCaptianID = "\(self.viceCaptian)"
            //                 vc.selectedIndex = index
        }
    }
    @IBOutlet weak var playingBlank: UIImageView!
          @IBOutlet weak var notPlayingBlank: UIImageView!
       @IBOutlet weak var playerStatusView: UIView!
           @IBAction func playingAction(_ sender: UIButton) {
//            aCreditValue.text = "\(0)"
//            aWkValue.text = "\(0) "
//            aBatValue.text = "\(0)"
//            aAllValue.text = "\(0)"
//            pgValue.text = "\(0)"
//            centerLbl.text = "0"
//            self.setFilteredArray(model: self.playerDetail)
                   playingBlank.image = #imageLiteral(resourceName: "RedCircle")
                    notPlayingBlank.image = #imageLiteral(resourceName: "path Blank")
                         
                 APP_DEL.KabaddiRaiders = APP_DEL.KabaddiRaiders.filter { $0.is_playing == 1 }
                               APP_DEL.kabaddiAllrounder = APP_DEL.kabaddiAllrounder.filter { $0.is_playing == 1 }
                                APP_DEL.KabaddiPgArray = APP_DEL.KabaddiPgArray.filter { $0.is_playing == 1 }
                               APP_DEL.KabaddiCenterArray = APP_DEL.KabaddiCenterArray.filter { $0.is_playing == 1 }
               APP_DEL.KabaddiDefender = APP_DEL.KabaddiDefender.filter { $0.is_playing == 1 }
               self.aPlayerCollectionView.reloadDataInMainQueue()
                playerStatusView.isHidden = true
            for recognizer in view.gestureRecognizers ?? [] {
                view.removeGestureRecognizer(recognizer)
            }
               }

               @IBAction func closeView(_ sender: Any) {
                   playerStatusView.isHidden = true
                for recognizer in view.gestureRecognizers ?? [] {
                               view.removeGestureRecognizer(recognizer)
                           }
               }
               
               @IBAction func notPlaying(_ sender: Any) {
//                 self.setPlayerListData(model: self.playerDetail)
//                self.setFilteredArray(model: self.playerDetail)
                notPlayingBlank.image = #imageLiteral(resourceName: "RedCircle")
                   playingBlank.image = #imageLiteral(resourceName: "path Blank")
                  
                      APP_DEL.KabaddiRaiders = APP_DEL.KabaddiRaiders.filter { $0.is_playing == 0 }
                                                   APP_DEL.kabaddiAllrounder = APP_DEL.kabaddiAllrounder.filter { $0.is_playing == 0 }
                                                    APP_DEL.KabaddiPgArray = APP_DEL.KabaddiPgArray.filter { $0.is_playing == 0 }
                                                   APP_DEL.KabaddiCenterArray = APP_DEL.KabaddiCenterArray.filter { $0.is_playing == 0 }
                                   APP_DEL.KabaddiDefender = APP_DEL.KabaddiDefender.filter { $0.is_playing == 0 }
                   self.aPlayerCollectionView.reloadDataInMainQueue()
                    playerStatusView.isHidden = true
                for recognizer in view.gestureRecognizers ?? [] {
                    view.removeGestureRecognizer(recognizer)
                }
                
               }
               
           

           @IBAction func playerStatus(_ sender: Any) {
          APP_DEL.KabaddiDefender = self.tempDefenderArray
                 APP_DEL.KabaddiRaiders = self.tempRaiderArray
                 APP_DEL.kabaddiAllrounder = self.tempAllrounderArray
                 APP_DEL.KabaddiCenterArray = self.tempCenterArray
                 APP_DEL.KabaddiPgArray = self.tempPointGuardArray
               playerStatusView.isHidden = false
      
               let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
               self.view.addGestureRecognizer(mytapGestureRecognizer)
            
           }
    
           @objc func handleTap(_ sender:UITapGestureRecognizer){
              
                   self.playerStatusView.isHidden = true
               for recognizer in view.gestureRecognizers ?? [] {
                   view.removeGestureRecognizer(recognizer)
               }
              
                  }
    
           override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
               let touch = touches.first
               if touch?.view != self.playerStatusView
               {
                   self.playerStatusView.isHidden = true
                   self.dismiss(animated: true, completion: nil)
                   
               }
           }
//       
       
       
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
        let countdown = "\(Utility.getStringFrom(seconds: day))D \(Utility.getStringFrom(seconds: hour))H \(Utility.getStringFrom(seconds: minute))M \(Utility.getStringFrom(seconds: second))S"
        timeLbl.text = countdown
        if day == 0 && hour == 0 && minute == 0 && second == 0 {
            countdownTimer.invalidate()
        }
    }
    
    
    func getPlayerList(matchKey: String) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTU5NjM2NSwiZXhwIjoxNTY1NTk5OTY1LCJuYmYiOjE1NjU1OTYzNjUsImp0aSI6IjI0VjdpQnAyZkhtTUR3MnkiLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.lhe4Fkzq1m0PMwebcf_BEsKKuRncIGBKn1QbuKEdF8I",
            "content-type": "application/x-www-form-urlencoded",
            "Accept" : "application/json"
        ]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = [
                "matchkey": matchKey,
                "sport_key":"BASKETBALL"
            ]
            NetworkManager.post_Request(urlService: kPlayerListURL, param: param, head: headers) {
                (response) in
                
                self.hideActivityIndicator()
                
                guard let data = response else { return }
                do{
                    let json = try JSON(data:data as! Data)
                    //                 let list = MyCatagries(json: json)
                    
                    let results = json["result"]
                    //let cat = results["categories"]
                    //
                    self.playerDetail.removeAll()
                    for arr in results.arrayValue{
                        self.playerDetail.append(PlayerListResponses(json:arr))

                        
                    }
                    self.setPlayerListData(model: self.playerDetail)
                    
                }
                catch{
                    self.view.makeToast(message: "Internal Error")
                    print(error.localizedDescription)
                }
            }
            
            
        }
        
    }
    
    
    fileprivate func setFilteredArray(model: [PlayerListResponses]) {
               var tempRaiderArray = [PlayerListResponses]()
                      var tempDefenderArray = [PlayerListResponses]()
                      var tempAllrounderArray = [PlayerListResponses]()
                      var tempCenterArray = [PlayerListResponses]()
                      var tempPointGuardArray = [PlayerListResponses]()
                    for data in model {
                      
                  
                                 if data.role == "Shooting guard" {
                                     tempRaiderArray.append(data)
                                 }
                                 if data.role == "Small forward" {
                                     tempDefenderArray.append(data)
                                 }
                                 if data.role == "Point guard" {
                                     tempAllrounderArray.append(data)
                                 }
                                 if data.role == "Center" {
                                     tempCenterArray.append(data)
                                 }
                                 if data.role == "Power forward" {
                                     tempPointGuardArray.append(data)
                                 }
                        
                   if arrayOFPlayer.count > 0 {
                                  APP_DEL.KabaddiExtraPlayer = 0
                                  for selectedPlayer in arrayOFPlayer {
                                      if data.id == selectedPlayer {
                                     if APP_DEL.kabbaddiChoosedTeamArray.contains(where: {$0.id == data.id}) {
                                        break
                                         }
                                        else {
                                          APP_DEL.kabbaddiChoosedTeamArray.append(data)
                                          if data.role == "Small forward" {
                                              batsManCount += 1
                                              APP_DEL.kabaddichoosedDefenderArray.append(data)
                                          }
                                          if data.role == "Shooting guard" {
                                              allRounderCount += 1
                                              APP_DEL.kabaddichossedRaiderArray.append(data)
                                          }
                                          if data.role == "Point guard" {
                                              wKeeperCount += 1
                                              APP_DEL.kabaddichoosedAllrounderArray.append(data)
                                          }
                                          if data.role == "Center" {
                                              centerCount += 1
                                              APP_DEL.kabaddiChoosedCenterArray.append(data)
                                          }
                                          if data.role == "Power forward" {
                                              pgCount += 1
                                              APP_DEL.KabaddiChoosedPGArray.append(data)
                                          }
                                          
                                          if let playerCredit = data.credit {
                                              if let pCr = Double(playerCredit) {
                                                  totalcredit -= pCr
                                              }
                                          }
                                        }
                                      }
                                  }
                                  totalPlayer.text = "8"
                                  aCreditValue.text = "\(totalcredit)"
                                  aWkValue.text = "\(wKeeperCount) "
                                  aBatValue.text = "\(batsManCount)"
                                  aAllValue.text = "\(allRounderCount)"
                                  pgValue.text = "\(pgCount)"
                                  centerValue.text = "\(centerCount)"
                                  playerTeamCountSetup()
                              }
                          }
                                           aCreditValue.text = "\(totalcredit)"
                                            aWkValue.text = "\(wKeeperCount) "
                                            aBatValue.text = "\(batsManCount)"
                                            aAllValue.text = "\(allRounderCount)"
                                            pgValue.text = "\(pgCount)"
                                            centerValue.text = "\(centerCount)"
                   totalPlayer.text = "\(APP_DEL.kabbaddiChoosedTeamArray.count)"
                         playerTeamCountSetup()
                          APP_DEL.KabaddiDefender = tempDefenderArray
                          APP_DEL.KabaddiRaiders = tempRaiderArray
                          APP_DEL.kabaddiAllrounder = tempAllrounderArray
                          APP_DEL.KabaddiCenterArray = tempCenterArray
                          APP_DEL.KabaddiPgArray = tempPointGuardArray
                          aPlayerCollectionView.reloadDataInMainQueue()
                          
                      
        }
    fileprivate func setPlayerListData(model: [PlayerListResponses]) {
       
        for data in model {
            if data.role == "Shooting guard" {
                self.tempRaiderArray.append(data)
            }
            if data.role == "Small forward" {
                self.tempDefenderArray.append(data)
            }
            if data.role == "Point guard" {
                self.tempAllrounderArray.append(data)
            }
            if data.role == "Center" {
                self.tempCenterArray.append(data)
            }
            if data.role == "Power forward" {
                self.tempPointGuardArray.append(data)
            }
            
            if arrayOFPlayer.count > 0 {
                APP_DEL.KabaddiExtraPlayer = 0
                for selectedPlayer in arrayOFPlayer {
                    if data.id == selectedPlayer {
                        APP_DEL.kabbaddiChoosedTeamArray.append(data)
                        if data.role == "Small forward" {
                            batsManCount += 1
                            APP_DEL.kabaddichoosedDefenderArray.append(data)
                        }
                        if data.role == "Shooting guard" {
                            allRounderCount += 1
                            APP_DEL.kabaddichossedRaiderArray.append(data)
                        }
                        if data.role == "Point guard" {
                            wKeeperCount += 1
                            APP_DEL.kabaddichoosedAllrounderArray.append(data)
                        }
                        if data.role == "Center" {
                            centerCount += 1
                            APP_DEL.kabaddiChoosedCenterArray.append(data)
                        }
                        if data.role == "Power forward" {
                            pgCount += 1
                            APP_DEL.KabaddiChoosedPGArray.append(data)
                        }
                        
                        if let playerCredit = data.credit {
                            if let pCr = Double(playerCredit) {
                                totalcredit -= pCr
                            }
                        }
                        
                    }
                }
                totalPlayer.text = "8"
                aCreditValue.text = "\(totalcredit)"
                aWkValue.text = "\(wKeeperCount) "
                aBatValue.text = "\(batsManCount)"
                aAllValue.text = "\(allRounderCount)"
                pgValue.text = "\(pgCount)"
                centerValue.text = "\(centerCount)"
                playerTeamCountSetup()
            }
        }
        
        APP_DEL.KabaddiDefender = self.tempDefenderArray
        APP_DEL.KabaddiRaiders = self.tempRaiderArray
        APP_DEL.kabaddiAllrounder = self.tempAllrounderArray
        APP_DEL.KabaddiCenterArray = self.tempCenterArray
        APP_DEL.KabaddiPgArray = self.tempPointGuardArray
        aPlayerCollectionView.reloadDataInMainQueue()
        
    }
    @IBAction func pgAction(_ sender: Any) {
//        arOutlt.provideVisualFeedback(arOutlt)
               aPlayerCollectionView.scrollToItem(at: IndexPath(item: 3, section: 0), at: .centeredHorizontally, animated: true)
               moveSelectionView(index: 3)
               sortingIndex = 3
    }
    @IBAction func centerAction(_ sender: Any) {
        aPlayerCollectionView.scrollToItem(at: IndexPath(item: 4, section: 0), at: .centeredHorizontally, animated: true)
                     moveSelectionView(index: 4)
                     sortingIndex = 4
    }
    
    @IBAction func wkButtonAction(_ sender: Any) {
        arOutlt.provideVisualFeedback(arOutlt)
        aPlayerCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 0)
        sortingIndex = 0
    }
    
    @IBAction func batButtonAction(_ sender: Any) {
        defenderOutlt.provideVisualFeedback(defenderOutlt)
        aPlayerCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 1)
        sortingIndex = 1
    }
    
    @IBAction func allButtonAction(_ sender: Any) {
        raiderrOutlt.provideVisualFeedback(raiderrOutlt)
        aPlayerCollectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 2)
        sortingIndex = 2
    }
    
    fileprivate func moveSelectionView(index: Int) {
        let selectionViewWidth = Int((ScreenSize.SCREEN_WIDTH) / 5)
        switch index {
        case 0:
//            self.aBatLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aBatValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aARLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aAllValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.centerValue.textColor  = UIColor(red: 142, green: 145, blue: 147)
//            self.centerLbl.textColor  = UIColor(red: 142, green: 145, blue: 147)
//            self.pgLbl.textColor  = UIColor(red: 142, green: 145, blue: 147)
//            self.pgValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            self.choosePlayerLbl.text =  "Pick 1-4 POINT-GUARD"
            //            aCategoryInfoLabel.text = "PICK 1 WICKET-KEEPER"
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: 0, y: 28, width: selectionViewWidth, height: 3)
//                self.aWKLabel.textColor = .black
//                self.aWkValue.textColor = .black
            }
        case 1:
//            self.aWKLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aWkValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aARLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aAllValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.centerLbl.textColor = UIColor(red: 142, green: 145, blue: 147)
//                                 self.centerValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//                       self.pgLbl.textColor = UIColor(red: 142, green: 145, blue: 147)
//                                             self.pgValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            self.choosePlayerLbl.text =  "Pick 1-4 SHOOTING-GUARD"
            
            //            aCategoryInfoLabel.text = "PICK 3-5 BATSMAN"
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x:  (5 + (selectionViewWidth * index)), y: 28, width: selectionViewWidth, height: 3)
//                self.aBatLabel.textColor = .black
//                self.aBatValue.textColor = .black
            }
        case 2:
//            self.aWKLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aWkValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aBatLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aBatValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.centerLbl.textColor = UIColor(red: 142, green: 145, blue: 147)
//                      self.centerValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.pgLbl.textColor = UIColor(red: 142, green: 145, blue: 147)
//                                  self.pgValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.choosePlayerLbl.text =  "Pick 1-4 SMALL-FORWORD"//
            //            aCategoryInfoLabel.text = "PICK 1-3 ALL ROUNDER"
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: (0 + (selectionViewWidth * index))  , y: 28, width: selectionViewWidth, height: 3)
//                self.aARLabel.textColor = .black
//                self.aAllValue.textColor = .black
            }
            
        case 3:
//            self.aWKLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aWkValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aBatLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aBatValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aARLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.aAllValue.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.centerLbl.textColor = UIColor(red: 142, green: 145, blue: 147)
//            self.centerValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            self.choosePlayerLbl.text =  "Pick 1-4 POWER-FORWORD"//
            //            aCategoryInfoLabel.text = "PICK 1-3 ALL ROUNDER"
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: (0 + (selectionViewWidth * index))  , y: 28, width: selectionViewWidth, height: 3)
//                self.pgLbl.textColor = .black
//                self.pgValue.textColor = .black
            }
            case 4:

                       self.choosePlayerLbl.text =  "Pick 1-4 CENTERS"//
                       //            aCategoryInfoLabel.text = "PICK 1-3 ALL ROUNDER"
                       UIView.animate(withDuration: 0.2) {
                           self.aSelectionView.frame = CGRect(x: (0 + (selectionViewWidth * index))  , y: 28, width: selectionViewWidth, height: 3)
//                           self.centerLbl.textColor = .black
//                           self.centerValue.textColor = .black
                       }
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        visibleCellIndex = Utility.findCenterCellIndex(collectionView: aPlayerCollectionView)
    }
    
    @IBAction func howtoPlay(_ sender: Any) {
        openViewController(controller: HowToPlayViewController.self, storyBoard: .moreStoryBoard) { (vc) in
              }
    }
    @IBAction func binButton(_ sender: Any) {
        self.removeChangePassView()
        guard let totlpayr = Int(totalPlayer.text ?? "8") else { return}
        if totlpayr > 0 {
            ShowimportantAlert(title: "Alert!", message: "Are you sure you want to clear Selected team??", handlerOK: { action in
                print("Action Called")
                self.totalPlayer.text = "0"
                self.aCreditValue.text = "100.0"
                self.resetAllData()
                self.arrayOFPlayer.removeAll()
                self.Captain = 0
                self.viceCaptian = 0
                self.totalcredit = 100.0
                self.wKeeperCount = 0
                self.allRounderCount = 0
                self.batsManCount = 0
                self.pgCount = 0
                self.centerCount = 0
                 APP_DEL.KabaddiExtraPlayer = 3
                self.getPlayerList(matchKey: self.matchKey)
                self.aFirstTeamValueLabel.text = "0"
                self.aSecondTeamValueLabel.text = "0"
                self.aWkValue.text = "0"
                self.aBatValue.text = "0"
                self.aAllValue.text = "0"
//                self.playerDetail.removeAll()
                self.aPlayerCollectionView.reloadDataInMainQueue()
                self.aCountCollectionView.reloadDataInMainQueue()
                
            }, handlerCancle: {actionCanel in
                print("Action cancel called")
            })
        }
        else {
            
            Loader.showToast(message: "No player Selected to clear", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
        }
    }
    
    @IBAction func creditButtonAction(_ sender: UIButton) {
        aPointsImageView.image = nil
        playerImageView.image = nil
        if sender.isSelected {
            
            aCreditImageView.image = #imageLiteral(resourceName: "up")
            sortingArray(index: sortingIndex ?? 0)
        } else {
            aCreditImageView.image = #imageLiteral(resourceName: "down")
            sortingArray(index: sortingIndex ?? 0)
            
        }
        sender.isSelected = !sender.isSelected
        
    }
    fileprivate func sortingArray(index: Int) {
        
        switch index {
            
        case 0:
            if aCreditImageView.image == #imageLiteral(resourceName: "down") {
                APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                    Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                  Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                  
                }
                APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                    Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                    Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                    
                }

                
            }
            else {
                
                APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                    Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                  Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                  
                }
                APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                    Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                    Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                    
                }
                
                
                
            }
            
        case 1:
            if aCreditImageView.image == #imageLiteral(resourceName: "down") {
               APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                        Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                        
                    }
                    APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                      Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                      
                    }
                    APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                        Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                        
                    }
                    APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                        Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                        
                    }

                    
                }
                else {
                    
                    APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                        Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                        
                    }
                    APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                      Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                      
                    }
                    APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                        Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                        
                    }
                    APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                        Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                        
                    }
                    
                    
                
            }
            
        case 2:
            if aCreditImageView.image == #imageLiteral(resourceName: "up") {
               APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                    Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                  Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                  
                }
                        APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                            Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                            
                        }
                        APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                            Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                            
                        }

                        
                    }
                    else {
                        
                        APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                            Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                            
                        }
                        APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                          Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                          
                        }
                        APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                            Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                            
                        }
                        APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                            Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                            
                        }
                        
                        
                
                
            }
            
            case 3:
                       if aCreditImageView.image == #imageLiteral(resourceName: "up") {
                        APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                                   Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                   
                               }
                               APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                                 Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                                 
                               }
                               APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                                   Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                   
                               }
                               APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                                   Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                   
                               }

                               
                           }
                           else {
                               
                               APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                                   Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                   
                               }
                               APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                                 Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                                 
                               }
                               APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                                   Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                   
                               }
                               APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                                   Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                   
                               }
                               
                               
                           
                           
                       }
            case 4:
                                if aCreditImageView.image == #imageLiteral(resourceName: "up") {
                                  APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                                            Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                            
                                        }
                                        APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                                          Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                                          
                                        }
                                        APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                                            Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                            
                                        }
                                        APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                                            Double($0.credit ?? "0") ?? 0 > Double($1.credit ?? "0") ?? 0
                                            
                                        }

                                        
                                    }
                                    else {
                                        
                                        APP_DEL.kabaddiAllrounder =  APP_DEL.kabaddiAllrounder.sorted {
                                            Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                            
                                        }
                                        APP_DEL.KabaddiDefender =  APP_DEL.KabaddiDefender.sorted {
                                                          Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                                          
                                        }
                                        APP_DEL.KabaddiRaiders =  APP_DEL.KabaddiRaiders.sorted {
                                            Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                            
                                        }
                                        APP_DEL.KabaddiCenterArray =  APP_DEL.KabaddiCenterArray.sorted {
                                            Double($0.credit ?? "0") ?? 0 < Double($1.credit ?? "0") ?? 0
                                            
                                        }
                                        
                                        
                                    
                                    
                                }
            
        default:
            break
        }
        aPlayerCollectionView.reloadDataInMainQueue()
    }
    
    
    @IBAction func pointButtonAction(_ sender: UIButton) {
        aCreditImageView.image  = nil
        playerImageView.image = nil
        if sender.isSelected {
            
            sortingPointArray(index: sortingIndex ?? 0)
            
            aPointsImageView.image = #imageLiteral(resourceName: "up")
        } else {
            sortingPointArray(index: sortingIndex ?? 0)
            aPointsImageView.image = #imageLiteral(resourceName: "down")
        }
        sender.isSelected = !sender.isSelected
        
    }
    
    fileprivate func sortingPointArray(index: Int) {
        
        switch index {
            
        case 0:
            if aPointsImageView.image == #imageLiteral(resourceName: "down") {
                APP_DEL.kabaddiAllrounder =    APP_DEL.kabaddiAllrounder.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                
            }
            else {
                
                APP_DEL.kabaddiAllrounder =    APP_DEL.kabaddiAllrounder.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                
            }
            
        case 1:
            if aPointsImageView.image == #imageLiteral(resourceName: "down") {
                APP_DEL.KabaddiDefender =    APP_DEL.KabaddiDefender.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                
                
            }
            else {
                
                
                APP_DEL.KabaddiDefender =    APP_DEL.KabaddiDefender.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                
                
            }
            
        case 2:
            if aPointsImageView.image == #imageLiteral(resourceName: "up") {
                APP_DEL.KabaddiRaiders =    APP_DEL.KabaddiRaiders.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                
            }
            else {
                
                APP_DEL.KabaddiRaiders =    APP_DEL.KabaddiRaiders.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                
            }
            case 3:
                       if aPointsImageView.image == #imageLiteral(resourceName: "up") {
                           APP_DEL.KabaddiPgArray =    APP_DEL.KabaddiPgArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                           
                       }
                       else {
                           
                           APP_DEL.KabaddiPgArray =    APP_DEL.KabaddiPgArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                           
                       }
            case 4:
                                 if aPointsImageView.image == #imageLiteral(resourceName: "up") {
                                     APP_DEL.KabaddiCenterArray =    APP_DEL.KabaddiCenterArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                                     
                                 }
                                 else {
                                     
                                     APP_DEL.KabaddiCenterArray =    APP_DEL.KabaddiCenterArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                                     
                                 }
            
        default:
            break
        }
        aPlayerCollectionView.reloadDataInMainQueue()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
//        if aWkValue.text == "0" {
//
//            Loader.showToast(message: "Please choose minimum 1 All-Rounder", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
//            return
//        }
//        if aBatValue.text == "0" {
//            Loader.showToast(message: "Please choose minimum 1 DEFENDER", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
//
//
//            return
//        }
//        if aAllValue.text == "0" {
//            Loader.showToast(message: "Please choose minimum 1 RAIDER", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
//
//            return
//        }
//        if totalPlayer.text != 8 {
//             Loader.showToast(message: "Please choose minimum 1 RAIDER", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
//            //
//                        return
//        }
        self.removeChangePassView()
        if APP_DEL.kabbaddiChoosedTeamArray.count == 8 {
            openViewController(controller: BasketBallCaptainViewViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                vc.teamArray = APP_DEL.kabbaddiChoosedTeamArray
                vc.contestData = self.contestData
                vc.teamNumber = self.teamNumber
                vc.delegate = self
                vc.matchType = "BASKETBALL"
                vc.comingfromEditVc = self.fromEditVC
                vc.delegate = self
                vc.c = self.Captain
                vc.teamidforupdate = "\(self.teamId)"
                vc.v = self.viceCaptian
                vc.fromSelectionVc = self.fromTeamSelection
                
            }
        }
        else {
            
            Loader.showToast(message: "Please select 8 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
        }
        
        
    }
    
    
    
    func playerTeamCountSetup() {
        var tempFirstTotalPlayerCount = 0
        var tempSecondTotalPlayerCount = 0
        let players = APP_DEL.kabbaddiChoosedTeamArray
        if players.count == 0 {
            tempFirstTotalPlayerCount = 0
            tempSecondTotalPlayerCount = 0
        }
        for player in players {
            guard let platerTeam = player.team else {
                return
            }
            if (platerTeam == "team1") {
                tempFirstTotalPlayerCount += 1
            } else if (platerTeam == "team2") {
                tempSecondTotalPlayerCount += 1
            }
        }
        
        aFirstTeamValueLabel.text = "(\(tempFirstTotalPlayerCount))"
        aSecondTeamValueLabel.text = "(\(tempSecondTotalPlayerCount))"
        //    totalPlayer.text = "\(tempSecondTotalPlayerCount + tempSecondTotalPlayerCount)"
        
    }
    func playerTeamCountSeven(player: PlayerListResponses) -> Bool {
        var tempFirstTotalPlayerCount = 0
        var tempSecondTotalPlayerCount = 0
        let players = APP_DEL.kabbaddiChoosedTeamArray
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
            if tempFirstTotalPlayerCount  == 5 {
                return true
            } else {
                return false
            }
        } else {
            if tempSecondTotalPlayerCount  == 5 {
                return true
            } else {
                return false
            }
        }
    }
    
    @IBAction func openSelectionView(_ sender: Any) {
        openChangePasswordView()
    }
    fileprivate func openChangePasswordView() {
        if ruleView == nil {
            ruleView = Bundle.main.loadNibNamed("SelectionRuleForKabaddi", owner: self, options: nil)?.first as? SelectionRuleForKabaddi
//              ruleView?.frame = CGRect(x:   ScreenSize.SCREEN_WIDTH/2 - self.view.frame.width * 0.9 / 2 , y:  ScreenSize.SCREEN_HEIGHT/2 - self.view.frame.height * 0.42 / 2, width:  self.view.frame.width * 0.9, height: self.view.frame.height * 0.42)
            ruleView?.center = self.view.center
            ruleView?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.removeChangePassView()
                }
            }
            APP_DEL.window?.addSubview(ruleView!)
        }
    }
    fileprivate func removeChangePassView() {
        ruleView?.removeFromSuperview()
        ruleView = nil
    }
    
    
}

extension KABADDITeamViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == aPlayerCollectionView {
            return 5
        } else {
            return playerCountArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == aPlayerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KabaddiCollectionViewCell.identifier(), for: indexPath) as! KabaddiCollectionViewCell
            cell.delgate = self
            cell.firstTeamName = firstTeamName
            cell.secondTeamName = secondTeamName
            cell.playerDataIndex = indexPath.item
            cell.firstTeamName = firstTeamName
            cell.secondTeamName = secondTeamName
            cell.allSelectionTotal = allRounderCount
            cell.batSelectionTotal = batsManCount
            cell.wkSelectionTotal = wKeeperCount
            cell.pgSelectionTotal = pgCount
            cell.centerSelectionTotal  = centerCount
            cell.playerDataIndex = indexPath.item
            cell.wkSelectionClouser = {[weak self] val in
                if let strongSelf = self {
                    let wkVal =  String(val)
                    strongSelf.aWkValue.text = "\(wkVal)"
                    self?.wKeeperCount = Int(wkVal) ?? 0
                    strongSelf.aCountCollectionView.reloadDataInMainQueue()
                }
            }
            cell.batSelectionClouser = {[weak self] val in
                if let strongSelf = self {
                    let batVal =  String(val)
                    strongSelf.aBatValue.text = "\(batVal)"
                    self?.batsManCount = Int(batVal) ?? 0
                    strongSelf.aCountCollectionView.reloadDataInMainQueue()
                }
            }
            cell.allSelectionClouser = {[weak self] val in
                if let strongSelf = self {
                    let arVal =  String(val)
                    strongSelf.aAllValue.text = "\(arVal)"
                    self?.allRounderCount = Int(arVal) ?? 0
                    strongSelf.aCountCollectionView.reloadDataInMainQueue()
                }
            }
            cell.pgSelectionCloasure = {[weak self] val in
                if let strongSelf = self {
                    let batVal =  String(val)
                    strongSelf.pgValue.text = "\(batVal)"
                    self?.pgCount = Int(batVal) ?? 0
                    strongSelf.aCountCollectionView.reloadDataInMainQueue()
                }
            }
            cell.centerClosure = {[weak self] val in
                           if let strongSelf = self {
                               let batVal =  String(val)
                               strongSelf.centerValue.text = "\(batVal)"
                               self?.centerCount = Int(batVal) ?? 0
                               strongSelf.aCountCollectionView.reloadDataInMainQueue()
                           }
                       }
            cell.playerCountClouser = {[weak self] val in
                if let strongSElf = self {
                    let totalcount = val
                    strongSElf.totalPlayer.text = String(totalcount)
                }
                
            }
            cell.playerCreditClouser = {[weak self] val in
                if let strongSelf = self {
                    let remainingCredit = 100.0 - val
                    strongSelf.totalcredit = Double(remainingCredit)
                    strongSelf.aCreditValue.text = String(remainingCredit)
                }
            }
            cell.playerChoosedClouser = {[weak self]  in
                if let strongSelf = self {
                    strongSelf.playerTeamCountSetup()
                }
            }
            return cell
        }
            
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KabaddiTeamCountCollectionViewCell.identifier(), for: indexPath) as! KabaddiTeamCountCollectionViewCell
            cell.configureCell(index: indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == aPlayerCollectionView {
            return CGSize(width: aPlayerCollectionView.frame.width, height: aPlayerCollectionView.frame.height)
        } else {
            if DeviceType.IS_IPHONE_5 {
                return CGSize(width: ScreenSize.SCREEN_WIDTH / 15.5, height: ScreenSize.SCREEN_WIDTH / 16)
            } else if DeviceType.IS_IPHONE_X_OR_GREATER {
                return CGSize(width: ScreenSize.SCREEN_WIDTH / 14.5, height: ScreenSize.SCREEN_WIDTH / 14)
            } else {
                return CGSize(width: ScreenSize.SCREEN_WIDTH / 13.5, height: ScreenSize.SCREEN_WIDTH / 14.5)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        //Where elements_count is the count of all your items in that
        //Collection view...
        if collectionView == aCountCollectionView {
            let cellCount = CGFloat(playerCountArray.count)
            
            //If the cell count is zero, there is no point in calculating anything.
            if cellCount > 0 {
                let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
                let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
                
                //20.00 was just extra spacing I wanted to add to my cell.
                let totalCellWidth = cellWidth*cellCount + 20.00 * (cellCount-1)
                let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
                
                if (totalCellWidth < contentWidth) {
                    //If the number of cells that exists take up less room than the
                    //collection view width... then there is an actual point to centering them.
                    
                    //Calculate the right amount of padding to center the cells.
                    let padding = (contentWidth - totalCellWidth) / 2.0
                    return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
                } else {
                    //Pretty much if the number of cells that exist take up
                    //more room than the actual collectionView width, there is no
                    // point in trying to center them. So we leave the default behavior.
                    return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
                }
            }
            return UIEdgeInsets.zero
        }
        return .zero
    }
}

extension KABADDITeamViewController:openPlayerStatisticProfileKabaddi {
    func sendDatatoMainVc(player: PlayerListResponses) {
        openPlayerInfoVC(id: player)
    }
    
    
    
    //    func sendDatatoMainVc(player: ) {
    //
    //    }
    func minimumPlayerWarning() {
        if (APP_DEL.kabaddichoosedAllrounderArray.count < 1) {
                                   Loader.showToast(message:"You must select at least 1 Point-Guard.", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))

                                } else if (APP_DEL.kabaddichoosedDefenderArray.count < 1) {
                      Loader.showToast(message: "You must select at least 1 Shooting-Guard.", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                                   
                                } else if (APP_DEL.kabaddichossedRaiderArray.count < 1) {
                      Loader.showToast(message: "You must select at least 1 Small-Forword.", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                                  
                                }
                              else if APP_DEL.KabaddiChoosedPGArray.count < 1 {
                               Loader.showToast(message: "You must select at least 1 Power-Forword.", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                   }
                              else if APP_DEL.kabaddiChoosedCenterArray.count < 1 {
            Loader.showToast(message: "You must select at least 1 Centre.", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                   }
                            
    }
    
    func sendPlayerInfotoRemove(playerid: PlayerListResponses) {
        APP_DEL.kabbaddiChoosedTeamArray = APP_DEL.kabbaddiChoosedTeamArray.filter({ $0.id != playerid.id})
        if playerid.role == "Small forward" {
            if  (APP_DEL.kabaddichoosedDefenderArray.count > APP_DEL.minKabaddiDef) {
                APP_DEL.KabaddiExtraPlayer =  APP_DEL.KabaddiExtraPlayer + 1
            }
            
          
            aBatValue.text = "\(batsManCount)"
            self.batsManCount -= 1
            APP_DEL.kabaddichoosedDefenderArray = APP_DEL.kabaddichoosedDefenderArray.filter({ $0.id != playerid.id})
            if let playerCredit = playerid.credit {
                if let pCr = Double(playerCredit) {
                    totalcredit += pCr
                }
            }
            let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
            guard let convert = Int(trimmedString ?? "0") else { return  }
            let playerData = convert - 1
            self.totalPlayer.text = "\(playerData)"
            self.aCreditValue.text = "\(totalcredit)"
            playerTeamCountSetup()
            aCountCollectionView.reloadDataInMainQueue()
            aPlayerCollectionView.reloadDataInMainQueue()
            
        }
        
        if playerid.role == "Shooting guard" {
            if  (APP_DEL.kabaddichossedRaiderArray.count > APP_DEL.minRaid) {
                APP_DEL.KabaddiExtraPlayer =  APP_DEL.KabaddiExtraPlayer + 1
            }
           
            aAllValue.text = "\(allRounderCount) "
             self.allRounderCount -= 1
            //  APP_DEL.chossedAllMansArray.append(playerid)
            APP_DEL.kabaddichossedRaiderArray = APP_DEL.kabaddichossedRaiderArray.filter({ $0.id != playerid.id})
            if let playerCredit = playerid.credit {
                if let pCr = Double(playerCredit) {
                    totalcredit += pCr
                }
            }
            let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
            guard let convert = Int(trimmedString ?? "0") else { return  }
            let playerData = convert - 1
            self.totalPlayer.text = "\(playerData)"
            self.aCreditValue.text = "\(totalcredit)"
            playerTeamCountSetup()
            aCountCollectionView.reloadDataInMainQueue()
            aPlayerCollectionView.reloadDataInMainQueue()
            
            
            
        }
        
        if playerid.role == "Point guard" {
            if  (APP_DEL.kabaddichoosedAllrounderArray.count > APP_DEL.minAR) {
                APP_DEL.KabaddiExtraPlayer =  APP_DEL.KabaddiExtraPlayer + 1
            }
            
            self.wKeeperCount -= 1
            aWkValue.text = "\(wKeeperCount) "
            APP_DEL.kabaddichoosedAllrounderArray = APP_DEL.kabaddichoosedAllrounderArray.filter({ $0.name != playerid.name})
            if let playerCredit = playerid.credit {
                if let pCr = Double(playerCredit) {
                    totalcredit += pCr
                }
            }
            let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
            guard let convert = Int(trimmedString ?? "0") else { return  }
            let playerData = convert - 1
            self.totalPlayer.text = "\(playerData)"
            self.aCreditValue.text = "\(totalcredit)"
            playerTeamCountSetup()
            aCountCollectionView.reloadDataInMainQueue()
            aPlayerCollectionView.reloadDataInMainQueue()
            
            
        }
        
        if playerid.role == "Center" {
            if  (APP_DEL.kabaddiChoosedCenterArray.count > APP_DEL.minAR) {
                APP_DEL.KabaddiExtraPlayer =  APP_DEL.KabaddiExtraPlayer + 1
            }
             self.centerCount -= 1
            centerValue.text = "\(centerCount) "
           
            APP_DEL.kabaddiChoosedCenterArray = APP_DEL.kabaddiChoosedCenterArray.filter({ $0.name != playerid.name})
            if let playerCredit = playerid.credit {
                if let pCr = Double(playerCredit) {
                    totalcredit += pCr
                }
            }
            let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
            guard let convert = Int(trimmedString ?? "0") else { return  }
            let playerData = convert - 1
            self.totalPlayer.text = "\(playerData)"
            self.aCreditValue.text = "\(totalcredit)"
            playerTeamCountSetup()
            aCountCollectionView.reloadDataInMainQueue()
            aPlayerCollectionView.reloadDataInMainQueue()
            
            
        }
        
        if playerid.role == "Power forward" {
                   if  (APP_DEL.KabaddiChoosedPGArray.count > APP_DEL.minAR) {
                       APP_DEL.KabaddiExtraPlayer =  APP_DEL.KabaddiExtraPlayer + 1
                   }
                    self.pgCount -= 1
                   pgValue.text = "\(pgCount) "
                  
                   APP_DEL.KabaddiChoosedPGArray = APP_DEL.KabaddiChoosedPGArray.filter({ $0.name != playerid.name})
                   if let playerCredit = playerid.credit {
                       if let pCr = Double(playerCredit) {
                           totalcredit += pCr
                       }
                   }
                   let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
                   guard let convert = Int(trimmedString ?? "0") else { return  }
                   let playerData = convert - 1
                   self.totalPlayer.text = "\(playerData)"
                   self.aCreditValue.text = "\(totalcredit)"
                   playerTeamCountSetup()
                   aCountCollectionView.reloadDataInMainQueue()
                   aPlayerCollectionView.reloadDataInMainQueue()
                 
               }
        
    }
    func checkCreaditLimitExceed(sPlayer: PlayerListResponses) -> Bool {
        var currentCredit = 0.0
        let players = APP_DEL.kabbaddiChoosedTeamArray
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
    
    
    func sendPlayaerInfo(playerid: PlayerListResponses) {
        if playerid.role == "Small forward" {
            
            if APP_DEL.kabbaddiChoosedTeamArray.count == 8 {
                
                Loader.showToast(message: "You can choose maximum 8 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                
            } else {
                if playerTeamCountSeven(player: playerid) {
                    
                    Loader.showToast(message: "You can select only 5 from  each team", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
                } else {
                    if checkCreaditLimitExceed(sPlayer: playerid) {
                        
                        Loader.showToast(message: "Only \(remainingCr) credit left", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                        
                    }
                    else {
                        if APP_DEL.kabaddichoosedDefenderArray.count != 4 {
                            if APP_DEL.kabaddichoosedDefenderArray.count < APP_DEL.minKabaddiDef || APP_DEL.KabaddiExtraPlayer > 0 {
                                if APP_DEL.kabaddichoosedDefenderArray.count >= APP_DEL.minKabaddiDef {
                                    APP_DEL.KabaddiExtraPlayer = APP_DEL.KabaddiExtraPlayer - 1
                                }
                                self.batsManCount += 1
                                APP_DEL.kabbaddiChoosedTeamArray.append(playerid)
                                aBatValue.text = "\(batsManCount)"
                                
                                APP_DEL.kabaddichoosedDefenderArray.append(playerid)
                                if let playerCredit = playerid.credit {
                                    if let pCr = Double(playerCredit) {
                                        totalcredit -= pCr
                                    }
                                }
                                let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
                                guard let convert = Int(trimmedString ?? "0") else { return  }
                                let playerData = convert + 1
                                self.totalPlayer.text = "\(playerData)"
                                self.aCreditValue.text = "\(totalcredit)"
                                playerTeamCountSetup()
                                aCountCollectionView.reloadDataInMainQueue()
                                aPlayerCollectionView.reloadDataInMainQueue()
                            }
                            else {
                                minimumPlayerWarning()
                            }
                        }
                        else {
                            
                            Loader.showToast(message: "You can Select only 4 Point-Guard", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        }
                    }
                }
                
            }
        }
     
        if playerid.role == "Shooting guard" {
            
            if APP_DEL.kabbaddiChoosedTeamArray.count == 8 {
                
                Loader.showToast(message: "You can select maximum 7 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                
            }
            else {
                if playerTeamCountSeven(player: playerid) {
                    
                    Loader.showToast(message: "You can select only 4 from a each team", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                } else {
                    if checkCreaditLimitExceed(sPlayer: playerid) {
                        if DeviceType.IS_IPHONE_X_OR_GREATER {
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        }
                        else {
                            Loader.showToast(message: "Only \(remainingCr) credit left", onView: self.view, bottomMargin: 0 , color: UIColor(red: 240, green: 75, blue: 80))
                        }
                        
                    }
                    else {
                        if APP_DEL.kabaddichossedRaiderArray.count != 4 {
                            if APP_DEL.kabaddichossedRaiderArray.count < APP_DEL.minRaid || APP_DEL.KabaddiExtraPlayer > 0 {
                                if APP_DEL.kabaddichossedRaiderArray.count >= APP_DEL.minRaid {
                                    APP_DEL.KabaddiExtraPlayer = APP_DEL.KabaddiExtraPlayer - 1
                                }
                                APP_DEL.kabbaddiChoosedTeamArray.append(playerid)
                                self.allRounderCount += 1
                                aAllValue.text = "\(allRounderCount) "
                                APP_DEL.chossedAllMansArray.append(playerid)
                                if let playerCredit = playerid.credit {
                                    if let pCr = Double(playerCredit) {
                                        totalcredit -= pCr
                                    }
                                }
                                let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
                                guard let convert = Int(trimmedString ?? "0") else { return  }
                                let playerData = convert + 1
                                self.totalPlayer.text = "\(playerData)"
                                self.aCreditValue.text = "\(totalcredit)"
                                playerTeamCountSetup()
                                aCountCollectionView.reloadDataInMainQueue()
                                aPlayerCollectionView.reloadDataInMainQueue()
                            }
                            else {
                                minimumPlayerWarning()
                            }
                        }
                        else {
                            
                            Loader.showToast(message: "You can Select only 4 Small-Forword", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        }
                    }
                }
            }
        }
        
        if playerid.role == "Point guard" {
            
            if APP_DEL.kabbaddiChoosedTeamArray.count == 8 {
                
                Loader.showToast(message: "You can select maximum 8 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                
            }
            else {
                if playerTeamCountSeven(player: playerid) {
                    
                    Loader.showToast(message: "You can Select only 5 players from each team", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
                } else {
                    if checkCreaditLimitExceed(sPlayer: playerid) {
                        
                        Loader.showToast(message: "Only \(remainingCr) credit left", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                        
                    }
                        
                    else {
                        if APP_DEL.kabaddichoosedAllrounderArray.count != 4 {
                            if APP_DEL.kabaddichoosedAllrounderArray.count < APP_DEL.minAR || APP_DEL.KabaddiExtraPlayer > 0 {
                                if APP_DEL.kabaddichoosedAllrounderArray.count >= APP_DEL.minAR {
                                    APP_DEL.KabaddiExtraPlayer = APP_DEL.KabaddiExtraPlayer - 1
                                }
                                APP_DEL.kabbaddiChoosedTeamArray.append(playerid)
                               
                                self.wKeeperCount += 1
                                 aWkValue.text = "\(wKeeperCount) "
                                APP_DEL.kabaddichoosedAllrounderArray.append(playerid)
                                
                                if let playerCredit = playerid.credit {
                                    if let pCr = Double(playerCredit) {
                                        totalcredit -= pCr
                                    }
                                }
                                let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
                                guard let convert = Int(trimmedString ?? "0") else { return  }
                                let playerData = convert + 1
                                self.totalPlayer.text = "\(playerData)"
                                self.aCreditValue.text = "\(totalcredit)"
                                playerTeamCountSetup()
                                aCountCollectionView.reloadDataInMainQueue()
                                aPlayerCollectionView.reloadDataInMainQueue()
                            }
                            else {
                                minimumPlayerWarning()
                            }
                        }
                        else {
                            
                            Loader.showToast(message: "You can Select only 4 Point-forword", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        }
                    }
                }
            }
        }
        if playerid.role == "Center" {
            
            if APP_DEL.kabbaddiChoosedTeamArray.count == 8 {
                
                Loader.showToast(message: "You can select maximum 8 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                
            }
            else {
                if playerTeamCountSeven(player: playerid) {
                    
                    Loader.showToast(message: "You can Select only 5 players from each team", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
                } else {
                    if checkCreaditLimitExceed(sPlayer: playerid) {
                        
                        Loader.showToast(message: "Only \(remainingCr) credit left", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                        
                    }
                        
                    else {
                        if APP_DEL.kabaddiChoosedCenterArray.count != 4 {
                            if APP_DEL.kabaddiChoosedCenterArray.count < APP_DEL.minAR || APP_DEL.KabaddiExtraPlayer > 0 {
                                if APP_DEL.kabaddiChoosedCenterArray.count >= APP_DEL.minAR {
                                    APP_DEL.KabaddiExtraPlayer = APP_DEL.KabaddiExtraPlayer - 1
                                }
                                APP_DEL.kabbaddiChoosedTeamArray.append(playerid)
                                     self.centerCount += 1
                                centerValue.text = "\(centerCount) "
                               
                                APP_DEL.kabaddiChoosedCenterArray.append(playerid)
                                
                                if let playerCredit = playerid.credit {
                                    if let pCr = Double(playerCredit) {
                                        totalcredit -= pCr
                                    }
                                }
                                let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
                                guard let convert = Int(trimmedString ?? "0") else { return  }
                                let playerData = convert + 1
                                self.totalPlayer.text = "\(playerData)"
                                self.aCreditValue.text = "\(totalcredit)"
                                playerTeamCountSetup()
                                aCountCollectionView.reloadDataInMainQueue()
                                aPlayerCollectionView.reloadDataInMainQueue()
                            }
                            else {
                                minimumPlayerWarning()
                            }
                        }
                        else {
                            
                            Loader.showToast(message: "You can Select only 4 Centre", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        }
                    }
                }
            }
        }
        
        if playerid.role == "Power forward" {
                  
                  if APP_DEL.kabbaddiChoosedTeamArray.count == 8 {
                      
                      Loader.showToast(message: "You can select maximum 8 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                      
                  }
                  else {
                      if playerTeamCountSeven(player: playerid) {
                          
                          Loader.showToast(message: "You can Select only 5 players from each team", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                          
                          
                      } else {
                          if checkCreaditLimitExceed(sPlayer: playerid) {
                              
                              Loader.showToast(message: "Only \(remainingCr) credit left", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                              
                              
                          }
                              
                          else {
                              if APP_DEL.KabaddiChoosedPGArray.count != 4 {
                                  if APP_DEL.KabaddiChoosedPGArray.count < APP_DEL.minAR || APP_DEL.KabaddiExtraPlayer > 0 {
                                      if APP_DEL.KabaddiChoosedPGArray.count >= APP_DEL.minAR {
                                          APP_DEL.KabaddiExtraPlayer = APP_DEL.KabaddiExtraPlayer - 1
                                      }
                                      APP_DEL.kabbaddiChoosedTeamArray.append(playerid)
                                           self.pgCount += 1
                                      pgValue.text = "\(pgCount) "
                                     
                                      APP_DEL.KabaddiChoosedPGArray.append(playerid)
                                      
                                      if let playerCredit = playerid.credit {
                                          if let pCr = Double(playerCredit) {
                                              totalcredit -= pCr
                                          }
                                      }
                                      let trimmedString = totalPlayer.text?.trimmingCharacters(in: .whitespaces)
                                      guard let convert = Int(trimmedString ?? "0") else { return  }
                                      let playerData = convert + 1
                                      self.totalPlayer.text = "\(playerData)"
                                      self.aCreditValue.text = "\(totalcredit)"
                                      playerTeamCountSetup()
                                      aCountCollectionView.reloadDataInMainQueue()
                                      aPlayerCollectionView.reloadDataInMainQueue()
                                  }
                                  else {
                                      minimumPlayerWarning()
                                  }
                              }
                              else {
                                  
                                  Loader.showToast(message: "You can Select only 4 Power-Forword", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                                  
                              }
                          }
                      }
                  }
              }
    }
    func openPlayerInfoVC(id: PlayerListResponses) {
        openViewController(controller: PlayerStaticsViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            //            vc.teamId = self.teamId
            vc.matchKey = self.matchKey
            vc.playerData = id
            vc.delegate = self
            for i in APP_DEL.kabbaddiChoosedTeamArray {
                if i.id == id.id {
                    vc.isPlayerAdeed = false
                    return
                }
                
            }
            vc.isPlayerAdeed = true
        }
    }
}


extension KABADDITeamViewController:fromPlayerProfile,checkFromCaptain,KabaddiPreview {
    func checkFrom(check: Bool) {
        fromPreview = check
    }
    
    
    
    func comingFromCaptain(check: Bool) {
        self.fromPreview = check
    }
    
    func backToTeam(check: Bool) {
        self.fromPreview = check
    }
}
