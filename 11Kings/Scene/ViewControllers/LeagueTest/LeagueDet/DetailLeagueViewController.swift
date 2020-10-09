//
//  DetailLeagueViewController.swift
//  DreamTeam
//
//  Created by Test on 24/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON
class DetailLeagueViewController: BaseClass {

    var winnerBreakUpView: WinnerBreakupView?
    @IBOutlet weak var entryImageView: UIImageView!
    @IBOutlet weak var team2Image: UIImageView!
    var checkClose = false
    @IBOutlet weak var spotImageView: UIImageView!
    @IBOutlet weak var winnerImageView: UIImageView!
    var matchType = ""
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
   
    @IBOutlet weak var prizeBtn: UIButton!
    @IBOutlet weak var spotBtn: UIButton!
    
    @IBOutlet weak var entryBtn: UIButton!
    @IBOutlet weak var winnrBtn: UIButton!
    @IBOutlet weak var prizePoolImageView: UIImageView!
    @IBOutlet weak var detailTableView: UITableView!
    var matchKey:String?
    var maxteamLimit = 0
    var challengeID = 0
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team1Name: UILabel!
    var leagueData = [MyLeague]()

    var entryArrays = [Int]()
    var multiEntryArrays = [Int]()
    var contestSArrays = [Int]()
    var winningArrays = [Int]()
    var mycategories:[MyCatagries]?
    var getMatchDetail:GetMatchDetails?
    
    var checkTeamResponse = [MyTeamResponses]()
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var contestType = "Contest"
    var comingFromAllContest = false
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
     
    }
    
    override func viewWillAppear(_ animated: Bool) {

         self.navigationController?.isNavigationBarHidden = true
         prizeBtn.imageView?.image = nil
         entryBtn.imageView?.image = nil
         winnrBtn.imageView?.image = nil
         spotBtn.imageView?.image = nil
         registerCell()
         detailTableView.reloadDataInMainQueue()
         setContestData()
        if !checkClose {
        if comingFromAllContest {
            getAllTotalLeague()
        }
        else {
         getCategoryLeague()
    }
        }
    
    }
    fileprivate func registerCell() {
         self.detailTableView.register(UINib(nibName:"ContestCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ContestCategoryTableViewCell")
         
       }
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func getEntry() -> String {
        var amountArray = [String]()
        for amount in entryArrays {
            let amtStr = "\(amount)"
            amountArray.append(amtStr)
        }
        let priceCard = amountArray.joined(separator: ",")
        return priceCard
    }
    func getMultiEntry() -> String {
        var amountArray = [String]()
        for amount in multiEntryArrays {
            let amtStr = "\(amount)"
            amountArray.append(amtStr)
        }
        let priceCard = amountArray.joined(separator: ",")
        return priceCard
    }
    func getContestSize() -> String {
        var amountArray = [String]()
        for amount in contestSArrays {
            let amtStr = "\(amount)"
            amountArray.append(amtStr)
        }
        let priceCard = amountArray.joined(separator: ",")
        return priceCard
    }
    func getWinner() -> String {
        var amountArray = [String]()
        for amount in winningArrays {
            let amtStr = "\(amount)"
            amountArray.append(amtStr)
        }
        let priceCard = amountArray.joined(separator: ",")
        return priceCard
    }
    @IBAction func filterPrizePool(_ sender: UIButton) {
        entryBtn.setImage(nil, for: .normal)
                    spotBtn.setImage(nil, for: .normal)
                    winnrBtn.setImage(nil, for: .normal)
        entryBtn.setImage(nil, for: .selected)
                           spotBtn.setImage(nil, for: .selected)
                           winnrBtn.setImage(nil, for: .selected)
        if sender.isSelected {
        
            sender.setImage(#imageLiteral(resourceName: "up"), for: .selected)
 sender.setImage(#imageLiteral(resourceName: "up"), for: .normal)
            leagueData =  leagueData.sorted {
                                      ($0.win_amount ?? 0) >  ($1.win_amount ?? 0)

            }
        }
        
        else {
            sender.setImage(#imageLiteral(resourceName: "down"), for: .normal)
sender.setImage(#imageLiteral(resourceName: "down"), for: .selected)
            leagueData =  leagueData.sorted {
                        ($0.win_amount ?? 0) <  ($1.win_amount ?? 0)

          

        }
            
        }
         sender.isSelected = !sender.isSelected
        detailTableView.reloadDataInMainQueue()
        
       }
        fileprivate func getAllTotalLeague() {
            showActivityIndicator(sMessage: "Loading...")
            let headers = [
                "Content-Type":"application/json"]
            if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
    
                let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                let param = ["user_id":UserDic.value(forKey: "user_id"),
                             "matchkey":matchKey,
    
                             "sport_key":matchType,"contest_size":getContestSize(),"contest_type":getMultiEntry(),"winning":getWinner(),"entryfee":getEntry()]
    
                NetworkManager.post_Request2(urlService: kGetTotalLeague, param: param as [String : Any], head: headers)  { (response) in
    
                    self.hideActivityIndicator()
                    guard let data = response else {
                        self.view.makeToast(message: "We are Facing Problem.. we will be right back!")
                        return
    
                    }
                    do{
                        let json = try JSON(data:data as! Data)
    
                        let results = json["result"]
                        let cat = results["contest"]
    
                        self.leagueData.removeAll()
    
                        for arr in cat.arrayValue{
    
    
                            self.leagueData.append(MyLeague(Leaguejson: arr))
    
    
                        }
    
                        
                        self.detailTableView.reloadDataInMainQueue()
                        
                    }
    
    
    
                    catch{
                      self.view.makeToast(message: "We are Facing Problem.. we will be right back!")
                        print(error.localizedDescription)
                    }
                }
    
            }
        }
     var winnerBrkupRespnse = [WinnerbreakUpResponse]()
    func getWinnerBreakupData(challengeId: Int, ammount: Double,matchKey:String) {
           showActivityIndicator(sMessage: "Loading...")
           let headers = [
               "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDQwNzYwNCwiZXhwIjoxNTY0NDExMjA0LCJuYmYiOjE1NjQ0MDc2MDQsImp0aSI6IlJVb25mSDlWcXloT1Q2WUQiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.ivVe5vYrh2rDWYt98PqKgswj4bgMgx-iggBhNE3JBPQ",
               "content-type": "application/json",
               "Accept": "application/json",
               "cache-control": "no-cache"
               
           ]
           let parameters = ["challenge_id": challengeId, "matchkey": matchKey,"showLeaderBoard":"false"] as [String : Any]
           
           NetworkManager.post_Request2(urlService: kWinnerbreakUpURL, param: parameters, head: headers) { (response) in
               self.hideActivityIndicator()
               do {
                   if response != nil {
                       do {
                           let json =  try JSON(data: response as! Data)
                           let dataresponse = json["result"]
                           self.winnerBrkupRespnse.removeAll()
                           for arr in dataresponse.arrayValue{
                               self.winnerBrkupRespnse.append(WinnerbreakUpResponse(json:arr))
                               
                               
                           }
                           
                           self.openWinnerBreakupView(winnerArr: self.winnerBrkupRespnse, ammount: ammount)
                           
                           
                       }
                           
                       catch {
                           Loader.showAlert(message: "Status code 500: server internal error")
                       }
                   }
               }
           }
       }
    @IBAction func backButton(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    fileprivate func setContestData() {
           if let getcontestdata = getMatchDetail {
               team1Name.text = getcontestdata.team1display
               team2Name.text = getcontestdata.team2display
               matchKey = getcontestdata.matchkey
               
               if let time = getcontestdata.time_start {
                   setReleaseTime(releaseDateString: time)
               }
           }
        if let imagePath1 = getMatchDetail?.team1logo {
            let urlString1 = imagePath1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            let imageUrl = URL(string: urlString1 ?? "")
            team1Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
        if let imagePath2 = getMatchDetail?.team2logo {
            let urlString2 = imagePath2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            let imageUrl = URL(string: urlString2 ?? "")
            team2Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "placeHolderImage11"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
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
           let countdown = "\(Utility.getStringFrom(seconds: day))D: \(Utility.getStringFrom(seconds: hour))H: \(Utility.getStringFrom(seconds: minute))M: \(Utility.getStringFrom(seconds: second))S"
           timeLbl.text = countdown
           
           if day == 0 && hour == 0 && minute == 0 && second == 0 {
               countdownTimer.invalidate()
           }
       }
    func getCategoryLeague() {
            showActivityIndicator(sMessage: "Loading...")
           if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                    let headers = [
                        "Content-Type":"application/json",
                                  "Accept": "application/json",
                                  "cache-control": "no-cache"
                                  
                              ]
                    let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["category_id": challengeID , "matchkey": matchKey ?? "","showLeaderBoard":"false","user_id": UserDic.value(forKey: "user_id") ?? "0","contest_size":getContestSize(),"contest_type":getMultiEntry(),"winning":getWinner(),"entryfee":getEntry()] as [String : Any]
               NetworkManager.post_Request2(urlService: kGetCategoryLeagues, param: parameters, head: headers) {
                   (response) in
                   self.hideActivityIndicator()
                   do {
                   if response != nil {
                       let jsonRes = try JSON(data:response as! Data)
                       let result = jsonRes["result"]
                       let contest = result["contest"]
                       
                       for arr in contest.arrayValue {
                        self.leagueData.append(MyLeague(Leaguejson: arr))
                       }
                    self.detailTableView.reloadDataInMainQueue()
                   }
               }
                   catch {
                       self.view.makeToast(message: "Server Error")
                   }
           
           
       }
           }
       }
    
    
    @IBAction func entryFilter(_ sender: UIButton) {
        prizeBtn.setImage(nil, for: .normal)
              spotBtn.setImage(nil, for: .normal)
              winnrBtn.setImage(nil, for: .normal)
        prizeBtn.setImage(nil, for: .selected)
                    spotBtn.setImage(nil, for: .selected)
                    winnrBtn.setImage(nil, for: .selected)
        if sender.isSelected {
                       sender.setImage(#imageLiteral(resourceName: "up"), for: .normal)
                          sender.setImage(#imageLiteral(resourceName: "up"), for: .selected)

            leagueData =  leagueData.sorted {
                                                               ($0.entryfee ?? 0) <  ($1.entryfee ?? 0)
                                     
                                                                      }

                      
                      }
                      
                      else {
                          sender.setImage(#imageLiteral(resourceName: "down"), for: .normal)
                          sender.setImage(#imageLiteral(resourceName: "down"), for: .selected)
            leagueData =  leagueData.sorted {
                                                   ($0.entryfee ?? 0) >  ($1.entryfee ?? 0)
                         
                                                          }
                        

                      }
                           sender.isSelected = !sender.isSelected
                      
                      detailTableView.reloadDataInMainQueue()
                     
    }
    
     @IBAction func openFiter(_ sender: UIButton) {
    openViewController(controller: FilterViewController.self, storyBoard: .homeStoryBoard) { (vc) in
        vc.entryArray = self.entryArrays
        vc.multiEntryArray =   self.multiEntryArrays
        vc.contestSArray = self.contestSArrays
         vc.winningArray = self.winningArrays
        vc.delegate = self
        }
    }
    @IBAction func spotLeft(_ sender: UIButton) {
        prizeBtn.setImage(nil, for: .normal)
        winnrBtn.setImage(nil, for: .normal)
        entryBtn.setImage(nil, for: .normal)
        prizeBtn.setImage(nil, for: .selected)
               winnrBtn.setImage(nil, for: .selected)
               entryBtn.setImage(nil, for: .selected)
               
       if sender.isSelected {
               
                   sender.setImage(#imageLiteral(resourceName: "up"), for: .selected)
        sender.setImage(#imageLiteral(resourceName: "up"), for: .normal)

        leagueData =  leagueData.sorted {
                                            ($0.maximum_user ?? 0) <  ($1.maximum_user ?? 0)
                                                          
                                                      }

               }
               
               
               else {
                   sender.setImage(#imageLiteral(resourceName: "down"), for: .normal)
sender.setImage(#imageLiteral(resourceName: "down"), for: .selected)
        leagueData =  leagueData.sorted {
                                   ($0.maximum_user ?? 0) >  ($1.maximum_user ?? 0)
                                              
                                          }
                 

               }
                    sender.isSelected = !sender.isSelected
               
               detailTableView.reloadDataInMainQueue()
               
              }

              
    
  
    
    
    @IBAction func winners(_ sender: UIButton) {
        prizeBtn.setImage(nil, for: .normal)
        spotBtn.setImage(nil, for: .normal)
        entryBtn.setImage(nil, for: .normal)
        prizeBtn.setImage(nil, for: .selected)
             spotBtn.setImage(nil, for: .selected)
             entryBtn.setImage(nil, for: .selected)
         if sender.isSelected {
            if sender.imageView?.image == #imageLiteral(resourceName: "down") {
             sender.setImage(#imageLiteral(resourceName: "up"), for: .selected)
 sender.setImage(#imageLiteral(resourceName: "up"), for: .normal)
                leagueData =  leagueData.sorted {
                         Int($0.totalwinners ?? "0") ?? 0 >  Int($1.totalwinners ?? "0") ?? 0
                                    
                                }

         }
         }
         
         
         else {
             sender.setImage(#imageLiteral(resourceName: "down"), for: .normal)
sender.setImage(#imageLiteral(resourceName: "down"), for: .selected)
            leagueData =  leagueData.sorted {
            Int($0.totalwinners ?? "0") ?? 0 <  Int($1.totalwinners ?? "0") ?? 0
                       
                   }
           
        }
        sender.isSelected = !sender.isSelected
        
        detailTableView.reloadDataInMainQueue()
        
    }
    
    
    
}
extension DetailLeagueViewController: UITableViewDelegate, UITableViewDataSource {
 
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return leagueData.count
 
    }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     let cell = tableView.dequeueReusableCell(withIdentifier: "ContestCategoryTableViewCell") as! ContestCategoryTableViewCell
   
    cell.delegate = self
       
         
    cell.configureCell(league: (leagueData[indexPath.row]) )

    if leagueData[indexPath.row].challenge_type == "gadget" {
        cell.aAmountLabel.text = leagueData[indexPath.row].first_rank_prizes
        cell.winnerLbl.text = "\(leagueData[indexPath.row].first_rank_prizes ?? "")"
    }
    else {
        cell.winnerLbl.text = "\(leagueData[indexPath.row].first_rank_prize ?? 0)"
        cell.aAmountLabel.text = "\(kRupeeIcon)\(leagueData[indexPath.row].win_amount ?? 0)"
        
        
    }
             return cell
         
         
         
      
    
     //                }
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if leagueData[indexPath.row].announcement != nil {
                  return 170
           }
           else {
                   return  160
               }
               
     
     
 }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
           let leagues = leagueData
        if let cID = leagueData[indexPath.row].id, let fees = leagueData[indexPath.row].entryfee {
            openLeaderboards(challengeIds: cID, leagues: (leagues[indexPath.row]), entreFees: fees)
              }
      
      

         
 }
    
       func openLeaderboards(challengeIds: Int, leagues: MyLeague, entreFees: Int) {
           openViewController(controller: ContestDetailVCViewController.self, storyBoard: .homeStoryBoard) { (vc) in
               vc.matchKey = self.matchKey ?? ""
               vc.challengeId = challengeIds
               vc.league = leagues
               vc.contestData = self.getMatchDetail
              // vc.myTeamsData = self.getMatchDetail
               vc.entreeFee = entreFees
            vc.matchOFType = self.matchType
            vc.myTeamsData = self.checkTeamResponse
            vc.maxTeamlimit = leagues.max_team_limit ?? 0
            vc.leagueType = "Contest"
           }
       }
}
extension DetailLeagueViewController:openConfirmationView {
    func openwinningView(challengeid: Int, winningAmount: Double, matchKey: String) {
        getWinnerBreakupData(challengeId: challengeid, ammount: winningAmount,matchKey:matchKey)
    }
    func openWinnerBreakupView(winnerArr: [WinnerbreakUpResponse], ammount: Double) {
                   if winnerArr.count == 0 {
                       Loader.showToast(message: "No Winner Breakup", onView: self.view, bottomMargin: 200, color: UIColor.black.withAlphaComponent(0.7))
                       return
                   }
                   if winnerBreakUpView == nil {
                       winnerBreakUpView = Bundle.main.loadNibNamed("WinnerBreakupView", owner: self, options: nil)?.first as? WinnerBreakupView
                       winnerBreakUpView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
                       APP_DEL.window?.addSubview(winnerBreakUpView!)
                       winnerBreakUpView?.winnerBreakupArr = winnerArr
                       winnerBreakUpView?.totalAmmount = ammount
                       winnerBreakUpView?.closeButtonClouser = { [weak self] in
                           if let strongSelf = self {
                               strongSelf.viewCloseAction()
                           }
                       }
                   }
       }
    fileprivate func viewCloseAction() {
        winnerBreakUpView?.removeFromSuperview()
             winnerBreakUpView = nil
        
    }
    func openVC(challengeid: Int, contestAmount: Double, EntryType: Bool,maxLimit:Int) {
         if checkTeamResponse.count > 0 {
            if EntryType == true {
                openViewController(controller: SelectMultipleTeamViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                                                vc.myTeamsData = self.checkTeamResponse
                                             vc.contestData = self.getMatchDetail
                                             vc.challengeid = challengeid
                                             vc.enteryFees = contestAmount
                                      vc.matchType = self.matchType
                    vc.maxTeam = maxLimit
                    
            }
            }
            else {
                   openViewController(controller: MyTeamViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                                 vc.myTeamsData = self.checkTeamResponse
                              vc.contestData = self.getMatchDetail
                              vc.challengeid = challengeid
                              vc.enteryFees = contestAmount
                       vc.matchType = self.matchType
                    vc.swtichTeam = false
               }
               }
         }
               else {
            if matchType == "CRICKET"{
                  openCreateTeamVC()

            }
            else if matchType == "BASKETBALL" {
                openKabaddiCreateTeamVC()
            }
            else {
                openFootballCreateTeamVC()
            }
        }
    }
    
    func openCreateTeamVC() {
           openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
               vc.contestData = self.getMatchDetail
               vc.teamNumber = "\(self.checkTeamResponse.count + 1)"
            
           }
       }
        func openKabaddiCreateTeamVC() {
            openViewController(controller: KABADDITeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                vc.contestData = self.getMatchDetail
                vc.teamNumber = "\(self.checkTeamResponse.count + 1)"
             
            }
        }
        func openFootballCreateTeamVC() {
                  openViewController(controller: FootballTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                      vc.contestData = self.getMatchDetail
                      vc.teamNumber = "\(self.checkTeamResponse.count + 1)"
                   
                  }
              }
}
extension DetailLeagueViewController:sendFilterData {
    func close() {
        checkClose = true
    }
    
    func sendData(entryArray: [Int], multiEntry: [Int], contestSize: [Int], winningEnrtry: [Int]) {
        self.entryArrays = entryArray
        self.multiEntryArrays = multiEntry
        self.contestSArrays = contestSize
        self.winningArrays = winningEnrtry
        checkClose = false
    }
    
    
}
