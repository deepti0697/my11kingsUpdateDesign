//
//  JoinedContestViewController.swift
//  Club11
//
//  Created by Developer on 28/05/19.
//

import UIKit
import Alamofire
import SwiftyJSON
protocol gotBacktoMyContest {
    func checkCondition(check:Bool)
}
class JoinedContestViewController: BaseClass {
    
    @IBOutlet weak var aNoDataLabel: UILabel!
   
    @IBOutlet weak var team2DisplayName: UILabel!
    
    @IBOutlet weak var team1displayName: UILabel!
   
 
    @IBOutlet weak var aTimeLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    
    var delegate:gotBacktoMyContest?
    var hometype:HomeType = .live
    var mactchType:String?
    var refreshControl = UIRefreshControl()
    var availableBalance = ""
    var usableBalaznce = ""
    var winnerBreakUpView: WinnerBreakupView?
    var confirmationView: ConfirmationView?
    var getTeamResponse = [MyTeamResponses]()
//    var myjoinedContestdata = [myjoinedContest]()
    var myJoinedLeagueData = [myjoinedContest]() {
        didSet {
            if myJoinedLeagueData.count == 0 {
                  setNoDataLabel()
//                   aNoDataLabel.isHidden = false
                
            }
            if aTableView != nil {
                aTableView.reloadDataInMainQueue()
                aNoDataLabel.isHidden = true
            }
            
        }
    }
    var contestData: Any?
    var matchKey = ""
    var releaseDate: NSDate?
    var countdownTimer = Timer()
   
   
    var tempCID = 0
    var tempFee = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.register(UINib(nibName: JoinedContestTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: JoinedContestTableViewCell.identifier())
     
        addPullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        addNavigationBar(navigationTitle: "Joined Contest", titleContentMode: .left, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
        self.navigationController?.isNavigationBarHidden = true
        
        setContestData()
        getMyTeamResponse()
       getMyContest()
        setNoDataLabel()
       
    }
    override func viewDidAppear(_ animated: Bool) {
          self.aTableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setNoDataLabel() {
        if aNoDataLabel != nil {
            aNoDataLabel.isHidden = myJoinedLeagueData.count == 0 ? false : true
            aNoDataLabel.text = myJoinedLeagueData.count == 0 ? "No Contest Join" : ""
        }
    }
    
    
    @IBAction func backButon(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(sender:AnyObject) {
      
     
        setNoDataLabel()
       getMyContest()
        aTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    fileprivate func setContestData() {
        if let contest = contestData as? MyContestLiveLeagues {
            matchKey = contest.matchkey ?? ""
            team1displayName.text = contest.team1display
            team2DisplayName.text = contest.team2display
            setReleaseTime(releaseDateString: contest.time_start ?? "0")
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
        let countdown = "\(Utility.getStringFrom(seconds: day))D \(Utility.getStringFrom(seconds: hour))H \(Utility.getStringFrom(seconds: minute))M \(Utility.getStringFrom(seconds: second))S"
        aTimeLabel.text = countdown
        if day == 0 && hour == 0 && minute == 0 && second == 0 {
            countdownTimer.invalidate()
        }
    }
    
    
    fileprivate func getMyContest() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = ["Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NzE1NTIyMiwiZXhwIjoxNTY3MTU4ODIyLCJuYmYiOjE1NjcxNTUyMjIsImp0aSI6Ilg2NDhIR2dOYmZhZ3Mwa0wiLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.-uUAhweU3nTAiUVByqC_fEq7XOnaPkQecF3VVDbNdYQ",
                       "Content-Type":"application/json",
                       "Accept":"application/json",
                       "cache-control": "no-cache"]
        
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["user_id":UserDic.value(forKey: "user_id"),
                         "matchkey":matchKey,
                         "showLeaderBoard":"false"
                ,"sport_key":mactchType]
            NetworkManager.post_Request2(urlService: kMyJoinedLeagueURL, param: param as [String : Any], head: headers) {
                (response) in
                
    
                self.hideActivityIndicator()
               
                do{
                    let json = try JSON(data:response as? Data ?? Data())
                    //                 let list = MyCatagries(json: json)
                    
                    let results = json["result"]
                    let cat = results["contest"]
                    //
                    
                    self.myJoinedLeagueData.removeAll()
                    for arr in cat.arrayValue{
                        self.myJoinedLeagueData.append(myjoinedContest(json:arr))
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                       
                        self.aTableView.reloadData()
                    }
                }
                    
                    
                    
                catch{
                    print(error.localizedDescription)
                }
            }
            
            
        }
    }
    fileprivate func getJoinedLeagues() {

    }
    
    override func handleBackButtonAction() {
        let vc = UIStoryboard(name: "MyMatches", bundle: nil).instantiateViewController(withIdentifier: "MyContestViewViewController") as! MyContestViewViewController
        vc.fromBack = true
              self.delegate?.checkCondition(check: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    fileprivate func viewCloseAction() {
       
    }
    
    func inviteAction(code: String) {
        let textToShare = [ "Here I challenge you to join my challenge Click \(APP_DEL.appStoreUrl) to download My11Kings app & use my code \(code) to Play with me." ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.mail ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func openTermsAndCondition(){
        openViewController(controller: TermAndConditionViewController.self, storyBoard: .moreStoryBoard, handler: { (vc) in
            
        })
    }
    
    
    
   
    
    
    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
       getMyContest()
        setNoDataLabel()
       
        
    }
    
    @IBAction func unwindToAddAccount(segue: UIStoryboardSegue) {
        getMyContest()
        setNoDataLabel()
      
       
    }
    
//    func openLeaderboard(challengeId: Int, league: JoinLeagueResponse, entreFee: Double) {
//        openViewController(controller: LeaderBooardViewController.self, storyBoard: .homeStoryBoard) { (vc) in
////            vc.matchKey = self.matchKey
////            vc.challengeId = challengeId
////            vc.league = league
////            vc.contestData = self.contestData
////            vc.myTeamsData = self.myTeamsData
////            vc.entreeFee = entreFee
////            vc.homeType = .upcomming
//        }
//    }
}

extension JoinedContestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myJoinedLeagueData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JoinedContestTableViewCell.identifier(), for: indexPath) as! JoinedContestTableViewCell
        let leagues = myJoinedLeagueData[indexPath.row]
        cell.configureCell(data: leagues)
        
        cell.inviteButtonClouser = {[weak self] iCode  in
            if let strongSelf = self {
                strongSelf.inviteAction(code: iCode)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kBannerTVCellIHeight
    }
    
    
    func openContestDetail(challengeIds: Int, leagues: myjoinedContest, entreFees: Int) {
           openViewController(controller: ContestDetailVCViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchKey = self.matchKey
               vc.challengeId = challengeIds
               vc.myContestResponse = leagues
            vc.ifFromJoinedContest = true
               vc.myTeamsData = self.getTeamResponse
               vc.entreeFee = entreFees
            vc.contestLiveData = self.contestData
            vc.matchOFType = self.mactchType ?? "CRIKCET"
               vc.homeType = self.hometype
           }
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cID = myJoinedLeagueData[indexPath.row].challenge_id, let fees = myJoinedLeagueData[indexPath.row].entryfee {
            openContestDetail(challengeIds: cID, leagues: myJoinedLeagueData[indexPath.row], entreFees: fees)
        }
    }
    fileprivate func getMyTeamResponse() {
    showActivityIndicator(sMessage: "Loading...")
    let headers = ["Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTQzODcxMCwiZXhwIjoxNTY1NDQyMzEwLCJuYmYiOjE1NjU0Mzg3MTAsImp0aSI6IkZEVGZKdTVIVW5PY0N0ZnIiLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.MTioWiGu5-5Itkw8Y-1lh08iAcYAvQhsUcpbFoLLmMg",
                   "Content-Type": "application/json",
                   "Accept":"application/json"]
    
    
    if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
        
        let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
        let param = ["user_id":UserDic.value(forKey: "user_id"),
                     "matchkey":matchKey,
                     "sport_key":mactchType]
        NetworkManager.post_Request2(urlService: kMyTeamURL, param:param as [String : Any] , head: headers) {
            (response) in
            
        
      
            self.hideActivityIndicator()
            
            do{
                let json = try JSON(data:response as? Data ?? Data())
                //                 let list = MyCatagries(json: json)
                
                let results = json["result"]
                let cat = results["teams"]
                //
                self.getTeamResponse.removeAll()
                for arr in cat.arrayValue{
                    self.getTeamResponse.append(MyTeamResponses(json:arr))
                    
                    
                }
            }
                
                
                
            catch{
                print(error.localizedDescription)
                self.view.makeToast(message: "Internal Error")
            }
        }
        }
        
    }
}
