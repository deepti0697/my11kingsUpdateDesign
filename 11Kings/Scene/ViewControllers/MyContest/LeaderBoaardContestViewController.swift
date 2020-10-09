//
//  LeaderBoaardContestViewController.swift
//  11Kings
//
//  Created by uu on 07/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LeaderBoaardContestViewController: BaseClass {

    var pdfURLStr = ""
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var USerDetail: UIButton!
    @IBOutlet weak var LeaderBoardData: UIButton!
    @IBOutlet weak var winnerRank: UIButton!
    @IBOutlet weak var aCollectionView: UICollectionView!
//    var matchType:String?
    var checkFromLeader = false
    override func viewDidLoad() {
        super.viewDidLoad()
        getLeaderBoard()
                                getWinnerBreakupData()
               getPlayerPointData()
       
    }
    var amountString:String?
    var homeType: HomeType = .upcomming
       var matchOFType = ""
          var refreshControl = UIRefreshControl()
          var availableBalance = ""
          var usableBalance = ""
          var confirmationView: ConfirmationView?
          var myTeamsData = [MyTeamResponses]()
        
          var entreeFee = 0
          var winnerBreakUpView: WinnerBreakupView?
          var contestData: GetMatchDetails?
        var contestLiveData:Any?
          var myContestResponse:myjoinedContest?
          var releaseDate: NSDate?
          var countdownTimer = Timer()
          var matchKey = ""
          var challengeId = 0
          var league: MyLeague?
        var joinedContest:myjoinedContest?
        var ifFromJoinedContest = false
          var leaderBoardArray = [GetLEaderBoardResponse]() {
              didSet {
    //              aTableView.reloadDataInMainQueue()
              }
          }
          var joinedID = 0
         
        
          var amount = ""
          var winning = ""
          var winners = ""
    var notFromPreview = false
       var referCode = ""
       var matchType = ""
       var winnerBrkupRespnse = [WinnerbreakUpResponse]() {
           didSet {
               aCollectionView.reloadDataInMainQueue()
           }
       }
       var challngeRespnse:ChallengeRespnse?
       var leaderREsponsefiltr = [GetLEaderBoardResponse]()
       var leaderREsponse = [GetLEaderBoardResponse]() {
           didSet {
//
           
               aCollectionView.reloadDataInMainQueue()
           }
       }
    
       var visibleCellIndex = 1 {
           didSet {
               moveSelectionView(index: visibleCellIndex)
           }
       }
    var playerpointData = [playerMatchPoint]() {
              didSet {
                  aCollectionView.reloadDataInMainQueue()
              }
          }
          
          var breakPoint = [PlayerPointBreakup]()
    override func viewWillAppear(_ animated: Bool) {
         setup()
         
        registerCell()
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        if !checkFromLeader {
        moveSelectionView(index: 1)
        aCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
    }
    }
    
    func downloadButtonAction() {
               let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
               guard let items = try? FileManager.default.contentsOfDirectory(atPath: path) else { return }
               
               for item in items {
                   // This can be made better by using pathComponent
                   let completePath = path.appending("/").appending(item)
                   try? FileManager.default.removeItem(atPath: completePath)
               }
               
               let url = URL(string: pdfURLStr)
               let fileName = String((url?.lastPathComponent ?? "")) as NSString
               // Create destination URL
               guard let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as? URL else {
                   return
               }
               let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
               //Create URL to the source file you want to download
        
        guard let fileURL = URL(string: pdfURLStr) else { return  }
               let sessionConfig = URLSessionConfiguration.default
               let session = URLSession(configuration: sessionConfig)
//               guard let u =  URLRequest(url:fileURL ) else {return}
               let request =  URLRequest(url:fileURL )
               let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                       // Success
                       if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                           print("\(statusCode)")
                           print("Successfully downloaded")
                       }
                       do {
                           try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                           do {
                               let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                               for indexx in 0..<contents.count {
                                   if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                       let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                     DispatchQueue.main.async {
                                       self.present(activityViewController, animated: true, completion: nil)
                                    }
                                   }
                               }
                           }
                           catch (let err) {
                               print("error: \(err)")
                           }
                       } catch (let writeError) {
                           DispatchQueue.main.async {
                           Loader.showToast(message: "File already exist", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                           print("\(writeError)")
                       }
                    }
                   } else {
                     DispatchQueue.main.async {
                       Loader.showToast(message: "Unable to find PDF", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                       print("\(error?.localizedDescription ?? "")")
                    }
                   }
               }
               task.resume()
           }
       
    func setup(){
        if let contest = contestLiveData as? MyContestLiveLeagues  {
                                  matchKey = contest.matchkey ?? ""
                       team1Name.text = "\(contest.team1display ?? "")"
                                  team2Name.text = "\(contest.team2display ?? "")"
          
                                 
                                 
                                   if homeType == .live
                                             {
                                                 timeLbl.text = "In Progress"
                                             }
                                             else {
                                                 timeLbl.text = "Winner declared"
                                             }
                              }
        amountLbl.text = amountString ?? ""
                   
               }
               
    
      func getPlayerPointData() {
            showActivityIndicator(sMessage: "Loading...")
            let headers = [
                "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDY2NTgyNywiZXhwIjoxNTY0NjY5NDI3LCJuYmYiOjE1NjQ2NjU4MjcsImp0aSI6IkswSnZlbnpDWlg3UVNTZk0iLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.pJlBD3x2VYb-aExN5kCMU4LWsl3Lgi1oG-WrccTuX04",
                "content-type": "application/json",
                "cache-control": "no-cache"
            ]
            if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                
                let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                let parameters = ["user_id": UserDic.value(forKey: "user_id") ?? "","matchkey": matchKey,"showLeaderBoard": "false"] as [String : Any]
                NetworkManager.post_Request2(urlService: kMatchPoint, param: parameters, head: headers) { (response) in
                    self.hideActivityIndicator()
                    do {
                        if response != nil {
                            let jsonDaaata = try JSON(data:response as! Data)
                            self.playerpointData.removeAll()
                            let result = jsonDaaata["result"]
                            for arr in result .arrayValue {
                                self.playerpointData.append(playerMatchPoint(json:arr))
                                
                            }
                            
                        }
                    }
                    catch {
                        
                    }
                }
                
            }
        }
    
    func getWinnerBreakupData() {
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
                            
                               
                           }
                               
                           catch {
                               Loader.showAlert(message: "Status code 500: server internal error")
                           }
                       }
                   }
               }
           }
        func getLeaderBoard() {
             showActivityIndicator(sMessage: "Loading...")
            if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                     let headers = [
                                   "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDQwNzYwNCwiZXhwIjoxNTY0NDExMjA0LCJuYmYiOjE1NjQ0MDc2MDQsImp0aSI6IlJVb25mSDlWcXloT1Q2WUQiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.ivVe5vYrh2rDWYt98PqKgswj4bgMgx-iggBhNE3JBPQ",
                                   "content-type": "application/json",
                                   "Accept": "application/json",
                                   "cache-control": "no-cache"
                                   
                               ]
                     let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                let parameters = ["challenge_id": challengeId, "matchkey": matchKey,"showLeaderBoard":"true","user_id": UserDic.value(forKey: "user_id") ?? "0"] as [String : Any]
                NetworkManager.post_Request2(urlService: kLeaderboardURL, param: parameters, head: headers) {
                    (response) in
                    self.hideActivityIndicator()
                    do {
                    if response != nil {
                        let jsonRes = try JSON(data:response as! Data)
                        let result = jsonRes["result"]
                        let contest = result["contest"]
                        self.leaderREsponse.removeAll()
                        
                        for arr in contest.arrayValue {
                            self.leaderREsponse.append(GetLEaderBoardResponse(json: arr))
                        }
                        if self.leaderREsponse.count == 0 {
                            self.view.makeToast(message: "We are Facing Problem.. we will be right back!")
                        }
                        
                    }
                }
                    catch {
                        self.view.makeToast(message: "Server Error")
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
        
       
        func openCreateTeamVC() {
            if matchOFType == "CRICKET" {
                openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                    vc.contestData = self.contestData
                  //  vc.teamNumber = "\(self.getTeamResponse.count + 1)"
                }
            }
            else if matchOFType == "BASKETBALL" {
                openViewController(controller: KABADDITeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                    vc.contestData = self.contestData
                  //  vc.teamNumber = "\(self.getTeamResponse.count + 1)"
                }
            }
            else {
                openViewController(controller: FootballTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                    vc.contestData = self.contestData
                  //  vc.teamNumber = "\(self.getTeamResponse.count + 1)"
                }
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
            let countdown = "\(Utility.getStringFrom(seconds: day))D: \(Utility.getStringFrom(seconds: hour))H: \(Utility.getStringFrom(seconds: minute))M: \(Utility.getStringFrom(seconds: second))S"
            timeLbl.text = countdown
            
            if day == 0 && hour == 0 && minute == 0 && second == 0 {
                countdownTimer.invalidate()
            }
        }
        
           
        fileprivate func moveSelectionView(index: Int) {
              
               switch index {
               //Live
               case 0:
                  self.LeaderBoardData.setBackgroundImage(nil, for: .normal)
                                  self.USerDetail.setBackgroundImage(nil, for: .normal)
                                  USerDetail.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
                                  LeaderBoardData.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
                                 
                
                                 
                   UIView.animate(withDuration: 0.2) {
                    
                    self.winnerRank.imageView?.contentMode = .scaleToFill
                    self.winnerRank.setBackgroundImage(#imageLiteral(resourceName: "Path 22587"), for: .normal)
                    self.winnerRank.setTitleColor(UIColor(red: 20, green: 20, blue: 20), for: .normal)
                       
                   }
               //upcoming
               case 1:
                    self.winnerRank.setBackgroundImage(nil, for: .normal)
                    self.USerDetail.setBackgroundImage(nil, for: .normal)
                    USerDetail.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
                    winnerRank.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
                   
                  
                   UIView.animate(withDuration: 0.2) {
                       self.LeaderBoardData.imageView?.contentMode = .scaleToFill
                                                         self.LeaderBoardData.setBackgroundImage(#imageLiteral(resourceName: "Path 22587"), for: .normal)
                                                     self.LeaderBoardData.setTitleColor(UIColor(red: 20, green: 20, blue: 20), for: .normal)
                                             
                       
                   }
                case 2:
                    self.winnerRank.setBackgroundImage(nil, for: .normal)
                    self.LeaderBoardData.setBackgroundImage(nil, for: .normal)
                    LeaderBoardData.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
                    winnerRank.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
                   
                                  
                                 
                                  UIView.animate(withDuration: 0.2) {
                                      
                                      self.USerDetail.imageView?.contentMode = .scaleToFill
                                                                                              self.USerDetail.setBackgroundImage(#imageLiteral(resourceName: "Path 22587"), for: .normal)
                                                                                          self.USerDetail.setTitleColor(UIColor(red: 20, green: 20, blue: 20), for: .normal)
                }
               default:
                   break
               }
           }
           
        @IBAction func winningBreakup(_ sender: Any) {
            moveSelectionView(index: 0)
             aCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        @IBAction func LeaderBoard(_ sender: Any) {
            moveSelectionView(index: 1)
             aCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        }
    func registerCell() {
          aCollectionView.register(UINib(nibName: ContestDetailCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: ContestDetailCollectionViewCell.identifier())
          
           aCollectionView.register(UINib(nibName: LeaderboardCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: LeaderboardCollectionViewCell.identifier())
         aCollectionView.register(UINib(nibName: PlayerCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: PlayerCollectionViewCell.identifier())
      }
    
    @IBAction func userDetail(_ sender: Any) {
        moveSelectionView(index: 2)
                    aCollectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func walletButton(_ sender: Any) {
        openViewController(controller: AccountCollectinViewController.self, storyBoard: .accountStoryBoard) { (vc) in
               }
    }
    @IBAction func openNotificaton(_ sender: Any) {
        openViewController(controller: NotificationViewController.self, storyBoard: .homeStoryBoard) { (vc) in
               }
    }
}
       
    
//}
extension LeaderBoaardContestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContestDetailCollectionViewCell.identifier(), for: indexPath) as! ContestDetailCollectionViewCell

         let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: LeaderboardCollectionViewCell.identifier(), for: indexPath) as! LeaderboardCollectionViewCell

        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCollectionViewCell.identifier(), for: indexPath) as! PlayerCollectionViewCell
        cell1.delegate = self
        cell2.delegate = self
        cell1.pdf = {[weak self]  in
                                              if let strongSelf = self {
                                                  strongSelf.downloadButtonAction()
                                              }
                                          }
                       
              switch indexPath.item {
              case 0:
                cell.homeType = homeType
                if winnerBrkupRespnse.count > 0 {
                    
                  cell.winnerBreakupArr = winnerBrkupRespnse
                    return cell
                }
                else {
                    if winnerBrkupRespnse.count == 0 {
                     cell.winnerBreakupArr = winnerBrkupRespnse
                   
                }
                   return cell
                  }
              case 1 :
                cell1.homeType = homeType
                if leaderREsponse.count > 0 {
                     cell1.compareView.isHidden = false
                    cell1.homeType = homeType
                    cell1.leaderBoardRespnse = leaderREsponse
                    return cell1
                }
                   
                else {
                    cell1.compareView.isHidden = true

                                                      return cell1
                    
                }
               
              case 2 :
                               if playerpointData.count > 0 {
                                cell2.playerpointData = self.playerpointData
                                   return cell2
                               }
                               else {
                                 cell.showNoDataLabel(show: true, text: "No data")
                                   return cell2
                               }
                                
                               
             
              default:
                
                
                cell.showNoDataLabel(show: true, text: "No data")
              return cell
              
       
    }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: aCollectionView.frame.width, height: aCollectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           visibleCellIndex = Utility.findCenterCellIndex(collectionView: aCollectionView)
       }
    public func collectionView(_ collectionView: UICollectionView, layout
       collectionViewLayout: UICollectionViewLayout,
       minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
    
}
extension  LeaderBoaardContestViewController:openLEaderBoardPrview {
    func sendDatatoComapreTeam(team1ID: Int, team2ID: Int, challengeID: Int, userID: Int) {
        openViewController(controller: CompareTeamViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchType = self.matchType
            vc.team1ID = team1ID
            vc.team2ID = team2ID
            vc.challenge = challengeID
            vc.userID   = userID
            vc.matchKey = self.matchKey
            vc.matchType = self.matchOFType
            
        }
    }
    

    
    func sendLEaderBoardPReviewData(teamID: Int, challengeID: Int, userID: Int) {
        if matchOFType.uppercased() == "CRICKET" || matchOFType == "Cricket" {
             openTeamPreview(teamID: teamID, challengeID: challengeID, userID: userID)
        }
        else if matchOFType.uppercased() == "FOOTBALL" || matchOFType == "Football"{
            openFootball(teamID: teamID, challengeID: challengeID, userID: userID)
        }
        else {
            openKabaddiPreview(teamID: teamID, challengeID: challengeID, userID: userID)
        }
    }

    func openTeamPreview(teamID: Int, challengeID: Int, userID: Int) {
           openViewController(controller: PreviewViewController.self, storyBoard: .homeStoryBoard) { (vc) in
               vc.teamId = teamID
               vc.contestData = self.contestData
               vc.isFromLeaderBoard = true
               vc.challengeID = challengeID
           }
       }
    func openKabaddiPreview(teamID: Int, challengeID: Int, userID: Int) {
              openViewController(controller: KabaddiPreviewViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                  vc.teamId = teamID
                  vc.contestData = self.contestData
                  vc.isFromLeaderBoard = true
                  vc.challengeID = challengeID
              }
          }
    func openFootball(teamID: Int, challengeID: Int, userID: Int) {
                 openViewController(controller: FootballPreviewViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                     vc.teamId = teamID
                     vc.contestData = self.contestData
                     vc.isFromLeaderBoard = true
                     vc.challengeID = challengeID
                 }
             }
    func openplayerDetail(playeer:playerMatchPoint) {
           openViewController(controller: PlayerMatchPointDetail.self, storyBoard: .homeStoryBoard) { (vc) in
               vc.matchKey = self.matchKey
               vc.playerInfoData = playeer
            vc.delegate = self
           }
       }
 }
extension LeaderBoaardContestViewController:playerData,BackToleaderBoard {
    func checkFromPlayer() {
        checkFromLeader = true
    }
    
    func sendPlayerInfo(player: playerMatchPoint) {
        openplayerDetail(playeer: player)
    }
    
    
}
