//
//  SelectMultipleTeamViewController.swift
//  11Kings
//
//  Created by uu on 17/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON
class SelectMultipleTeamViewController: BaseClass {

    @IBOutlet weak var selectionAllViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var toalNoOfTeams: UILabel!
    @IBOutlet weak var selectTeams: UIButton!
    @IBOutlet weak var totalTeam: UILabel!
    @IBOutlet weak var selectView: UIView!
    var checkTeamCount = 0
    var lastrow = 0
    var totalValue = 0.0
    var alredySelectdTeam = [MyTeamResponses]()
    @IBAction func joinTeam(_ sender: Any) {
    
        let doublevalue = Double(selectedItemArray.count - alredySelectdTeam.count)
        if let entry = enteryFees {
         totalValue = entry  * doublevalue
        openConfirmationView(entryFee: totalValue , challengeID: self.challengeid ?? 0)
    }
    }
    @IBAction func selectAllTeam(_ sender: UIButton) {
        self.selectedItemArray.removeAll()
//         sender.isSelected = false
        
        if sender.isSelected {
                selectedItemArray = myTeamsData
            if alredySelectdTeam.count > 0 {
                       for row in 0..<myTeamsData.count  {
         
                        if alredySelectdTeam.contains(where:{$0.teamid == myTeamsData[row].teamid}) {
                            
                         continue
                        }
                        else {
                             joinedCount = joinedCount - 1
                             self.aTableView.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
                            selectedItemArray.remove(at: row)
                        }
                                  
                              
                     
                   }
            }
            else {
                for row in 0..<myTeamsData.count {
                    joinedCount = 0
                    self.aTableView.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
                    selectedItemArray.removeAll()
                }
            }
             sender.setImage(#imageLiteral(resourceName: "Rectangle 3568"), for: .normal)
           checkjoinBtnSelection()
                             
              DispatchQueue.main.async {
//                 self.joinedCount = self.joinedCount - self.alredySelectdTeam.count
                self.toalNoOfTeams.text = "\(self.joinedCount)"
            }
          

        }
        else {
           
           joinedCount = 0
       
        for row in 0..<myTeamsData.count  {
            if alredySelectdTeam.contains(where:{$0.teamid == myTeamsData[row].teamid}) {
                selectedItemArray.append(myTeamsData[row])
//             continue
            }
            else {
                   joinedCount = joinedCount + 1
                  self.aTableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                selectedItemArray.append(myTeamsData[row])
            }
       
       
                          }
                  checkjoinBtnSelection()
                  sender.setImage(#imageLiteral(resourceName: "Group 9310"), for: .normal)
                  
            DispatchQueue.main.async {
//                 self.joinedCount = self.joinedCount - self.alredySelectdTeam.count
                self.toalNoOfTeams.text = "\(self.joinedCount)"
    }
        }
        aTableView.reloadDataInMainQueue()
         sender.isSelected = !sender.isSelected
    }
var isSelected = false
@IBOutlet weak var aContainerView: UIView!
//    @IBOutlet weak var aCreateTeamButton: UIButton!
    
    @IBOutlet weak var joinedTeam: UIButton!
    var confirmationView: ConfirmationView?
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aCreateTeamButtonHeightConstraint: NSLayoutConstraint!
    var teamSelectionClousure: ((Int, Int) -> Void) = { _, _ in }
    @IBOutlet weak var createTeamVC: UIButton!
    var assignteamId = 0
    var maxTeam = 0
    var selectedItemArray = [MyTeamResponses]()
    var teamNmbr = 0
    var remaniningCount = 0
    var teamCount = 0
    var fromEditButn = false
    var fromCloneButton = false
    var myBalanceDataArray = [BalanceModel]()
    var usableBlc = [userUsableBlc]()
    var refreshControl = UIRefreshControl()
    var challengeid:Int?
    var enteryFees:Double?
    var matchType = ""
    
    var storeJoinedLEague = [JoinLeagueResp]()
    var myTeamsData = [MyTeamResponses]()
    var selectteamClosure:  ((Bool) -> Void) = { _ in}
//        didSet {
//            if aTableView != nil {
//                getTeamInfo()
//                aTableView.reloadDataInMainQueue()
//                //aContainerView.isHidden = myTeamsData.count == 0 ? false : true
//            }
//        }
    
    var contestLiveDatas:MyContestLiveLeagues?
    var contestData: GetMatchDetails?
    var matchKey = ""
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var joinedCount = 0
    
    @IBOutlet weak var createNewTeam: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.register(UINib(nibName: SelectMultipleTeamTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: SelectMultipleTeamTableViewCell.identifier())
        setCornerRadius()
        fetchAccountData()
        fetchAccountUsableData()
        addPullToRefresh()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        addNavigationBar(navigationTitle: "Contest", titleContentMode: .left, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
        self.navigationController?.isNavigationBarHidden = true
        
        setContestData()
        myTeamsData.removeAll()
        getTeam()
//         self.joinedCount = self.joinedCount - self.alredySelectdTeam.count
        toalNoOfTeams.text = "\(joinedCount)"
//        joinedTeam.isEnabled = false
        if joinedCount > 0 {
            joinedTeam.isEnabled = true
        }
        else {
            joinedTeam.isEnabled = false
        }
        showHideCreateButton()
        //  aContainerView.isHidden = myTeamsData.count == 0 ? false : true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = true
    }
    func getTeamInfo(){
        totalTeam.text = "You can enter up to \(maxTeam) in this contest"
        for i in myTeamsData {
            if i.is_joined == 1 {
            
                selectedItemArray.append(i)
                alredySelectdTeam.append(i)
            }
        }
        if myTeamsData.count > maxTeam {
            print()
//
            
            self.selectionAllViewHeightConstraint.constant = 0
            self.selectView.isHidden = true
        }
        else {
            self.selectionAllViewHeightConstraint.constant = 40
                       self.selectView.isHidden = false
        }
    }
    
    @IBAction func openJoinedConfirmationView(_ sender: Any) {
        openConfirmationView(entryFee: self.enteryFees ?? 0.0, challengeID: self.challengeid ?? 0)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    fileprivate func setCornerRadius() {
        //aTimerContainerView.setCornerRadius(value: 5)
    }
    
    func checkjoinBtnSelection() {
        if joinedCount > 0 {
            joinedTeam.isEnabled = true

        }
        else {
            joinedTeam.isEnabled = false
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
    fileprivate func getTeam() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
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
                    
                    let json = try JSON(data:response as? Data ?? Data())
                    //                 let list = MyCatagries(json: json)
                    
                    let results = json["result"]
                    let cat = results["teams"]
                    //
                    self.myTeamsData.removeAll()
                    for arr in cat.arrayValue{
                        self.myTeamsData.append(MyTeamResponses(json:arr))
                    }
                    DispatchQueue.main.async {
//                        self.aCreateTeamButton.setTitle("Create Team (\(self.myTeamsData.count + 1))", for: .normal)
                        self.getTeamInfo()
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
    func getPriceCards() -> String {
        var amountArray = [String]()
        for amount in selectedItemArray {
            if alredySelectdTeam.contains(where:  {$0.teamid == amount.teamid}) {

                continue
            }
            else {
            let amtStr = "\(amount.teamid ?? 0)"
            amountArray.append(amtStr)
        }
        }
        let priceCard = amountArray.joined(separator: ",")
        return priceCard
    }
    func joinedContesst(){
        let headers = ["Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDQ3OTkyMSwiZXhwIjoxNTY0NDgzNTIxLCJuYmYiOjE1NjQ0Nzk5MjEsImp0aSI6Im5rVWYzWTdxbEN4cXJxblUiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.NeYkRhFjw2_V63iL0nui_h-ytCtHaZch3y6iAmcLwmA",
                       "Content-Type":"application/json",
                       "Accept":"application/json"]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["challengeid":challengeid,"teamid":getPriceCards(),"user_id":UserDic.value(forKey: "user_id"),"sport_key":matchType]
            NetworkManager.post_Request2(urlService: kContestJoined, param: param as [String : Any], head: headers) { (response) in
                do {
                   
                    let jsonData = try  JSON(data:response as! Data)
                    let status = jsonData["status"].intValue
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
                                                   }
                        else if kPleaseSelectTeam.caseInsensitiveCompare(message) == .orderedSame {
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
                vc.isFromVC = self
                vc.challengeID = self.challengeid ?? 0
                vc.bonusCash = "\(self.myBalanceDataArray[0].bonus ?? "")"
                vc.winnings = "\(self.myBalanceDataArray[0].winning ?? "" )"
                vc.depositAmount = "\(self.myBalanceDataArray[0].totalamount ?? "" )"
                 guard  let usableAmountt = Double(self.usableBlc[0].usablebalance ?? "") else { return }
                               guard  let getAmount = Double(self.myBalanceDataArray[0].balance ?? "") else { return }
                              
                let doubleValue = (self.totalValue - getAmount - usableAmountt )
                                            vc.addAmount = String(doubleValue)
                               
                               
                           })
            
        }
        
        func showHideCreateButton() {
            if myTeamsData.count >= 6 {
//                aCreateTeamButton.setTitle("", for: .normal)
//                aCreateTeamButton.isEnabled = false
                // aCreateTeamButtonHeightConstraint.constant = 0
            } else {
//                aCreateTeamButton.setTitle("CREATE NEW TEAM", for: .normal)
//                aCreateTeamButton.isEnabled = true
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
            vc.contestLiveData = self.contestLiveDatas
        }
        
    }
        func openFootballTeamVC() {
               openViewController(controller: FootballTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
                   // vc.contestData = self.contestData
                   vc.teamNumber = "\(self.myTeamsData.count + 1)"
                   vc.fromPreview = false
                   vc.contestData = self.contestData
                vc.contestLiveData = self.contestLiveDatas
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
    
    extension SelectMultipleTeamViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return myTeamsData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectMultipleTeamTableViewCell.identifier(), for: indexPath) as! SelectMultipleTeamTableViewCell
            cell.selectionStyle = .none

            cell.delegate = self
            if myTeamsData.count > 0 {
                if myTeamsData.count == 15 {
                    cell.cloneView.isHidden = true
                }
                else {
                     cell.cloneView.isHidden = false
                }
                              if matchType == "CRICKET" {
                                
                                   cell.configureCell(data: myTeamsData[indexPath.row])
                              }
                              else if matchType == "FOOTBALL"{
                                  cell.configureCellFootball(data: myTeamsData[indexPath.row])
                              }
                              
                              else {
                                  cell.configureCellKabbaddi(data: myTeamsData[indexPath.row])
                              }
          
            if selectedItemArray.contains(where:  {$0.teamid == myTeamsData[indexPath.row].teamid}) {
                cell.selectImage.image = #imageLiteral(resourceName: "Group 9310")
             
            }
            else {
                 cell.selectImage.image = #imageLiteral(resourceName: "Rectangle 3568")
            }
//            if joinedCount > maxTeam {
//                cell.isUserInteractionEnabled = false
//            }
//            else
//            {
//                cell.isUserInteractionEnabled = true
//            }
            }
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 220 //113 when powerplay invisible
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
            let cell:SelectMultipleTeamTableViewCell = tableView.cellForRow(at: indexPath) as! SelectMultipleTeamTableViewCell
             
         if myTeamsData[indexPath.row].is_joined == 1 {
            return
         }

         else {
             
         
            if (joinedCount + alredySelectdTeam.count) < maxTeam {
                if alredySelectdTeam.contains(where:{$0.teamid == myTeamsData[indexPath.row].teamid}) {
                    return
                }
                else {
            cell.selectImage.image = #imageLiteral(resourceName: "Group 9310")
            joinedCount = joinedCount + 1
        
 
                self.storeAndDelet(tableview: aTableView, indexpath: indexPath)
                cell.check = true
                if myTeamsData.count == selectedItemArray.count {
                    selectTeams.setImage(#imageLiteral(resourceName: "Group 9310"), for: .normal)
                }
                else {
                    selectTeams.setImage(#imageLiteral(resourceName: "Rectangle 3568"), for: .normal)
                }
            let team = myTeamsData[indexPath.row]
            if let teamID = team.teamid, let teamNum = team.teamnumber {
                self.assignteamId = teamID
                self.teamNmbr = teamNum
                checkjoinBtnSelection()
                 DispatchQueue.main.async {
                  
                    self.toalNoOfTeams.text = "\(self.joinedCount)"
                }
            }
        }
            
        }
            
            else {
                Loader.showToast(message: "You can select max \(maxTeam) teams", onView: self.view, bottomMargin: 200, color:  UIColor(red: 240, green: 75, blue: 80))
            }
            }
        }
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
          
            let cell:SelectMultipleTeamTableViewCell = tableView.cellForRow(at: indexPath) as! SelectMultipleTeamTableViewCell
              if myTeamsData[indexPath.row].is_joined == 1 {
                      return
                   }
            else {
            cell.check = false
             joinedCount = joinedCount - 1
            self.storeAndDelet(tableview: aTableView, indexpath: indexPath)
            if myTeamsData.count == selectedItemArray.count {
                selectTeams.setImage(#imageLiteral(resourceName: "Group 9310"), for: .normal)
            }
            else {
                selectTeams.setImage(#imageLiteral(resourceName: "Rectangle 3568"), for: .normal)
            }
            cell.selectImage.image = #imageLiteral(resourceName: "Rectangle 3568")
            checkjoinBtnSelection()
            DispatchQueue.main.async {
//                 self.joinedCount = self.joinedCount - self.alredySelectdTeam.count
                self.toalNoOfTeams.text = "\(self.joinedCount)"
                           }
        }
        }
        func setup(check:Bool) {
            if check {
                
            }
        }
 
}
    
    
extension SelectMultipleTeamViewController:sendDataToSelectAll  {
    
    
        
        func openEditViewController(arrayOfPlayerID: [Int], vcID: Int, captainId: Int, teamID: Int, check: Bool) {
            if matchType == "CRICKET" {
                  openEditVc(arryOfPlayer :arrayOfPlayerID,viceCaptainID : vcID,captainID :captainId, teamIDs: teamID,check:check)
            }
            else if matchType == "BASKETBALL" {
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
               else if matchType == "BASKETBALL" {
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
                          })
                      }
        
        func openpreview(getTeamRespons: MyTeamResponses,teamString:String,teamID:Int) {
            openViewController(controller: PreviewViewController.self, storyBoard: .homeStoryBoard, handler: { (vc) in
                vc.teamName = teamString
                vc.getTeamResponse = getTeamRespons
                vc.isComingFromMyteam = true
                vc.matchKey = self.matchKey
                vc.getContestDetail = self.contestData
                
            })
        }
        
        func openKabbadiPreview(getTeamRespons: MyTeamResponses,teamString:String,teamID:Int) {
                   openViewController(controller: KabaddiPreviewViewController.self, storyBoard: .homeStoryBoard, handler: { (vc) in
                       vc.teamName = teamString
                       vc.getTeamResponse = getTeamRespons
                       vc.isComingFromMyteam = true
                    vc.contestData = self.contestData
                    vc.matchKey = self.matchKey
                   })
               }
        
        func openFootballPreview(getTeamRespons: MyTeamResponses,teamString:String,teamID:Int) {
            openViewController(controller: FootballPreviewViewController.self, storyBoard: .homeStoryBoard, handler: { (vc) in
                vc.teamName = teamString
                vc.getTeamResponse = getTeamRespons
                vc.isComingFromMyteam = true
                vc.contestData = self.contestData
                vc.matchKey = self.matchKey
            })
        }
        
}
extension SelectMultipleTeamViewController {
//    store selected array
    func storeAndDelet(tableview:UITableView,indexpath:IndexPath) {
//        self.selectedItemArray.removeAll()
        
       
       
//
//        self.joinedCount = 0
            self.selectedItemArray.removeAll()
            selectedItemArray = alredySelectdTeam
       
        if let arr = tableview.indexPathsForSelectedRows {
            print(arr)
            for index in arr {
                if alredySelectdTeam.contains(where:{$0.teamid == myTeamsData[indexpath.row].teamid}) {
                 return
             }
                else {
                selectedItemArray.append(myTeamsData[index.row])
                }
                
            }
            
        }
        print(selectedItemArray.count)
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (joinedCount + alredySelectdTeam.count) < maxTeam {
            return indexPath
        }
        else {
             Loader.showToast(message: "You can select max \(maxTeam) teams", onView: self.view, bottomMargin: 200, color:  UIColor(red: 240, green: 75, blue: 80))
        return nil
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
             lastrow = indexPath.row
            }
        }
    }
}
