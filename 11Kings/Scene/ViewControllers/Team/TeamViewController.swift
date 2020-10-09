//
//  TeamViewController.swift
//  Club11
//
//  Created by Developer on 27/05/19.
//

import UIKit
import Alamofire
import SwiftyJSON
protocol deleteAllDaata {
    func removeAllDataFromArray()
}
class TeamViewController: BaseClass {
    

    var fromTeamSelection = false
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var aPlayerCountContainerView: UIView!
    @IBOutlet weak var totalPlayer: UILabel!
    @IBOutlet weak var aMatchDetailContainerView: UIView!
    @IBOutlet weak var aCountContainerView: UIView!
    @IBOutlet weak var aWKLabel: UILabel!
    @IBOutlet weak var aBowlLabel: UILabel!
    @IBOutlet weak var aBatLabel: UILabel!
    @IBOutlet weak var aARLabel: UILabel!
    @IBOutlet weak var aPlayerCollectionView: UICollectionView!
    @IBOutlet weak var aCountCollectionView: UICollectionView!
    @IBOutlet weak var aFirstTeamImageView: UIImageView!
    @IBOutlet weak var wkButtonOutltl: UIButton!
    @IBOutlet weak var aSecondTeamImageView: UIImageView!
    @IBOutlet weak var aFirstTeamNameLabel: UILabel!
    @IBOutlet weak var aSecondTeamNameLabel: UILabel!
    @IBOutlet weak var aFirstTeamValueLabel: UILabel!
    @IBOutlet weak var aSecondTeamValueLabel: UILabel!
    @IBOutlet weak var aSelectionView: UIView!
    @IBOutlet weak var aCreditValue: UILabel!
    @IBOutlet weak var aBowlValue: UILabel!
    @IBOutlet weak var aAllValue: UILabel!
    @IBOutlet weak var aBatValue: UILabel!
    @IBOutlet weak var aWkValue: UILabel!
    @IBOutlet weak var aNextButton: UIButton!
    @IBOutlet weak var aCreditImageView: UIImageView!
    @IBOutlet weak var aPointsImageView: UIImageView!
    
    @IBOutlet weak var batButtonOutlt: UIButton!
    @IBOutlet weak var choosePlayerLbl: UILabel!
    @IBOutlet weak var bowlButtonOutlt: UIButton!
    @IBOutlet weak var allrounderBtnOutlt: UIButton!
    
    var createTeam: (() -> Void) = { }
    var delegate:deleteAllDaata?
    var ruleView:SelectionRuleUI?
    var playerView:PlayerStatusView?
    var changePasswordView: ChangePasswordView?
    var playerId:Int?
    var remainingCr = 0.0
    var isFromEdit = false
    var fromPreview = false
    var sortingIndex:Int?
    var firstTeamName = ""
    var secondTeamName = ""
    var allRounderCount = 0
    var batsManCount = 0
    var bowlerCount = 0
    var wKeeperCount = 0
    var totalcredit = 100.0
    var teamNumber = ""
    var playerCountArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    var totalSelectedArray:String?
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var contestData: GetMatchDetails?
    var contestLiveData:MyContestLiveLeagues?
    var tempBowlerArray = [PlayerListResponses]()
    var tempBatsmenrArray = [PlayerListResponses]()
    var tempAllrounderArray = [PlayerListResponses]()
    var tempkeeperArray = [PlayerListResponses]()
    var viceCaptainID = 0
    var captainID = 0
    var teamID = 0
    var arrayOfPlayer = [Int]()
    var playerDetail = [PlayerListResponses]()
  
    var matchKey = "" {
        didSet {
         
        }
    }
    
   
    var visibleCellIndex = 0 {
        didSet {
            moveSelectionView(index: visibleCellIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetAllData()
        
    }
    
    func registerCell() {
        aCountCollectionView.register(UINib(nibName: TeamCountCVCell.identifier(), bundle: nil), forCellWithReuseIdentifier: TeamCountCVCell.identifier())
        aPlayerCollectionView.register(UINib(nibName: TeamCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: TeamCollectionViewCell.identifier())
    }
    
    func setupUI() {
        choosePlayerLbl.text   =  "Pick 1 WICKET-KEEPERS"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerStatusView.isHidden = true
      
        registerCell()
        setContestData()
        
        if !fromPreview {
              setupUI()
            APP_DEL.extraPlayer = 4
            APP_DEL.maxWk = 2
            APP_DEL.maxBat = 6
            APP_DEL.maxAll = 6
            APP_DEL.maxBall = 6
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
    
    
    @IBAction func binButton(_ sender: Any) {
        self.removeChangePassView()
        guard let totlpayr = Int(totalPlayer.text ?? "12") else { return}
        if totlpayr > 0 {
            ShowimportantAlert(title: "Alert!", message: "Are you sure you want to clear Selected team??", handlerOK: { action in
                print("Action Called")
                self.totalPlayer.text = "0"
                self.aCreditValue.text = "100"
                self.resetAllData()
                self.arrayOfPlayer.removeAll()
                self.wKeeperCount = 0
                self.allRounderCount = 0
                self.batsManCount = 0
                self.bowlerCount = 0
                self.wKeeperCount = 0
                self.totalcredit = 100.0
                APP_DEL.extraPlayer = 4
                self.captainID = 0
                self.viceCaptainID = 0
                self.getPlayerList(matchKey: self.matchKey)
                self.aFirstTeamValueLabel.text = "0"
                self.aSecondTeamValueLabel.text = "0"
                self.aWkValue.text = "0"
                self.aBatValue.text = "0"
                self.aAllValue.text = "0"
                self.aBowlValue.text = "0"
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
    @IBAction func howToPlay(_ sender: Any) {
        openViewController(controller: HowToPlayViewController.self, storyBoard: .moreStoryBoard) { (vc) in
        }
    }
 
    fileprivate func resetAllData() {
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
        APP_DEL.editBatMansArray.removeAll()
        APP_DEL.editBowlMansArray.removeAll()
        APP_DEL.editAllMansArray.removeAll()
        APP_DEL.editWkMansArray.removeAll()
        APP_DEL.editChoosedTeamArray.removeAll()
        APP_DEL.choosedBatMansArray.removeAll()
        APP_DEL.choosedBowlMansArray.removeAll()
        APP_DEL.chossedAllMansArray.removeAll()
        APP_DEL.choosedWkMansArray.removeAll()
         tempBowlerArray.removeAll()
         tempBatsmenrArray.removeAll()
         tempAllrounderArray.removeAll()
         tempkeeperArray.removeAll()
    }
    
    fileprivate func setContestData() {
        if let contest = contestData  {
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
            
            
            setReleaseTime(releaseDateString: contest.time_start ?? "0")
            
        }
        if let contest = contestLiveData  {
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
            
            
            setReleaseTime(releaseDateString: contest.time_start ?? "0")
        }
        
    }
    
    fileprivate func setReleaseTime(releaseDateString: String) {
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @IBAction func teamPreviewVC(_ sender: Any) {
        print(APP_DEL.choosedTeamArray)
        previewAction()
    }
    
    func previewAction() {
        openViewController(controller: PreviewViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            //            vc.teamId = teamID
            vc.contestData = self.contestData
            vc.isFromCreateTEam = true
            vc.delegate = self
            vc.cId = self.captainID
            vc.vcID = self.viceCaptainID
            vc.captainID = "\(self.captainID)"
            vc.viceCaptianID = "\(self.viceCaptainID)"
            // vc.selectedIndex = index
        }
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
        
        
        
        let param = [
            "matchkey": matchKey,
            "sport_key":"CRICKET"
        ]
        NetworkManager.post_Request(urlService: kPlayerListURL, param: param, head: headers)
        { (response) in
            
            
            self.hideActivityIndicator()
            
            
            do{
                let json = try JSON(data:response as? Data ?? Data())
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
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    
    fileprivate func setPlayerListData(model: [PlayerListResponses]) {
        
        self.totalPlayer.text = "0"
        self.aCreditValue.text = "100"
        bowlerCount = 0
        batsManCount = 0
        allRounderCount = 0
        wKeeperCount = 0
        playerTeamCountSetup()
        totalcredit = 100
        for data in model {
            if data.role == "bowler" {
                tempBowlerArray.append(data)
            }
            if data.role == "batsman" {
                tempBatsmenrArray.append(data)
            }
            if data.role == "allrounder" {
                tempAllrounderArray.append(data)
            }
            if data.role == "keeper" {
                tempkeeperArray.append(data)
            }
            if arrayOfPlayer.count > 0 {
                APP_DEL.extraPlayer = 0
                
                for selectedPlayer in arrayOfPlayer {
                    //                    APP_DEL.choosedTeamArray.removeAll()
                    if data.id == selectedPlayer {
                        
                        APP_DEL.choosedTeamArray.append(data)
                        
                        if data.role == "bowler" {
                            bowlerCount += 1
                            
                            APP_DEL.choosedBowlMansArray.append(data)
                        }
                        if data.role == "batsman" {
                            batsManCount += 1
                            APP_DEL.choosedBatMansArray.append(data)
                        }
                        if data.role == "allrounder" {
                            allRounderCount += 1
                            APP_DEL.chossedAllMansArray.append(data)
                        }
                        if data.role == "keeper" {
                            wKeeperCount += 1
                            APP_DEL.choosedWkMansArray.append(data)
                        }
                        if let playerCredit = data.credit {
                            if let pCr = Double(playerCredit) {
                                totalcredit -= pCr
                            }
                        }
                        
                    }
                    
                }
                aCreditValue.text = "\(totalcredit)"
                aWkValue.text = "\(wKeeperCount) "
                aBatValue.text = "\(batsManCount)"
                aAllValue.text = "\(allRounderCount) "
                aBowlValue.text = "\(bowlerCount)"
                totalPlayer.text = "11"
                playerTeamCountSetup()
            }
        }
        APP_DEL.batMansArray = tempBatsmenrArray
        APP_DEL.bowlMansArray = tempBowlerArray
        APP_DEL.allMansArray = tempAllrounderArray
        APP_DEL.wkMansArray = tempkeeperArray
        aPlayerCollectionView.reloadDataInMainQueue()
        
    }
    @IBAction func wkButtonAction(_ sender: Any) {
        //        wkButtonOutltl.setTitleColor(UIColor.gray, for: .highlighted)
        
        wkButtonOutltl.provideVisualFeedback(wkButtonOutltl)
        aPlayerCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 0)
        sortingIndex = 0
    }
    
    @IBAction func batButtonAction(_ sender: Any) {
        batButtonOutlt.provideVisualFeedback(batButtonOutlt)
        aPlayerCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 1)
        sortingIndex = 1
    }
    
    @IBAction func allButtonAction(_ sender: Any) {
        allrounderBtnOutlt.provideVisualFeedback(allrounderBtnOutlt)
        aPlayerCollectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 2)
        sortingIndex = 2
    }
    
    
    @IBAction func bowlButtonAction(_ sender: Any) {
        bowlButtonOutlt.provideVisualFeedback(bowlButtonOutlt)
        aPlayerCollectionView.scrollToItem(at: IndexPath(item: 3, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 3)
        sortingIndex = 3
    }
    var indexforTable = 0
    
    fileprivate func moveSelectionView(index: Int) {
        let selectionViewWidth = Int((ScreenSize.SCREEN_WIDTH) / 4)
        switch index {
        case 0:
            indexforTable = 0
            self.choosePlayerLbl.text =  "Pick 1 WICKET-KEEPERS"
            //            aCategoryInfoLabel.text = "PICK 1 WICKET-KEEPER"
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: 0, y: 28, width: selectionViewWidth, height: 3)
                //                self.aWKLabel.textColor = .black
                //                self.aWkValue.textColor = .black
            }
        case 1:
              indexforTable = 1
            //            self.aWKLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aWkValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aARLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aAllValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aBowlLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aBowlValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            self.choosePlayerLbl.text =  "Pick 2-6 BATSMAN"
            
            //            aCategoryInfoLabel.text = "PICK 3-5 BATSMAN"
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x:  (0 + (selectionViewWidth * index )), y: 28, width: selectionViewWidth, height: 3)
                //                self.aBatLabel.textColor = .black
                //                self.aBatValue.textColor = .black
            }
        case 2:
              indexforTable = 2
            //            self.aWKLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aWkValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aBatLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aBatValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aBowlLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aBowlValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            self.choosePlayerLbl.text =  "Pick 2-6 ALL ROUNDER"//
            //            aCategoryInfoLabel.text = "PICK 1-3 ALL ROUNDER"
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: (0 + (selectionViewWidth * index ))  , y: 28, width: selectionViewWidth, height: 3)
                //                self.aARLabel.textColor = .black
                //                self.aAllValue.textColor = .black
            }
        case 3:
              indexforTable = 3
            //            self.aWKLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aWkValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aBatLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aBatValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aARLabel.textColor = UIColor(red: 142, green: 145, blue: 147)
            //            self.aAllValue.textColor = UIColor(red: 142, green: 145, blue: 147)
            self.choosePlayerLbl.text =  "Pick 2-6 BOWLERS"
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: (0 + (selectionViewWidth * index )), y: 28, width: selectionViewWidth, height: 3)
                //                self.aBowlLabel.textColor = .black
                //                self.aBowlValue.textColor = .black
            }
        //            aCategoryInfoLabel.text = "PICK 3-5 BOWLER"
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        visibleCellIndex = Utility.findCenterCellIndex(collectionView: aPlayerCollectionView)
    }
    @IBAction func selectionView(_ sender: Any) {
        openChangePasswordView()
    }
    
    @IBOutlet weak var playerImageView: UIImageView!
    var closeButtonClouser: (() -> Void) = { }
    var notPlayingClosure: ((Bool) -> Void) = { _ in }
    var playingClosure: ((Bool) -> Void) = { _ in }
    @IBOutlet weak var playingBlank: UIImageView!
    @IBOutlet weak var notPlayingBlank: UIImageView!
    //        @IBOutlet weak var playing: UIButton!
    
    @IBOutlet weak var playerStatusView: UIView!
    
    
    @IBAction func playingAction(_ sender: UIButton) {
        
        playingBlank.image = #imageLiteral(resourceName: "RedCircle")
        notPlayingBlank.image = #imageLiteral(resourceName: "path Blank")
        
        APP_DEL.wkMansArray = APP_DEL.wkMansArray.filter { $0.is_playing == 1 }
        APP_DEL.batMansArray = APP_DEL.batMansArray.filter { $0.is_playing == 1 }
        APP_DEL.bowlMansArray = APP_DEL.bowlMansArray.filter { $0.is_playing == 1 }
        APP_DEL.allMansArray = APP_DEL.allMansArray.filter { $0.is_playing == 1 }
        
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
        
        notPlayingBlank.image = #imageLiteral(resourceName: "RedCircle")
        playingBlank.image = #imageLiteral(resourceName: "path Blank")
        
        APP_DEL.wkMansArray = APP_DEL.wkMansArray.filter { $0.is_playing == 0 }
        APP_DEL.batMansArray = APP_DEL.batMansArray.filter { $0.is_playing == 0 }
        APP_DEL.bowlMansArray = APP_DEL.bowlMansArray.filter { $0.is_playing == 0 }
        APP_DEL.allMansArray = APP_DEL.allMansArray.filter { $0.is_playing == 0 }
        
        self.aPlayerCollectionView.reloadDataInMainQueue()
        playerStatusView.isHidden = true
        for recognizer in view.gestureRecognizers ?? [] {
                   view.removeGestureRecognizer(recognizer)
               }
        
    }
    
    var playerCheck = false
    @IBAction func PlayerFilter(_ sender: UIButton){
        aCreditImageView.image = nil
        aPointsImageView.image = nil
        if playerCheck {

            playerImageView.image =  #imageLiteral(resourceName: "up")
            APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                ($0.name ?? "0")  >  ($1.name ?? "0")
                
            }
            APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                ($0.name ?? "0")  >  ($1.name ?? "0")
                
            }
            APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                ($0.name ?? "0")  >  ($1.name ?? "0")
                
            }
            APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                ($0.name ?? "0")  >  ($1.name ?? "0")
                
            }
        }
            
        else {
            playerImageView.image = #imageLiteral(resourceName: "down")

                       APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                           ($0.name ?? "0")  <  ($1.name ?? "0")
                           
                       }
                       APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                           ($0.name ?? "0")  <  ($1.name ?? "0")
                           
                       }
                       APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                           ($0.name ?? "0")  <  ($1.name ?? "0")
                           
                       }
                       APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                           ($0.name ?? "0")  <  ($1.name ?? "0")
                           
                       }
        }
        playerCheck = !playerCheck
        aPlayerCollectionView.reloadDataInMainQueue()
        
    }
    
    @IBAction func playerStatus(_ sender: Any) {
    
        playerStatusView.isHidden = false
        APP_DEL.wkMansArray.removeAll()
        APP_DEL.wkMansArray = tempkeeperArray
        APP_DEL.bowlMansArray.removeAll()
        APP_DEL.bowlMansArray = tempBowlerArray
        APP_DEL.batMansArray.removeAll()
        APP_DEL.batMansArray = tempBatsmenrArray
        APP_DEL.allMansArray.removeAll()
        APP_DEL.allMansArray = tempAllrounderArray
       
        
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
    fileprivate func openChangePasswordView() {
        if ruleView == nil {
            ruleView = Bundle.main.loadNibNamed("SelectionRuleUI", owner: self, options: nil)?.first as? SelectionRuleUI
            ruleView?.center = self.view.center
//              ruleView?.frame = CGRect(x:   ScreenSize.SCREEN_WIDTH/2 - self.view.frame.width * 0.9 / 2 , y:  ScreenSize.SCREEN_HEIGHT/2 - self.view.frame.height * 0.42 / 2, width:  self.view.frame.width * 0.9, height: self.view.frame.height * 0.42)
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
                APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                }
                APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                }
            }
            else {
                
                APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                }
                APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                }
            }
            
        case 1:
            if aCreditImageView.image == #imageLiteral(resourceName: "down") {
                
                APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                }
                APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                }
            }
            else {
                APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                }
                APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                }
                
                
            }
            
        case 2:
            if aCreditImageView.image == #imageLiteral(resourceName: "up") {
                APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                }
                APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                }
            }
            else {
                APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                }
                APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                }
                
            }
        case 3:
            if aCreditImageView.image == #imageLiteral(resourceName: "up") {
                APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                }
                APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 <  Double($1.credit ?? "0") ?? 0
                }
            }
            else {
                APP_DEL.wkMansArray =  APP_DEL.wkMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.batMansArray =  APP_DEL.batMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                    
                }
                APP_DEL.allMansArray =  APP_DEL.allMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                }
                APP_DEL.bowlMansArray =  APP_DEL.bowlMansArray.sorted {
                    Double($0.credit ?? "0") ?? 0 >  Double($1.credit ?? "0") ?? 0
                }
                
            }
            
        default:
            break
        }
        aPlayerCollectionView.reloadDataInMainQueue()
    }
    fileprivate func sortingPointArray(index: Int) {
        
        switch index {
            
        case 0:
            if aPointsImageView.image == #imageLiteral(resourceName: "down") {
                
                APP_DEL.wkMansArray =    APP_DEL.wkMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                APP_DEL.batMansArray =    APP_DEL.batMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                APP_DEL.bowlMansArray =    APP_DEL.bowlMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                
                APP_DEL.allMansArray =    APP_DEL.allMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                
            }
            else {
                
                APP_DEL.wkMansArray =    APP_DEL.wkMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                APP_DEL.batMansArray =    APP_DEL.batMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                APP_DEL.bowlMansArray =    APP_DEL.bowlMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                
                APP_DEL.allMansArray =    APP_DEL.allMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
            }
            
        case 1:
            if aPointsImageView.image == #imageLiteral(resourceName: "down") {
                APP_DEL.wkMansArray =    APP_DEL.wkMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                APP_DEL.batMansArray =    APP_DEL.batMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                APP_DEL.bowlMansArray =    APP_DEL.bowlMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                
                APP_DEL.allMansArray =    APP_DEL.allMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                
                
            }
            else {
                
                APP_DEL.wkMansArray =    APP_DEL.wkMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                APP_DEL.batMansArray =    APP_DEL.batMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                APP_DEL.bowlMansArray =    APP_DEL.bowlMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                
                APP_DEL.allMansArray =    APP_DEL.allMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                
                
            }
            
        case 2:
            if aPointsImageView.image == #imageLiteral(resourceName: "up") {
                APP_DEL.wkMansArray =    APP_DEL.wkMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                APP_DEL.batMansArray =    APP_DEL.batMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                APP_DEL.bowlMansArray =    APP_DEL.bowlMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                
                APP_DEL.allMansArray =    APP_DEL.allMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
            }
            else {
                
                APP_DEL.wkMansArray =    APP_DEL.wkMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                APP_DEL.batMansArray =    APP_DEL.batMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                APP_DEL.bowlMansArray =    APP_DEL.bowlMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                
                APP_DEL.allMansArray =    APP_DEL.allMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                
            }
        case 3:
            if aPointsImageView.image == #imageLiteral(resourceName: "up") {
                APP_DEL.wkMansArray =    APP_DEL.wkMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                APP_DEL.batMansArray =    APP_DEL.batMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                APP_DEL.bowlMansArray =    APP_DEL.bowlMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
                
                APP_DEL.allMansArray =    APP_DEL.allMansArray.sorted(by: { ($0.series_points ?? 0.0) < ($1.series_points ?? 0.0) })
            }
            else {
                
                APP_DEL.wkMansArray =    APP_DEL.wkMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                APP_DEL.batMansArray =    APP_DEL.batMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                APP_DEL.bowlMansArray =    APP_DEL.bowlMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
                
                APP_DEL.allMansArray =    APP_DEL.allMansArray.sorted(by: { ($0.series_points ?? 0.0) > ($1.series_points ?? 0.0) })
            }
            
        default:
            break
        }
        aPlayerCollectionView.reloadDataInMainQueue()
    }
    
    
    @IBAction func pointButtonAction(_ sender: UIButton) {
        aCreditImageView.image = nil
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
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.removeChangePassView()
//        if aWkValue.text == "0" {
//
//            Loader.showToast(message: "Please choose minimum 1 Wicket-Keeper", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
//            return
//        }
//        if aBatValue.text == "0" || aBatValue.text == "1"  {
//
//            Loader.showToast(message: "Please choose minimum 2 Batsman", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
//
//            return
//        }
//        if aAllValue.text == "0" || aAllValue.text == "1" {
//            Loader.showToast(message: "Please choose minimum 2 All-Rounder", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
//
//            return
//        }
//        if aBowlValue.text == "0" || aBowlValue.text == "1" {
//            Loader.showToast(message: "Please choose minimum 2 Bowler", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
//
//            return
//        }
        
        if APP_DEL.choosedTeamArray.count == 11 {
            openViewController(controller: CaptainViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                vc.teamArray = APP_DEL.choosedTeamArray
                vc.contestData = self.contestData
                vc.teamNumber = self.teamNumber
                vc.delegate = self
                vc.c = self.captainID
                vc.v = self.viceCaptainID
                vc.matchType = "CRICKET"
                vc.teamidforupdate = "\(self.teamID)"
                vc.comingfromEditVc = self.isFromEdit
             
                vc.fromSelectionVc = self.fromTeamSelection
                
                
            }
        } else {
            
            Loader.showToast(message: "Please select 11 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
        }
    }
    
    
    func playerTeamCountSetup() {
        var tempFirstTotalPlayerCount = 0
        var tempSecondTotalPlayerCount = 0
        let players = APP_DEL.choosedTeamArray
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
    
}

extension TeamViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == aPlayerCollectionView {
            return 4
        } else {
            return playerCountArray.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == aPlayerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.identifier(), for: indexPath) as! TeamCollectionViewCell
            cell.delgate = self
            cell.firstTeamName = firstTeamName
            cell.secondTeamName = secondTeamName
            cell.playerDataIndex = indexPath.item
            cell.firstTeamName = firstTeamName
            cell.secondTeamName = secondTeamName
            cell.allSelectionTotal = allRounderCount
            cell.batSelectionTotal = batsManCount
            cell.wkSelectionTotal = wKeeperCount
            cell.bowSelectionTotal = bowlerCount
           
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
            cell.bowlSelectionClouser = {[weak self] val in
                if let strongSelf = self {
                    let bowlVal =  String(val)
                    strongSelf.aBowlValue.text = "\(bowlVal)"
                    self?.bowlerCount = Int(bowlVal) ?? 0
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
                    
                    let remainingCredit = 100 - val
                    self?.totalcredit = Double(remainingCredit)
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
            //            cell.wkSelectionClouser = {[weak self] val in
            //                if let strongSelf = self {
            //                    let wkVal =  String(val)
            //
            //                    strongSelf.aWkValue.text = "\(wkVal)"
            //
            //                    strongSelf.aCountCollectionView.reloadDataInMainQueue()
            //                }
            //            }
            //            cell.batSelectionClouser = {[weak self] val in
            //                if let strongSelf = self {
            //                    let batVal =  String(val)
            //                    strongSelf.aBatValue.text = "\(batVal)"
            //                    strongSelf.aCountCollectionView.reloadDataInMainQueue()
            //                }
            //            }
            //            cell.allSelectionClouser = {[weak self] val in
            //                if let strongSelf = self {
            //                    let arVal =  String(val)
            //                    strongSelf.aAllValue.text = "\(arVal)"
            //                    strongSelf.aCountCollectionView.reloadDataInMainQueue()
            //                }
            //            }
            //            cell.bowlSelectionClouser = {[weak self] val in
            //                if let strongSelf = self {
            //                    let bowlVal =  String(val)
            //                    strongSelf.aBowlValue.text = "\(bowlVal)"
            //                    strongSelf.aCountCollectionView.reloadDataInMainQueue()
            //
            //                }
            //            }
            //            cell.playerCreditClouser = {[weak self] val in
            //                if let strongSelf = self {
            //
            //
            //                    strongSelf.aCreditValue.text = "\(100 - val)"
            //                }
            //            }
            //            cell.playerCountClouser = {[weak self] val in
            //                if let strongSElf = self {
            //
            //
            //                    strongSElf.totalPlayer.text =  String(val)
            //
            //                }
            //
            //            }
            //            cell.playerChoosedClouser = {[weak self]  in
            //                if let strongSelf = self {
            //                    strongSelf.playerTeamCountSetup()
            //                }
            //            }
            //
            //            return cell
            //    }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCountCVCell.identifier(), for: indexPath) as! TeamCountCVCell
            cell.configureCell(index: indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == aPlayerCollectionView {
            return CGSize(width: aPlayerCollectionView.frame.width, height: aPlayerCollectionView.frame.height)
        } else {
            if DeviceType.IS_IPHONE_5 {
                return CGSize(width: ScreenSize.SCREEN_WIDTH / 15.5, height: ScreenSize.SCREEN_WIDTH / 15.5)
            } else if DeviceType.IS_IPHONE_X_OR_GREATER {
                return CGSize(width: ScreenSize.SCREEN_WIDTH / 14.5, height: ScreenSize.SCREEN_WIDTH / 14.5)
            } else {
                return CGSize(width: ScreenSize.SCREEN_WIDTH / 13.5, height: ScreenSize.SCREEN_WIDTH / 13.5)
            }
            
        }
    }
    
    
}
extension TeamViewController:openPlayerStatisticProfile {
    func sendDatatoMainVc(player: PlayerListResponses) {
        openPlayerInfoVC(id: player)
    }
    
    
    
    func sendPlayerInfotoRemove(playerid: PlayerListResponses) {
        APP_DEL.choosedTeamArray = APP_DEL.choosedTeamArray.filter({ $0.name != playerid.name})
        if playerid.role == "bowler" {
            if  (APP_DEL.choosedBowlMansArray.count > APP_DEL.minBowl) {
                APP_DEL.extraPlayer =  APP_DEL.extraPlayer + 1;
            }
            
            self.bowlerCount -= 1
            aBowlValue.text = "\(bowlerCount)"
            APP_DEL.choosedBowlMansArray = APP_DEL.choosedBowlMansArray.filter({ $0.name != playerid.name})
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
        
        if playerid.role == "batsman" {
            if  (APP_DEL.choosedBatMansArray.count > APP_DEL.minBat) {
                APP_DEL.extraPlayer =  APP_DEL.extraPlayer + 1;
            }
            
            self.batsManCount -= 1
            aBatValue.text = "\(batsManCount)"
            APP_DEL.choosedBatMansArray = APP_DEL.choosedBatMansArray.filter({ $0.name != playerid.name})
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
        
        if playerid.role == "allrounder" {
            if  (APP_DEL.chossedAllMansArray.count > APP_DEL.minAll) {
                APP_DEL.extraPlayer =  APP_DEL.extraPlayer + 1;
            }
            self.allRounderCount -= 1
            aAllValue.text = "\(allRounderCount)"
            APP_DEL.chossedAllMansArray = APP_DEL.chossedAllMansArray.filter({ $0.name != playerid.name})
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
        
        if playerid.role == "keeper" {
            if  (APP_DEL.choosedWkMansArray.count > APP_DEL.minWk) {
                APP_DEL.extraPlayer =  APP_DEL.extraPlayer + 1
            }
            
            aWkValue.text = "\(wKeeperCount) "
            self.wKeeperCount -= 1
            APP_DEL.choosedWkMansArray = APP_DEL.choosedWkMansArray.filter({ $0.name != playerid.name})
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
    
    
    func sendPlayaerInfo(playerid: PlayerListResponses) {
        
        if playerid.role == "bowler" {
            if APP_DEL.choosedTeamArray.count == 11 {
                
                Loader.showToast(message: "You can choose maximum 11 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                
            }
            else {
                
                if playerTeamCountSeven(player: playerid) {
                    
                    Loader.showToast(message: "You can Select only 7 from a each team", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
                } else {
                    if checkCreaditLimitExceed(sPlayer: playerid) {
                        
                        Loader.showToast(message: "Only \(remainingCr) credit left", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                        
                    }
                    else {
                        
                        if  APP_DEL.choosedBowlMansArray.count != APP_DEL.maxBall  {
                            if (APP_DEL.choosedBowlMansArray.count < APP_DEL.minBowl ||  APP_DEL.extraPlayer > 0) {
                                
                                
                                if (APP_DEL.choosedBowlMansArray.count >= APP_DEL.minBowl) {
                                    APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                                }
                                self.bowlerCount += 1
                                APP_DEL.choosedTeamArray.append(playerid)
                                aBowlValue.text = "\(bowlerCount)"
                                APP_DEL.choosedBowlMansArray.append(playerid)
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
                            Loader.showToast(message: "You can Select only 6 Bowlers", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        }
                    }
                }
                
            }
        }
        
        if playerid.role == "batsman" {
            
            if APP_DEL.choosedTeamArray.count == 11 {
                
                Loader.showToast(message: "You can choose maximum 11 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
            } else {
                if playerTeamCountSeven(player: playerid) {
                    if DeviceType.IS_IPHONE_X_OR_GREATER {
                        Loader.showToast(message: "You can Select only 7 from a each team", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    }
                    else {
                        Loader.showToast(message: "Max 7 players from a team", onView: self.view, bottomMargin: 0 , color: UIColor(red: 240, green: 75, blue: 80))
                    }
                    
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
                        if APP_DEL.choosedBatMansArray.count != 6 {
                            if (APP_DEL.choosedBatMansArray.count < APP_DEL.minBat ||  APP_DEL.extraPlayer > 0) {
                                
                                
                                if (APP_DEL.choosedBatMansArray.count >= APP_DEL.minBat) {
                                    APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                                }
                                self.batsManCount += 1
                                APP_DEL.choosedTeamArray.append(playerid)
                                aBatValue.text = "\(batsManCount)"
                                
                                APP_DEL.choosedBatMansArray.append(playerid)
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
                            
                            Loader.showToast(message: "You can Select only 6 Batsmen", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        }
                    }
                }
                
            }
        }
        
        
        if playerid.role == "allrounder" {
            
            if APP_DEL.choosedTeamArray.count == 11 {
                
                Loader.showToast(message: "You can choose maximum 11 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            }
            else {
                if playerTeamCountSeven(player: playerid) {
                    Loader.showToast(message: "You can Select only 7 from a each team", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                } else {
                    if checkCreaditLimitExceed(sPlayer: playerid) {
                        
                        Loader.showToast(message: "Only \(remainingCr) credit left", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    }
                    else {
                        if APP_DEL.chossedAllMansArray.count != 6 {
                            if (APP_DEL.chossedAllMansArray.count < APP_DEL.minAll ||  APP_DEL.extraPlayer > 0) {
                                
                                
                                if (APP_DEL.chossedAllMansArray.count >= APP_DEL.minAll) {
                                    APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                                }
                                APP_DEL.choosedTeamArray.append(playerid)
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
                            Loader.showToast(message: "You can Select only 4 All Rounder", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        }
                    }
                }
            }
        }
        
        if playerid.role == "keeper" {
            
            if APP_DEL.choosedTeamArray.count == 11 {
                
                Loader.showToast(message: "You can choose maximum 11 Player", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
            }
            else {
                if playerTeamCountSeven(player: playerid) {
                    
                    Loader.showToast(message: "You can Select only 7 from a each team", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                    
                    
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
                        if APP_DEL.choosedWkMansArray.count != 2 {
                            if APP_DEL.choosedWkMansArray.count < APP_DEL.minWk || APP_DEL.extraPlayer > 0 {
                                if APP_DEL.choosedWkMansArray.count >= APP_DEL.minWk {
                                    APP_DEL.extraPlayer = APP_DEL.extraPlayer - 1
                                }
                                APP_DEL.choosedTeamArray.append(playerid)
                                aWkValue.text = "\(wKeeperCount) "
                                self.wKeeperCount += 1
                                APP_DEL.choosedWkMansArray.append(playerid)
                                
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
                            
                            Loader.showToast(message:"You can Select only  2 Wicket Kepper", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
                            
                        }
                    }
                }
            }
        }
        
    }
    
    func minimumPlayerWarning() {
        if (APP_DEL.choosedBowlMansArray.count < 3) {
            Loader.showToast(message:"You must select at least 3 Bowlers.", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
        } else if (APP_DEL.choosedBatMansArray.count < 3) {
            Loader.showToast(message: "You must select at least 3 Batsmen.", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
        } else if (APP_DEL.choosedWkMansArray.count < 1) {
            Loader.showToast(message: "You must select at least 1 Wicket-Keepers.", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
        } else if (APP_DEL.chossedAllMansArray.count < 1) {
            Loader.showToast(message: "You must select at least 1 All-Rounders.", onView: self.view, bottomMargin: 30 , color: UIColor(red: 240, green: 75, blue: 80))
            
            
        }
    }
    
    func openPlayerInfoVC(id: PlayerListResponses) {
        openViewController(controller: PlayerStaticsViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            //            vc.teamId = self.teamId
            vc.matchKey = self.matchKey
            vc.playerData = id
            vc.delegate = self
            for i in APP_DEL.choosedTeamArray {
                if i.id == id.id {
                    vc.isPlayerAdeed = false
                    return
                }
                
            }
            vc.isPlayerAdeed = true
        }
    }
}

extension TeamViewController:sendPreviewDetail {
    
    func checkComingFromPReview(check: Bool) {
        fromPreview =  check
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CaptainViewController" {
            let secondViewController = segue.destination as! PreviewViewController
            secondViewController.delegate = self
        }
    }
}
extension TeamViewController:fromPlayerProfile,checkFromCaptain {
    
    
    func comingFromCaptain(check: Bool) {
        self.fromPreview = check
    }
    
    func backToTeam(check: Bool) {
        self.fromPreview = check
    }
    
    
}

