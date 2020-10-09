//
//  MyTeamViewController.swift
//  Club11
//
//  Created by Developer on 28/05/19.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftToast
class MyTeamViewController: BaseClass {
    
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aCreateTeamButton: UIButton!
     @IBOutlet weak var createNewTeam: UIButton!
    @IBOutlet weak var joinedTeam: UIButton!
   
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aCreateTeamButtonHeightConstraint: NSLayoutConstraint!
   
    var msgResp = [TeamUpdateMessageResponses]()
    var joinID :Int?
    var assignteamId = 0
    var teamSelectionClousure: ((Int, Int) -> Void) = { _, _ in }
    var selectedIndex = -1
    var confirmationView: ConfirmationView?
    var teamNmbr = 0
    var fromEditButn = false
    var fromCloneButton = false
    var myBalanceDataArray = [BalanceModel]()
    var usableBlc = [userUsableBlc]()
    var refreshControl = UIRefreshControl()
    var challengeid:Int?
    var enteryFees:Double?
    var matchType = ""
     var totalValue = 0.0
    var swtichTeam = false
    var storeJoinedLEague = [JoinLeagueResp]()
    var myTeamsData = [MyTeamResponses]() {
        didSet {
            if aTableView != nil {
                if myTeamsData.count == 15 {
                    aCreateTeamButton.isHidden = true
                }
                else {
                    aCreateTeamButton.isHidden = false
                }
                aTableView.reloadDataInMainQueue()
                
            }
        }
    }
    var contestLiveDatas:MyContestLiveLeagues?
    var contestData: GetMatchDetails?
    var matchKey = ""
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var check = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.register(UINib(nibName: MyTeamTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MyTeamTableViewCell.identifier())
        setCornerRadius()
        fetchAccountData()
        fetchAccountUsableData()
        addPullToRefresh()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        setContestData()
        aTableView.allowsMultipleSelection = false
        myTeamsData.removeAll()
        getTeam()
        if check {
            joinedTeam.isEnabled = true
        }
        else {
            joinedTeam.isEnabled = false
        }

        showHideCreateButton()
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func openJoinedConfirmationView(_ sender: Any) {
        if swtichTeam {
            updateTeam()
        }
        else {
        openConfirmationView(entryFee: self.enteryFees ?? 0.0, challengeID: self.challengeid ?? 0)
    }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    fileprivate func setCornerRadius() {
        //aTimerContainerView.setCornerRadius(value: 5)
    }
    
    func checkjoinBtnSelection() {
        if assignteamId != 0 {
            joinedTeam.isEnabled = true
            
//            joinedTeam.backgroundColor = UIColor(red: 8, green: 117, blue: 183)
        }
    }
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    func fetchAccountData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NzA3MjE0NywiZXhwIjoxNTY3MDc1NzQ3LCJuYmYiOjE1NjcwNzIxNDcsImp0aSI6InVIZWIyNmhSZG5sWWZheU0iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.-Saz_1BZR3kqfNWHU4-gN5ccmM3_gvOO6G14jjY_ho0",
            "Content-Type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id")]
            NetworkManager.post_Request(urlService: kMyBalance, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let json = try JSON(data:response as! Data)
                        let result = json["result"]
                        for arr in result.arrayValue {
                            self.myBalanceDataArray.append(BalanceModel(json:arr))
                        }
                    } else {
                        Loader.showAlert(message: "Unable to get Account Data")
                    }
                    
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    func fetchAccountUsableData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            
            "Content-Type": "application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id"),"challengeid":challengeid]
            NetworkManager.post_Request2(urlService: kUsableBalance, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let json = try JSON(data:response as! Data)
                        let result = json["result"]
                        for arr in result.arrayValue {
                            self.usableBlc.append(userUsableBlc(json:arr))
                        }
                    } else {
                        Loader.showAlert(message: "Unable to get Account Data")
                    }
                    
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    @objc func refreshData(sender:AnyObject) {
        //  getMyTeams()
        myTeamsData.removeAll()
        getTeam()
        
        showHideCreateButton()
        // aContainerView.isHidden = myTeamsData.count == 0 ? false : true
        aTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    fileprivate func setContestData() {
        if let data = contestData {
            self.matchKey = data.matchkey ?? ""
        }
    }
    
    fileprivate func setReleaseTime(releaseDateString: String) {
        
    }
    
    @objc func updateTime() {
        
    }
    fileprivate func updateTeam() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = ["Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDIyMTE0NiwiZXhwIjoxNTY0MjI0NzQ2LCJuYmYiOjE1NjQyMjExNDYsImp0aSI6IkFKYm5tdVpkb0VaVko3U2IiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.KSMUhnvzM2OmfgvhY_rOrt-cut2yW1IksR0PAZ3rgcY",
                       "Content-Type": "application/json",
                       "Accept":"application/json"]
        
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["userid":UserDic.value(forKey: "user_id"),
                         "matchkey":matchKey,
                         "sport_key":matchType,
                         "challenge_id":challengeid,"teamid":assignteamId,"joinid":joinID ]
            NetworkManager.post_Request2(urlService: kupdateTeam, param: param as [String : Any], head: headers) {
                (response) in
                self.hideActivityIndicator()
               
                do{
                    let json = try JSON(data:response as! Data)
                    //                 let list = MyCatagries(json: json)
                    
                    let results = json["result"]
                   
                    for i in results.arrayValue {
                        self.msgResp.append(TeamUpdateMessageResponses(json:i))
                    }
                    
                    if self.msgResp[0].status == 1 {
                        
                        Loader.showToast(message:self.msgResp[0].msg ?? "Team Updated SuccessFully"  , onView: self.view, bottomMargin: 30 , color: UIColor(red: 49, green: 139, blue: 22))
                    }
                    else {
                       Loader.showToast(message:self.msgResp[0].msg ?? "Error"  , onView: self.view, bottomMargin: 30 , color: UIColor(red: 49, green: 139, blue: 22))
                    }
                      self.navigationController?.popViewController(animated: true)
                    //
                    

                }
                    
                catch{
                    print(error.localizedDescription)
                }
            }
            
            
        }
    }
    fileprivate func getTeam() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = ["Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTQzODcxMCwiZXhwIjoxNTY1NDQyMzEwLCJuYmYiOjE1NjU0Mzg3MTAsImp0aSI6IkZEVGZKdTVIVW5PY0N0ZnIiLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.MTioWiGu5-5Itkw8Y-1lh08iAcYAvQhsUcpbFoLLmMg",
                       "Content-Type": "application/json",
                       "Accept":"application/json"]
        
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["user_id":UserDic.value(forKey: "user_id"),
                         "matchkey":matchKey,
                         "sport_key":matchType,"challenge_id":challengeid]
            NetworkManager.post_Request2(urlService: kMyTeamURL, param: param as [String : Any], head: headers) {
                (response) in
                self.hideActivityIndicator()
               
                do{
                    let json = try JSON(data:response as! Data)
                    //                 let list = MyCatagries(json: json)
                    
                    let results = json["result"]
                    let cat = results["teams"]
                    //
                    self.myTeamsData.removeAll()
                    for arr in cat.arrayValue{
                        self.myTeamsData.append(MyTeamResponses(json:arr))
                    }
                    DispatchQueue.main.async {
                        self.aCreateTeamButton.setTitle("Create Team (\(self.myTeamsData.count + 1))", for: .normal)
                        self.aTableView.reloadData()
                    }
                }
                    
                catch{
                    print(error.localizedDescription)
                }
            }
            
            
        }
    }
    fileprivate func viewCloseAction() {
        
        confirmationView?.removeFromSuperview()
        confirmationView = nil
    }
    
    func openConfirmationView(entryFee: Double, challengeID: Int) {
        if confirmationView == nil {
            confirmationView = Bundle.main.loadNibNamed("ConfirmationView", owner: self, options: nil)?.first as? ConfirmationView
            confirmationView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            APP_DEL.window?.addSubview(confirmationView!)
            //        confirmationView?.myTeamsData = teams
            confirmationView?.availableBalance = "\(myBalanceDataArray[0].totalamount ?? "0")"
            confirmationView?.usableBalance = "\(usableBlc[0].usablebalance ?? "0")"
            confirmationView?.entryFees = entryFee
            confirmationView?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.viewCloseAction()
                }
            }
            confirmationView?.joinButtonClouser = { [weak self] teamID in
                if let strongSelf = self {
                    strongSelf.joinedContesst()
                }
            }
            confirmationView?.termsConditionButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.viewCloseAction()
                    strongSelf.openTermsAndCondition()
                }
            }
        }
    }
    func openTermsAndCondition(){
        openViewController(controller: TermAndConditionViewController.self, storyBoard: .moreStoryBoard, handler: { (vc) in
            
        })
    }
    @IBAction func createTeamButtonAction(_ sender: UIButton) {
        if matchType == "CRICKET" {
               openCreateTeamVC()
        }
        else if matchType == "FOOTBALL" {
           openFootballTeamVC()
        }
        else {
            openKabaddiTeamVC()
        }
     
    }
    
    func joinedContesst(){
        let headers = ["Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDQ3OTkyMSwiZXhwIjoxNTY0NDgzNTIxLCJuYmYiOjE1NjQ0Nzk5MjEsImp0aSI6Im5rVWYzWTdxbEN4cXJxblUiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.NeYkRhFjw2_V63iL0nui_h-ytCtHaZch3y6iAmcLwmA",
                       "Content-Type":"application/json",
                       "Accept":"application/json"]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["challengeid":challengeid,"teamid":assignteamId,"user_id":UserDic.value(forKey: "user_id"),"sport_key":matchType]
            NetworkManager.post_Request2(urlService: kContestJoined, param: param as [String : Any], head: headers) { (response) in
                do {
                   
                    let jsonData = try  JSON(data:response as! Data)
                    let status = jsonData["status"]
                    let message = jsonData["message"].stringValue
                    let result = jsonData["result"]
                    if status == 1 {
                        for arr in result.arrayValue {
                            self.storeJoinedLEague.append(JoinLeagueResp(json: arr))
                        }
                      
                                self.viewCloseAction()
                                for controller in self.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: LeagueCollectionViewController.self) {
                                        
                                        
                                        self.navigationController!.popToViewController(controller, animated: true)
                                        break
                                    }
                                    Loader.showToast(message: self.storeJoinedLEague[0].message ?? "League Joined", onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 29))
                                    }
                        
                    }
                    else {
                        if status == 0 {
                                                       self.viewCloseAction()
                                                       self.openAddMoneyVC()
                                                   } else if kPleaseSelectTeam.caseInsensitiveCompare(message) == .orderedSame {
                                                       Loader.showToast(message: message, onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                                                   }
                        else {
                        for controller in self.navigationController!.viewControllers as Array {
                                                          if controller.isKind(of: LeagueCollectionViewController.self) {
                                                              
                                                              
                                                              self.navigationController!.popToViewController(controller, animated: true)
                                                              break
                                                          }
                         Loader.showToast(message: message, onView: self.view, bottomMargin: 200, color:  UIColor(red: 240, green: 75, blue: 80))
                    }
                        }
                    }
                }
                    catch {
                        Loader.showAlert(message: "Internal Error")
                    }
                }
            }
        }
        func openAddMoneyVC() {
            openViewController(controller: AddMoneyViewController.self, storyBoard: .accountStoryBoard, handler: { (vc) in
//                guard let data = self.myBalanceDataArray[0].totalamount else { return }
//                vc.addAmount = "\(enteryFees - myBalanceDataArray[0].totalamount)"
                vc.isFromVC = self
                vc.challengeID = self.challengeid ?? 0
                vc.bonusCash = "\(self.myBalanceDataArray[0].bonus ?? "")"
                vc.winnings = "\(self.myBalanceDataArray[0].winning ?? "" )"
                vc.depositAmount = "\(self.myBalanceDataArray[0].totalamount ?? "" )"
                  guard  let usableAmountt = Double(self.usableBlc[0].usablebalance ?? "") else { return }
                guard  let getAmount = Double(self.myBalanceDataArray[0].balance ?? "") else { return }
                if let entry = self.enteryFees {
                    let doubleValue = (entry - getAmount - usableAmountt )
                             vc.addAmount = String(doubleValue)
                }
                
            })
                
        }
        
        func showHideCreateButton() {
            if myTeamsData.count >= 6 {
                aCreateTeamButton.setTitle("", for: .normal)
                aCreateTeamButton.isEnabled = false
                // aCreateTeamButtonHeightConstraint.constant = 0
            } else {
                aCreateTeamButton.setTitle("CREATE NEW TEAM", for: .normal)
                aCreateTeamButton.isEnabled = true
                // aCreateTeamButtonHeightConstraint.constant = 30
            }
        }
        
        override func handleBackButtonAction() {
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: LeagueCollectionViewController.self) {
                    
                    self.navigationController!.popToViewController(controller, animated: true)
                     break
                }
                    if controller.isKind(of: ContestDetailVCViewController.self) {
                         self.navigationController!.popToViewController(controller, animated: true)
                         break
                    }
                   
                
                
            }
        }
        
        func openCreateTeamVC() {
            openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                // vc.contestData = self.contestData
                vc.teamNumber = "\(self.myTeamsData.count + 1)"
                vc.fromPreview = false
                vc.contestData = self.contestData
                vc.matchKey = self.matchKey
                vc.contestLiveData = self.contestLiveDatas
                vc.fromTeamSelection = true
                
            }
        }
    func openKabaddiTeamVC() {
        openViewController(controller: KABADDITeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            // vc.contestData = self.contestData
            vc.teamNumber = "\(self.myTeamsData.count + 1)"
            vc.fromPreview = false
            vc.contestData = self.contestData
            vc.matchKey = self.matchKey
            vc.contestLiveData = self.contestLiveDatas
              vc.fromTeamSelection = true
        }
        
    }
        func openFootballTeamVC() {
               openViewController(controller: FootballTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                   // vc.contestData = self.contestData
                   vc.teamNumber = "\(self.myTeamsData.count + 1)"
                   vc.fromPreview = false
                   vc.contestData = self.contestData
                vc.matchKey = self.matchKey
                vc.contestLiveData = self.contestLiveDatas
                   vc.fromTeamSelection = true
            }
               
           }
        func previewAction(teamID: Int, index: Int) {
            //        openViewController(controller: PreviewViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            //            vc.teamId = teamID
            //            vc.contestData = self.contestData
            //            vc.selectedIndex = index
            //        }
        }
        
        func editAction(teams: MyTeamViewController, teamID: Int) {
            //        openViewController(controller: EditCloneTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            //            vc.contestData = self.contestData
            //            let teamNum = teams.teamnumber
            //            vc.teamNumber = "\(teamNum ?? 999)"
            //            vc.teamId = teamID
            //        }
        }
        
        func cloneAction(teams: MyTeamViewController, teamID: Int) {
            //        openViewController(controller: EditCloneTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            //            vc.contestData = self.contestData
            //            vc.teamNumber = "\(self.myTeamsData.count + 1)"  // for new and clone
            //            vc.teamId = teamID
            //        }
        }
        
        @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
            getTeam()
            showHideCreateButton()
            // aContainerView.isHidden = myTeamsData.count == 0 ? false : true
        }
    }
    
    extension MyTeamViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return myTeamsData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyTeamTableViewCell.identifier(), for: indexPath) as! MyTeamTableViewCell
            
           cell.delegate = self
            if myTeamsData.count > 0 {
                              if matchType == "CRICKET" {
                                   cell.configureCell(data: myTeamsData[indexPath.row])
                              }
                              else if matchType == "FOOTBALL"{
                                  cell.configureCellFootball(data: myTeamsData[indexPath.row])
                              }
                              
                              else {
                                  cell.configureCellKabbaddi(data: myTeamsData[indexPath.row])
                              }
                          }
            
            if selectedIndex == indexPath.row {
                
                             cell.aContainerView.borderWidth = 2
                             cell.aContainerView.borderColor = UIColor(red: 115, green: 16, blue: 8)
                cell.aContainerView.backgroundColor = .white
                 //            check = false
                           let team = myTeamsData[indexPath.row]
                           if let teamID = team.teamid, let teamNum = team.teamnumber {
                               self.assignteamId = teamID
                               self.teamNmbr = teamNum
                               checkjoinBtnSelection()
                           }
            }
            else {
                cell.check  = false
                cell.aContainerView.backgroundColor = .clear
                cell.aContainerView.borderColor = .clear
                  cell.aContainerView.borderWidth = 0
            }

            
            
            
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200 //113 when powerplay invisible
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let cell:MyTeamTableViewCell = tableView.cellForRow(at: indexPath) as! MyTeamTableViewCell
    
       if myTeamsData[indexPath.row].is_joined == 1 {
          return
       }
      else {
     selectedIndex = indexPath.row
      aTableView.reloadDataInMainQueue()
     }
            
            
        }
//        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//            print("bjj")
//
//
//        }
        
    }
    
    
//
 extension MyTeamViewController :openEditVc {
        
        func openEditViewController(arrayOfPlayerID: [Int], vcID: Int, captainId: Int, teamID: Int, check: Bool) {
            if matchType == "CRICKET" {
                  openEditVc(arryOfPlayer :arrayOfPlayerID,viceCaptainID : vcID,captainID :captainId, teamIDs: teamID,check:check)
            }
            else if matchType == "KABADDI" {
                openKabbadiEditVc(arryOfPlayer :arrayOfPlayerID,viceCaptainID : vcID,captainID :captainId, teamIDs: teamID,check:check)
            }
            else {
                openFootballEditVc(arryOfPlayer :arrayOfPlayerID,viceCaptainID : vcID,captainID :captainId, teamIDs: teamID,check:check)

            }
          
        }
        
        func openPreviewData(teamResponse: MyTeamResponses, teamName: String, teamID: Int) {
               if matchType == "CRICKET" {
           openpreview(getTeamRespons: teamResponse,teamString :teamName, teamID: teamID)
            }
               else if matchType == "KABADDI" {
                openKabbadiPreview(getTeamRespons: teamResponse,teamString :teamName, teamID: teamID)
                
            }

               else {
                openFootballPreview(getTeamRespons: teamResponse,teamString :teamName, teamID: teamID)
            }
        }
        
        func openEditVc(arryOfPlayer :[Int],viceCaptainID : Int,captainID :Int,teamIDs:Int,check: Bool){
            openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard, handler: { (vc) in
                vc.arrayOfPlayer  = arryOfPlayer
                vc.contestData = self.contestData
                vc.viceCaptainID = viceCaptainID
                vc.captainID = captainID
                vc.teamID = teamIDs
                vc.isFromEdit =  check
                vc.matchKey = self.matchKey
                  vc.fromTeamSelection = true
            })
        }
        func openKabbadiEditVc(arryOfPlayer :[Int],viceCaptainID : Int,captainID :Int,teamIDs:Int,check: Bool){
                   openViewController(controller: KABADDITeamViewController.self, storyBoard: .teamStoryBoard, handler: { (vc) in
                       vc.arrayOFPlayer  = arryOfPlayer
                       vc.contestData = self.contestData
                       vc.viceCaptian = viceCaptainID
                       vc.Captain = captainID
                       vc.teamId = teamIDs
                       vc.fromEditVC =  check
                    vc.matchKey = self.matchKey
                      vc.fromTeamSelection = true
                   })
               }
        
        func openFootballEditVc(arryOfPlayer :[Int],viceCaptainID : Int,captainID :Int,teamIDs:Int,check: Bool){
                          openViewController(controller: FootballTeamViewController.self, storyBoard: .teamStoryBoard, handler: { (vc) in
                              vc.arrayOFPlayer  = arryOfPlayer
                              vc.contestData = self.contestData
                              vc.viceCaptian = viceCaptainID
                              vc.Captain = captainID
                              vc.teamId = teamIDs
                              vc.fromEditVC =  check
                            vc.matchKey = self.matchKey
                              vc.fromTeamSelection = true
                            
                          })
                      }
        
        func openpreview(getTeamRespons: MyTeamResponses,teamString:String,teamID:Int) {
            openViewController(controller: PreviewViewController.self, storyBoard: .homeStoryBoard, handler: { (vc) in
                vc.teamName = teamString
                vc.getTeamResponse = getTeamRespons
                vc.isComingFromMyteam = true
                vc.getContestDetail = self.contestData
                vc.contestLiveDatas = self.contestLiveDatas
                
                
            })
        }
        
        func openKabbadiPreview(getTeamRespons: MyTeamResponses,teamString:String,teamID:Int) {
                   openViewController(controller: KabaddiPreviewViewController.self, storyBoard: .homeStoryBoard, handler: { (vc) in
                       vc.teamName = teamString
                       vc.getTeamResponse = getTeamRespons
                       vc.isComingFromMyteam = true
                    vc.contestData = self.contestData
                     vc.contestLiveDatas = self.contestLiveDatas
                   })
               }
        
        func openFootballPreview(getTeamRespons: MyTeamResponses,teamString:String,teamID:Int) {
            openViewController(controller: FootballPreviewViewController.self, storyBoard: .homeStoryBoard, handler: { (vc) in
                vc.teamName = teamString
                vc.getTeamResponse = getTeamRespons
                vc.isComingFromMyteam = true
                vc.contestData = self.contestData
                 vc.contestLiveDatas = self.contestLiveDatas
            })
        }
        
}

