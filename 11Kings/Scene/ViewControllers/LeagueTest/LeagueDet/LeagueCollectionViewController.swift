//
//  LeagueCollectionViewController.swift
//  DreamTeam
//
//  Created by Test on 15/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LeagueCollectionViewController: BaseClass {
    
    var winnerBreakUpView: WinnerBreakupView?
    @IBOutlet weak var EnterImageView: UIImageView!
    @IBOutlet weak var winnerImageView: UIImageView!
    @IBOutlet weak var spotImageView: UIImageView!
    @IBOutlet weak var prizePoolImageView: UIImageView!
    @IBOutlet weak var myTeamView: UIView!
    @IBOutlet weak var myContestView: UIView!
    @IBOutlet weak var contestView: UIView!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var myTeam: UIButton!
    @IBOutlet weak var colctnView: UICollectionView!
    @IBOutlet weak var contest: UIButton!
    @IBOutlet weak var myContest: UIButton!
    @IBOutlet weak var allContestView : UIView!
    
    var joined_leagues:Int?
    var total_contest : Int?
    var user_teams : Int?
    var confirmationView: ConfirmationView?
    var contestData:GetMatchDetails?
    var getContestDetail:GetMatchDetails?
    var matchKey:String?
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var tempCID = 0
    var tempFees = 0.0
    var availableBalance = ""
    var usableBalance = ""
    var totalLeagues = [MyLeague]()
    var contestInviteView: ContestInvieteCodeView?
    var checkEditVc = false
    var winnerBrkupRespnse = [WinnerbreakUpResponse]()
    var getTeamResponse = [MyTeamResponses]()
    var tempMsgResp = [MessageResponses]()
    var storeIn = 0
    var matchTYPES:String?
    var totalAmountString:String?
    var refreshControl = UIRefreshControl()
    
    var myjoinedContestdata = [myjoinedContest]() {
        didSet {
            colctnView.reloadDataInMainQueue()
        }
    }
    var getCategories = [MyCatagries]() {
        didSet {
            colctnView.reloadDataInMainQueue()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colctnView.delegate = self
        self.colctnView.dataSource = self
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        colctnView.setCollectionViewLayout(lay, animated: true)
        colctnView.bounces = false
        colctnView.isPagingEnabled = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        totalAmount.text = totalAmountString
        registerCell()
        setContestData()
//        getAllTotalLeague()
        getLeagues()
        getMyContest()
        getMyTeamResponse()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func handleWalletButtonAction() -> Void {
        
    }
    
   
    fileprivate func setContestData() {
        if let getcontestdata = getContestDetail {
            team1Name.text = getcontestdata.team1display
            team2Name.text = getcontestdata.team2display
            matchKey = getcontestdata.matchkey
            
            if let time = getcontestdata.time_start {
                setReleaseTime(releaseDateString: time)
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
        let countdown = "\(Utility.getStringFrom(seconds: day))D : \(Utility.getStringFrom(seconds: hour))H : \(Utility.getStringFrom(seconds: minute))M : \(Utility.getStringFrom(seconds: second))S"
        timeLbl.text = countdown
        
        if day == 0 && hour == 0 && minute == 0 && second == 0 {
            countdownTimer.invalidate()
        }
    }
    var visibleCellIndex = 0 {
        didSet {
            moveSelectionView(index: visibleCellIndex)
        }
    }
    func openKabaddiCreateTeamVC() {
        openViewController(controller: KABADDITeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.getContestDetail
            vc.teamNumber = "\(self.getTeamResponse.count + 1)"
        }
    }
    func openFootballCreateTeamVC() {
        openViewController(controller: FootballTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.getContestDetail
            vc.teamNumber = "\(self.getTeamResponse.count + 1)"
        }
    }
    func openCreateTeamVC() {
        openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.getContestDetail 
            vc.teamNumber = "\(self.getTeamResponse.count + 1)"
        }
    }
    func openKabbadiTeamVC() {
        openViewController(controller: KABADDITeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.getContestDetail
            vc.teamNumber = "\(self.getTeamResponse.count + 1)"
        }
    }
    
    func openFootballTeamVC() {
        openViewController(controller: FootballTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.getContestDetail
            vc.teamNumber = "\(self.getTeamResponse.count + 1)"
        }
    }
    
    func openCreateLEague () {
           openViewController(controller: CreateContestViewController.self, storyBoard: .homeStoryBoard) { (vc) in
               vc.contestData = self.getContestDetail
               vc.matchKey = self.matchKey ?? ""
               vc.matchType = self.matchTYPES ?? "CRICKET"
               
           }
       }
       func openTermsAndCondition(){
           openViewController(controller: TermAndConditionViewController.self, storyBoard: .moreStoryBoard, handler: { (vc) in
               
           })
       }
       
    
    func openTemVc() {
        if matchTYPES == "CRICKET" {
            openCreateTeamVC()
        }
        else if matchTYPES == "BASKETBALL" {
            openKabaddiCreateTeamVC()
        }
        else {
            openFootballCreateTeamVC()
        }
    }
    
    
    
    /// - Action
    @IBAction func openCreateTeamVC(_ sender: Any) {
        
        
    }
    
    @IBAction func notification(_ sender: Any) {
           openViewController(controller: NotificationViewController.self, storyBoard: .homeStoryBoard) { (vc) in
           }
       }
       
       @IBAction func backButton(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
       }
    
       @IBAction func walletAction(_ sender: Any) {
           openViewController(controller: AccountCollectinViewController.self, storyBoard: .accountStoryBoard) { (vc) in
           }
       }
       
    
    @IBAction func myTeam(_ sender: Any) {
        myTeam.flash()
        colctnView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 2)
        storeIn = 2
    }
    @IBAction func myContest(_ sender: Any) {
        myContest.flash()
        colctnView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 1)
    }
    
    @IBAction func contestbyMatchKey(_ sender: Any) {
        contest.flash()
        colctnView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 0)
        storeIn = 0
    }
    
    @IBAction func mywallet(_ sender: Any) {
    }
    
    @IBAction func backtoHome(_ sender: Any) {
    }
    
    @IBAction func enteraCodeButton(_ sender: Any) {
        
    }
    
    @IBAction func createLeague(_ sender: Any) {
           
       }
      
    @IBAction func changeBywinner(_ sender: UIButton) {
       }
       
       @IBAction func entryvalue(_ sender: UIButton) {
       }
    
       @IBAction func changeValuebySpot(_ sender: UIButton) {
       }
    
       @IBAction func prizeValueChange(_ sender: UIButton) {
       }
    
       @IBAction func prizePool(_ sender: UIButton) {
       }
    
    func openInviteCode() {
        openViewController(controller: ContestInviteCodeViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            
        }
    }
    func openContestInviteView() {
        if contestInviteView == nil {
            contestInviteView = Bundle.main.loadNibNamed("ContestInvieteCodeView", owner: self, options: nil)?.first as? ContestInvieteCodeView
            contestInviteView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            APP_DEL.window?.addSubview(contestInviteView!)
            contestInviteView?.joinContestButtonClouser = { [weak self] code in
                if let strongSelf = self {
                    strongSelf.getopenCode(code:code)
                }
            }
            contestInviteView?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.viewCloseAction()
                }
            }
        }
    }
    
    fileprivate func viewCloseAction() {
        winnerBreakUpView?.removeFromSuperview()
             winnerBreakUpView = nil
        contestInviteView?.removeFromSuperview()
        contestInviteView = nil
        confirmationView?.removeFromSuperview()
        confirmationView = nil
    }
    
   
   
   
    fileprivate func moveSelectionView(index: Int) {
        
        switch index {
        //Live
        case 0:
            //            myContestView.removeFromSuperlayer()
            self.myTeam.setBackgroundImage(nil, for: .normal)
            self.myContest.setBackgroundImage(nil, for: .normal)
            myContest.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            myTeam.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            myTeamView.backgroundColor = UIColor(red: 185, green: 33, blue: 36)
            //            myContestView.backgroundColor = UIColor(red: 185, green: 33, blue: 36)
            
            
            UIView.animate(withDuration: 0.2) {
                self.contest.imageView?.contentMode = .scaleToFill
                self.contest.setBackgroundImage(#imageLiteral(resourceName: "Path 22587"), for: .normal)
                self.contest.setTitleColor(UIColor(red: 20, green: 20, blue: 20), for: .normal)
                
            }
        //upcoming
        case 1:
            self.contest.setBackgroundImage(nil, for: .normal)
            self.myTeam.setBackgroundImage(nil, for: .normal)
            //             myTeamLayer.removeFromSuperlayer()
            //             self.myContestView.applyGradient(colours: [UIColor(red: 255, green: 253, blue: 166),UIColor(red: 172, green: 135, blue: 54)])
            contest.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            myTeam.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            myTeamView.backgroundColor = UIColor(red: 185, green: 33, blue: 36)
            contestView.backgroundColor = UIColor(red: 185, green: 33, blue: 36)
            
            UIView.animate(withDuration: 0.2) {
                
                self.myContest.imageView?.contentMode = .scaleToFill
                self.myContest.setBackgroundImage(#imageLiteral(resourceName: "Path 22587"), for: .normal)
                self.myContest.setTitleColor(UIColor(red: 20, green: 20, blue: 20), for: .normal)
                
            }
        //Result
        case 2:
            self.contest.setBackgroundImage(nil, for: .normal)
            self.myContest.setBackgroundImage(nil, for: .normal)
            contestView.backgroundColor = UIColor(red: 185, green: 33, blue: 36)
            //            myContestView.backgroundColor = UIColor(red: 185, green: 33, blue: 36)
            myContest.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            contest.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.myTeam.imageView?.contentMode = .scaleToFill
                self.myTeam.setBackgroundImage(#imageLiteral(resourceName: "Path 22587"), for: .normal)
                self.myTeam.setTitleColor(UIColor(red: 20, green: 20, blue: 20), for: .normal)
            }
        default:
            break
        }
    }
    
    
    @IBAction func mycontestViewController(_ sender: Any) {
        // openViewController(controller: JoinedContestViewController.self, storyBoard: .homeStoryBoard) { (vc) in
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        visibleCellIndex = Utility.findCenterCellIndex(collectionView: colctnView)
    }
    
    
    func registerCell() {
        colctnView.register(UINib(nibName: LeagueContestCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: LeagueContestCollectionViewCell.identifier())
        colctnView.register(UINib(nibName: JoinedContestCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: JoinedContestCollectionViewCell.identifier())
        colctnView.register(UINib(nibName: MyTeamResponseCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: MyTeamResponseCollectionViewCell.identifier())
    }
    
    fileprivate func getopenCode(code:String) {
           showActivityIndicator(sMessage: "Loading...")
           let headers = [
               "content-type": "application/json",
               "Accept": "application/json"]
           
           if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
               
               let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
               let param = ["user_id":UserDic.value(forKey: "user_id"),
                            "getcode":code]
               NetworkManager.post_Request2(urlService: kJoinedByCode, param: param as [String : Any], head: headers)  { (response) in
                   
                   self.hideActivityIndicator()
                   guard let data = response else { return }
                   do{
                       let json = try JSON(data:data as! Data)
                       //                 let list = MyCatagries(json: json)
                       let status = json["status"].intValue
                       let results = json["message"].stringValue
                       
                       
                       //                    let messageStr =   MessageResponses(json:results)
                       
                       if status == 1 {
                           
                           Loader.showToast(message:  results, onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 22)
                           )
                           self.viewCloseAction()
                       }
                       else {
                           Loader.showToast(message: results , onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80)
                           )
                           self.viewCloseAction()
                       }
                       
                   }
                       
                       
                       
                   catch{
                       self.view.makeToast(message: "Internal Error")
                   }
               }
               
               
           }
       }
    
    fileprivate func getLeagues() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Content-Type":"application/json"]
        
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["user_id":UserDic.value(forKey: "user_id"),
                         "matchkey":matchKey,
                         "showLeaderBoard":"false"
                ,"sport_key":matchTYPES]
            
            NetworkManager.post_Request2(urlService: kGetChallengeURL, param: param as [String : Any], head: headers)  { (response) in
                
                self.hideActivityIndicator()
                guard let data = response else { return }
                do{
                    let json = try JSON(data:data as! Data)
                    
                    let results = json["result"]
                    let cat = results["categories"]
                    self.total_contest =  results["total_contest"].intValue
                    self.joined_leagues = results["joined_leagues"].intValue
                    self.user_teams = json["user_teams"].intValue
                    
                    self.getCategories.removeAll()
                    
                    for arr in cat.arrayValue{
                        self.getCategories.append(MyCatagries(json:arr)!)
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        if self.getCategories.count > 0 {
                        }
                        else {
                            
                        }
                        self.colctnView.reloadData()
                    }
                }
                    
                    
                    
                catch{
                    Loader.showAlert(message: "Inernal Error")
                    print(error.localizedDescription)
                }
            }
            
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
                ,"sport_key":matchTYPES]
            NetworkManager.post_Request2(urlService: kMyJoinedLeagueURL, param: param as [String : Any], head: headers)  { (response) in
                
                self.hideActivityIndicator()
                guard let data = response else {
                    self.view.makeToast(message: "We are Facing Problem.. we will be right back!")
                    return
                    
                }
                do{
                    let json = try JSON(data:data as! Data)
                    //                 let list = MyCatagries(json: json)
                    
                    let results = json["result"]
                    let cat = results["contest"]
                    //
                    self.myjoinedContestdata.removeAll()
                    for arr in cat.arrayValue{
                        self.myjoinedContestdata.append(myjoinedContest(json:arr))
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.colctnView.reloadData()
                        if self.myjoinedContestdata.count > 0 {
                            self.myContest.setTitle("My Contests (\(self.myjoinedContestdata.count))", for: .normal)
                        }
                        
                    }
                }
                    
                    
                    
                catch{
                    self.view.makeToast(message: "We are Facing Problem.. we will be right back!")
                    Loader.showAlert(message: "Internal Error")
                }
            }
            
            
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
                         "sport_key":matchTYPES]
            NetworkManager.post_Request2(urlService: kMyTeamURL, param: param as [String : Any], head: headers)  { (response) in
                self.hideActivityIndicator()
                guard let data = response else {
                    self.view.makeToast(message: "We are Facing Problem.. we will be right back!")
                    return }
                do{
                    let json = try JSON(data:data as! Data)
                    let results = json["result"]
                    let cat = results["teams"]
                    
                    self.getTeamResponse.removeAll()
                    for arr in cat.arrayValue{
                        self.getTeamResponse.append(MyTeamResponses(json:arr))
                        
                        
                    }
                    DispatchQueue.main.async {
                        
                        self.colctnView.reloadData()
                        if self.getTeamResponse.count > 0 {
                            self.myTeam.setTitle("MyTeams (\(self.getTeamResponse.count))", for: .normal)
                            
                        }
                    }
                }
                    
                catch{
                   self.view.makeToast(message: "We are Facing Problem.. we will be right back!")
                                           
                    print(error.localizedDescription)
                }
                
            }
            
            
        }
    }
    
   
    
}


extension LeagueCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeagueContestCollectionViewCell.identifier(), for: indexPath) as! LeagueContestCollectionViewCell
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: JoinedContestCollectionViewCell.identifier(), for: indexPath) as! JoinedContestCollectionViewCell
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: MyTeamResponseCollectionViewCell.identifier(), for: indexPath) as! MyTeamResponseCollectionViewCell
        //        cell.check()
        cell1.delgate = self
        cell2.delgate = self
        cell.getContestDetailA = getContestDetail
        if getCategories.count > 0 {
            cell.contestDatas = getCategories
            
            cell.showNoDataLabel(show: false, text: "", image: UIImage(), text2: "", buttonText: "", showButton: false)
            
        }
        if getTeamResponse.count > 0 {
            //              self.createButton.isHidden = false
            cell.teamResponse = getTeamResponse
            cell.showNoDataLabel(show: false, text: "", image:UIImage(), text2: "", buttonText: "", showButton: false )
            
            
        }
        if myjoinedContestdata.count > 0 {
            //                    self.createButton.isHidden = true
            cell1.joinLeague = myjoinedContestdata
            cell1.showNoDataLabel(show: false, text: "", image:UIImage(), text2: "", buttonText: "", showButton: false )
            
        }
        switch indexPath.item {
        case 0:
            cell.createTeamButton = {[weak self]  in
                if let strongSelf = self {
                    strongSelf.openTemVc()
                }
            }
            cell.createLeague = {[weak self]  in
                if let strongSelf = self {
                    strongSelf.openCreateLEague()
                }
            }
            cell.enterContestCode =  {[weak self]  in
                if let strongSelf = self {
                    strongSelf.openInviteCode()
                }
            }
            if getCategories.count > 0 {
                cell.itematIndex = indexPath.item
                cell.delgate = self
                cell.totalContest = "\(total_contest ?? 0)"
                cell.contestDatas = getCategories
//                cell.totalLeagueData = totalLeagues
                //                cell.totalContest = getCategories.count
                cell.showNoDataLabel(show: false, text: "", image: UIImage(), text2: "", buttonText: "", showButton: false)
                return cell
            }
                
            else {
                cell.itematIndex = indexPath.item
                cell.delgate = self
                //              self.createButton.isHidden = true
                cell.showNoDataLabel(show: true, text: "No Match Found", image: #imageLiteral(resourceName: "no_match"), text2: "", buttonText: "", showButton: false)
                return cell
            }
        case 1 :
            
            cell1.hiddenButton =  {[weak self]  in
                if let strongSelf = self {
                    strongSelf.moveSelectionView(index: 0)
                    self?.colctnView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
                }
            }
            
            if myjoinedContestdata.count > 0 {
                //                    self.createButton.isHidden = true
                cell1.joinLeague = myjoinedContestdata
                cell1.showNoDataLabel(show: false, text: "", image:UIImage(), text2: "", buttonText: "", showButton: false )
                return cell1
            }
            else {
                //                  self.createButton.isHidden = true
                cell.showNoDataLabel(show: true, text: "Find a Contest to join and start winning", image: #imageLiteral(resourceName: "Group 1352"), text2: "You haven't joined a any contest yet", buttonText: "Joined Contest", showButton: true)
                return cell1
            }
        case 2 :
            cell2.matchType = matchTYPES ?? "CRICKET"
            cell2.createTeamButton = {[weak self]  in
                if let strongSelf = self {
                    strongSelf.openTemVc()
                }
            }
            if getTeamResponse.count > 0 {
                //              self.createButton.isHidden = false
                cell2.teamResponse = getTeamResponse
                cell2.showNoDataLabel(show: false, text: "", image:UIImage(), text2: "", buttonText: "", showButton: false )
                
                return cell2
            }
            else {
                cell2.showNoDataLabel(show: true, text: "No Upcomming Match Found", image: #imageLiteral(resourceName: "Group 1237"), text2: "You haven't created a any team yet", buttonText: "Create Team 1", showButton: true)
                return cell2
            }
        default:
            cell.showNoDataLabel(show: true, text: "No Upcomming Match Found", image: UIImage(), text2: "", buttonText: "", showButton: false)
            return cell
        }
        
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    public func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



// Open VC Protocol for League Collection View cell class from we get contest Details
// OpenContestDetail VC For My joined Contest Cell class
// Open MyTeam Vc for Myteam Cell

extension LeagueCollectionViewController:OpenVC,openContestDetailVc,openMyTeamVc {
    func openMyTeamVC(entryFee: Double, challengeID: Int, isMultiEntry: Bool, maxTeaLimit: Int) {
        if isMultiEntry == true {
            openViewController(controller: SelectMultipleTeamViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                vc.myTeamsData = self.getTeamResponse
                vc.contestData = self.getContestDetail
                vc.challengeid = challengeID
                vc.enteryFees = entryFee
                vc.matchType = self.matchTYPES ?? "CRICKET"
                vc.maxTeam = maxTeaLimit
            }
        }
        else {
            openViewController(controller: MyTeamViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                vc.myTeamsData = self.getTeamResponse
                vc.contestData = self.getContestDetail
                vc.challengeid = challengeID
                vc.enteryFees = entryFee
                vc.matchType = self.matchTYPES ?? "CRICKET"
                
            }
            
        }
    }
    
    func openAllContest() {
        openViewController(controller: DetailLeagueViewController.self, storyBoard: .homeStoryBoard) { (vc) in
//            vc.leagueData = self.totalLeagues
            vc.mycategories = self.getCategories
            vc.getMatchDetail = self.getContestDetail
            vc.checkTeamResponse = self.getTeamResponse
            vc.matchType = self.matchTYPES ?? "CRICKET"
            vc.comingFromAllContest = true
        }
        
    }
    
    
    func openJoinedContestORCreateTeam() {
        if getTeamResponse.count > 0 {
            
        }
        else {
            if matchTYPES == "CRICKET" {
                openCreateTeamVC()
            }
            else if matchTYPES == "BASKETBALL" {
                openKabaddiCreateTeamVC()
            }
            else {
                openFootballCreateTeamVC()
            }
        }
        
    }
    
    
    
    
    func openContestDetail(challengeId: Int, league: myjoinedContest, entreFee: Int) {
        openContestMyjoinedDetail(challengeIds: challengeId, leagues: league, entreFees: entreFee,leagueType:"MyJoinedContest")
    }
    func openLederboard(challengeId: Int, league: MyLeague, entreFee: Int) {
        openContestDetail(challengeIds: challengeId, leagues: league, entreFees: entreFee, leagueType: "Contest")
    }
    func openLeaderboards(challengeIds: Int, leagues: MyLeague, entreFees: Int) {
        //        openViewController(controller: LeaderBooardViewController.self, storyBoard: .homeStoryBoard) { (vc) in
        //            vc.matchKey = self.matchKey ?? ""
        //            vc.challengeId = challengeIds
        //            vc.league = leagues
        //            vc.contestData = self.contestData
        //            vc.myTeamsData = self.getTeamResponse
        //            vc.entreeFee = entreFees
        //            //vc.homeType = self.homeType
        //        }
    }
    func openContestDetail(challengeIds: Int, leagues: MyLeague, entreFees: Int,leagueType:String) {
        openViewController(controller: ContestDetailVCViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchKey = self.matchKey ?? ""
            vc.challengeId = challengeIds
            vc.league = leagues
            vc.contestData = self.getContestDetail
            vc.myTeamsData = self.getTeamResponse
            vc.entreeFee = entreFees
            vc.leagueType = leagueType
            vc.matchOFType = self.matchTYPES ?? "CRICKET"
            vc.amountText = self.totalAmountString
            
            //vc.homeType = self.homeType
        }
    }
    func openContestMyjoinedDetail(challengeIds: Int, leagues: myjoinedContest, entreFees: Int,leagueType:String) {
        openViewController(controller: ContestDetailVCViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchKey = self.matchKey ?? ""
            vc.challengeId = challengeIds
            vc.myContestResponse = leagues
            vc.contestData = self.getContestDetail
            vc.myTeamsData = self.getTeamResponse
            vc.entreeFee = entreFees
            vc.leagueType = leagueType
            vc.matchOFType = self.matchTYPES ?? "CRICKET"
            vc.amountText = self.totalAmountString
        }
    }
    func openpreview(getTeamRespons: MyTeamResponses,teamName:String,teamIDs: Int) {
        if matchTYPES == "CRICKET" {
            openViewController(controller: PreviewViewController.self, storyBoard: .homeStoryBoard, handler: { (vc) in
                vc.getTeamResponse = getTeamRespons
                vc.teamName = teamName
                vc.isComingFromMyteam = true
                vc.teamID = teamIDs
                
                vc.getContestDetail = self.getContestDetail
                
                
            })
        }
        else if matchTYPES == "FOOTBALL" {
            openViewController(controller: FootballPreviewViewController.self, storyBoard: .homeStoryBoard, handler: { (vc) in
                vc.getTeamResponse = getTeamRespons
                vc.matchKey = self.matchKey ?? ""
                vc.teamId = teamIDs
                vc.teamName = teamName
                vc.contestData = self.getContestDetail
                //                      vc.teamName = teamName
                vc.isComingFromMyteam = true
            })
        }
        else {
            openViewController(controller: KabaddiPreviewViewController.self, storyBoard: .homeStoryBoard, handler: { (vc) in
                vc.getTeamResponse = getTeamRespons
                //                vc.matchKey = self.matchKey ?? ""
                vc.teamId = teamIDs
                vc.teamName = teamName
                vc.contestData = self.getContestDetail
                //                      vc.teamName = teamName
                vc.isComingFromMyteam = true
            })
        }
    }
    
    func openCaptainVc(check: Bool) {
        self.checkEditVc = check
    }
    
    func openEditTeam(arrayOfInt: [Int], vc: Int, cap: Int, teamID: Int, checktype: Bool) {
        if matchTYPES == "CRICKET" {
            openEditVc(arryOfPlayer :arrayOfInt,viceCaptainID : vc,captainID :cap, teamIDs: teamID, check: checktype)
        }
        else if matchTYPES == "BASKETBALL" {
            openKabaddiEditVc(arryOfPlayer: arrayOfInt, viceCaptainID: vc, captainID: cap, teamIDs: teamID, check: checktype)
        }
        else {
            openFootballEditVc(arryOfPlayer: arrayOfInt, viceCaptainID: vc, captainID: cap, teamIDs: teamID, check: true)
        }
    }
    
    
    func openKabaddiEditVc(arryOfPlayer :[Int],viceCaptainID : Int,captainID :Int,teamIDs:Int,check:Bool) {
        openViewController(controller: KABADDITeamViewController.self, storyBoard: .teamStoryBoard, handler: { (vc) in
            vc.arrayOFPlayer  = arryOfPlayer
            vc.contestData = self.getContestDetail
            vc.viceCaptian = viceCaptainID
            vc.Captain = captainID
            vc.teamId = teamIDs
            vc.fromEditVC = check
            vc.matchKey = self.matchKey ?? ""
        })
    }
    func openFootballEditVc(arryOfPlayer :[Int],viceCaptainID : Int,captainID :Int,teamIDs:Int,check:Bool) {
        openViewController(controller: FootballTeamViewController.self, storyBoard: .teamStoryBoard, handler: { (vc) in
            vc.arrayOFPlayer  = arryOfPlayer
            vc.contestData = self.getContestDetail
            vc.viceCaptian = viceCaptainID
            vc.Captain = captainID
            vc.teamId = teamIDs
            vc.fromEditVC = check
            vc.matchKey = self.matchKey ?? ""
        })
    }
    
    func openwinnerBreakup(challenge_id: Int, matchKey: String, amount: Double) {
        getWinnerBreakupData(challengeId: challenge_id, ammount: amount,matchKey:matchKey)
    }
    
    func openEditVc(arryOfPlayer :[Int],viceCaptainID : Int,captainID :Int,teamIDs:Int,check:Bool){
        openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard, handler: { (vc) in
            vc.arrayOfPlayer  = arryOfPlayer
            vc.contestData = self.getContestDetail
            vc.viceCaptainID = viceCaptainID
            vc.captainID = captainID
            vc.teamID = teamIDs
            vc.isFromEdit = check
            //            vc.fromEditVC = self.checkEditVc
        })
    }
    
    
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
    
    
    func openTermsAndConditionVC() {
        self.openTermsAndCondition()
    }
    func  openCreateTeamViewController() {
        if matchTYPES == "CRICKET" {
            self.openCreateTeamVC()
        }
        else if  matchTYPES == "BASKETBALL"{
            self.openKabbadiTeamVC()
        }
        else {
            self.openFootballTeamVC()
        }
        
    }
    
    func openContestDetailViewController(contest: [MyLeague],challenge:Int) {
        openViewController(controller: DetailLeagueViewController.self, storyBoard: .homeStoryBoard) { (vc) in
//            vc.leagueData = contest
            vc.getMatchDetail = self.getContestDetail
            vc.checkTeamResponse = self.getTeamResponse
            vc.matchType = self.matchTYPES ?? "CRICKET"
            vc.challengeID = challenge
            vc.comingFromAllContest = false
        }
        
        
        
    }
}

