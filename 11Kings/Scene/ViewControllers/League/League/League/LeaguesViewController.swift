//
//  LeaguesViewController.swift
//  FantasyCrick2Part
//
//  Created by Developer on 09/05/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class LeaguesViewController: BaseViewController {
    
    @IBOutlet weak var aJoinedCount: UILabel!
    @IBOutlet weak var aMyTeamsCount: UILabel!
    @IBOutlet weak var aVSLabel: UILabel!
    @IBOutlet weak var aTimerContainerView: UIView!
    @IBOutlet weak var aTimeLabel: UILabel!
    @IBOutlet weak var aAllContestContainerView: UIView!
    @IBOutlet weak var aContestTableView: UITableView!
    @IBOutlet weak var aContestCountLabel: UILabel!
    @IBOutlet weak var aMyTeamButton: UIButton!
    @IBOutlet weak var aJoinedContestButton: UIButton!
    @IBOutlet weak var aEnterCodeButton: UIButton!
    @IBOutlet weak var aCreateLeagueButton: UIButton!
    
    var refreshControl = UIRefreshControl()
    var availableBalance = ""
    var usableBalance = ""
    var winnerBreakUpView: WinnerBreakupView?
    var contestInviteView: ContestInvieteCodeView?
    var confirmationView: ConfirmationView?
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var contestData: Any?
    var matchKey = "" {
        didSet {
            getLeagues()
            getMyTeams()
            getJoinedLeagues()
        }
    }
    var myBalanceDataArray = [MyBalanceModel]() {
        didSet {
            setAccountData()
        }
    }
    var contestCategories = [Categories]()
    var allContestData = [Leagues]()
    var myTeamsData = [MyTeamResponse]() {
        didSet {
            setMyTeamButtonData()
        }
    }
    var myJoinedLeagueData = [JoinLeagueResponse]() {
        didSet {
            setJoinedLeagueButtonData()
        }
    }
    var tempCID = 0
    var tempFees = 0.0
    var homeType: HomeType = .upcomming

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setCornerRadius()
        aContestTableView.estimatedRowHeight = 100
        aContestTableView.rowHeight = UITableView.automaticDimension
        addPullToRefresh() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Contest", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: true)
        setContestData()
        fetchAccountData()
    }
    
    fileprivate func registerCell() {
        aContestTableView.register(UINib(nibName: "ContestCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ContestCategoryTableViewCell")
    }
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aContestTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(sender:AnyObject) {
        fetchAccountData()
        aContestTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    fileprivate func setContestData() {
        if let contest = contestData as? LiveMatchResponse {
            matchKey = contest.matchkey ?? ""
            aVSLabel.text = "\(contest.team1name ?? "") vs \(contest.team2name ?? "")"
            setReleaseTime(releaseDateString: contest.time_start ?? "0")
        }
        if let contest = contestData as? MyContestReponse {
            matchKey = contest.matchkey ?? ""
            aVSLabel.text = "\(contest.team1display ?? "") vs \(contest.team2display ?? "")"
            setReleaseTime(releaseDateString: contest.start_date ?? "0")
        }
    }
    
    fileprivate func setCornerRadius() {
        aTimerContainerView.setCornerRadius(value: 5)
        aContestCountLabel.setCornerRadius(value: 5)
        aCreateLeagueButton.setCornerRadiusButton(value: 5)
        aEnterCodeButton.setCornerRadiusButton(value: 5)
        aContestCountLabel.setBorder(color: .orange, size: 1)
        aMyTeamsCount.setBorder(color: .white, size: 1)
        aMyTeamsCount.setCornerRadius(value: 2)
        aJoinedCount.setBorder(color: .white, size: 1)
        aJoinedCount.setCornerRadius(value: 2)
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
        switch homeType {
        case .live:
            aTimeLabel.text = "In Progress"
            aTimeLabel.textColor = .orange
        case .result:
            aTimeLabel.text = "Winner Declared"
            aTimeLabel.textColor = UIColor(red: 93 / 255, green: 180 / 255, blue: 84 / 255, alpha: 1.0)
        case .upcomming:
            aTimeLabel.text = countdown
            aTimeLabel.textColor = .orange
        }
        if day == 0 && hour == 0 && minute == 0 && second == 0 {
            countdownTimer.invalidate()
        }
    }
    
    fileprivate func getLeagues() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey] as [String : Any]
        
        NetworkManager.post_Request(urlService: kGetChallengeURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode(HomeContestResponse.self, from: responseData)
                    if let categories = responseModel.categories {
                        self.contestCategories = categories
                        self.allContestData.removeAll()
                        for data in categories {
                            if let leagues = data.leagues {
                                for league in leagues {
                                    self.allContestData.append(league)
                                }
                            }
                        }
                    }
                    self.aContestCountLabel.text = "  \(responseModel.total_contest ?? self.allContestData.count)  "
                    self.aContestTableView.reloadData()
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    fileprivate func getMyTeams() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey] as [String : Any]
        
        NetworkManager.post_Request(urlService: kMyTeamURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([MyTeamResponse].self, from: responseData)
                    self.myTeamsData = responseModel
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    fileprivate func getJoinedLeagues() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey] as [String : Any]
        
        NetworkManager.post_Request(urlService: kMyJoinedLeagueURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([JoinLeagueResponse].self, from: responseData)
                    if responseModel[0].status == 0 {
                        // Handle for no data
                    } else {
                        self.myJoinedLeagueData = responseModel
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func fetchAccountData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1]
        NetworkManager.post_Request(urlService: kMyBalance, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode(Array<MyBalanceModel>.self, from: responseData)
                    if responseModel.count > 0 {
                        self.myBalanceDataArray = responseModel
                    } else {
                        Loader.showAlert(message: "Unable to get account data")
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func setAccountData() {
        guard myBalanceDataArray.count > 0  else {
            return
        }
        let data = myBalanceDataArray[0]
        usableBalance = "\(kRupeeIcon ) \(data.winning ?? 0)"
        availableBalance = "\(kRupeeIcon) \(data.totalamount ?? 0)"
    }
    
    @IBAction func joinedButtonAction(_ sender: UIButton) {
        openViewController(controller: JoinedContestViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.myJoinedLeagueData = self.myJoinedLeagueData
            vc.contestData = self.contestData
            vc.matchKey = self.matchKey
            vc.myTeamsData = self.myTeamsData
        }
    }
    
    @IBAction func myTeamButtonAction(_ sender: UIButton) {
        openViewController(controller: MyTeamViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.myTeamsData = self.myTeamsData
            vc.contestData = self.contestData
        }
    }
    
    @IBAction func enterCodeButtonAction(_ sender: UIButton) {
        openContestInviteView()
    }
    
    @IBAction func createLeagueButtonActin(_ sender: UIButton) {
        openViewController(controller: CreateContestViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.contestData = self.contestData
            vc.matchKey = self.matchKey
        }
    }
    
    @IBAction func allContestButtonAction(_ sender: Any) {
        openAllContestViewController()
    }
    
    
    func setMyTeamButtonData() {
        aMyTeamsCount.text = "  \(myTeamsData.count)  "
    }
    
    func setJoinedLeagueButtonData() {
        aJoinedCount.text = "  \(myJoinedLeagueData.count)  "
    }
    
    func openAllContestViewController() {
        openViewController(controller: AllContestViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.myJoinedLeagueData = self.myJoinedLeagueData
            vc.allLeagueData = self.allContestData
            vc.contestData = self.contestData
            vc.matchKey = self.matchKey
            vc.homeType = self.homeType
        }
    }
    
    func getWinnerBreakupData(challengeId: Int, ammount: Double) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["challenege_id": challengeId, "matchkey": matchKey] as [String : Any]
        
        NetworkManager.post_Request(urlService: kWinnerbreakUpURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([WinnerbreakUpResponse].self, from: responseData)
                    self.openWinnerBreakupView(winnerArr: responseModel, ammount: ammount)
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func openWinnerBreakupView(winnerArr: [WinnerbreakUpResponse], ammount: Double) {
        if winnerArr.count == 0 {
            Loader.showToast(message: "No Winner Breakup", onView: self.view, bottomMargin: 200)
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
    
    func openContestInviteView() {
        if contestInviteView == nil {
            contestInviteView = Bundle.main.loadNibNamed("ContestInvieteCodeView", owner: self, options: nil)?.first as? ContestInvieteCodeView
            contestInviteView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            APP_DEL.window?.addSubview(contestInviteView!)
            contestInviteView?.joinContestButtonClouser = { [weak self] code in
                if let strongSelf = self {
                    strongSelf.joinWithContestCode(code: code)
                }
            }
            contestInviteView?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.viewCloseAction()
                }
            }
        }
    }
    
    func openConfirmationView(teams: [MyTeamResponse], entryFee: Double, challengeID: Int) {
        if confirmationView == nil {
            confirmationView = Bundle.main.loadNibNamed("ConfirmationView", owner: self, options: nil)?.first as? ConfirmationView
            confirmationView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            APP_DEL.window?.addSubview(confirmationView!)
            confirmationView?.myTeamsData = teams
            confirmationView?.availableBalance = availableBalance
            confirmationView?.usableBalance = usableBalance
            confirmationView?.entryFees = entryFee
            confirmationView?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.viewCloseAction()
                }
            }
            confirmationView?.joinButtonClouser = { [weak self] teamID in
                if let strongSelf = self {
                    strongSelf.joinContest(challengeId: challengeID, teamID: teamID)
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
    
    func joinWithContestCode(code: String) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey, "getcode": code] as [String : Any]
        
        NetworkManager.post_Request(urlService: kJoinedByCode, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([MessageResponse].self, from: responseData)
                    if let responseMessage = responseModel[0].message {
                        self.viewCloseAction()
                        Loader.showToast(message: responseMessage, onView: self.view, bottomMargin: 200)
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func joinContest(challengeId: Int, teamID: Int) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey, "challengeid": challengeId,"teamid": teamID] as [String : Any]
        
        NetworkManager.post_Request(urlService: kJoinContest, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([JoinContest].self, from: responseData)
                    if let responseMessage = responseModel[0].message {
                        if kInsufficientBalance.caseInsensitiveCompare(responseMessage) == .orderedSame {
                            self.viewCloseAction()
                            self.openAddMoneyVC()
                        } else if kPleaseSelectTeam.caseInsensitiveCompare(responseMessage) == .orderedSame {
                            Loader.showToast(message: responseMessage, onView: self.view, bottomMargin: 200)
                        } else {
                            self.viewCloseAction()
                            Loader.showToast(message: responseMessage, onView: self.view, bottomMargin: 200)
                        }
                    }
                    self.getJoinedLeagues()
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
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
    
    func openLeaderboard(challengeId: Int, league: Leagues, entreFee: Double) {
        openViewController(controller: LeaderBooardViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchKey = self.matchKey
            vc.challengeId = challengeId
            vc.league = league
            vc.contestData = self.contestData
            vc.myTeamsData = self.myTeamsData
            vc.entreeFee = entreFee
            vc.homeType = self.homeType
        }
    }
    
    func openCreateTeamVC() {
        openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.contestData
            vc.teamNumber = "\(self.myTeamsData.count + 1)"
        }
    }
    
    func openTermsAndCondition(){
        openViewController(controller: TermsAndConditionViewController.self, storyBoard: .moreStoryBoard, handler: { (vc) in
            
        })
    }
    
    func openAddMoneyVC() {
        openViewController(controller: AddMoneyViewController.self, storyBoard: .accountStoryBoard, handler: { (vc) in
            vc.isFromVC = self
        })
    }
    
    override func handleBackButtonAction() -> Void {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
        fetchAccountData()
        setAccountData()
        getLeagues()
        getMyTeams()
        getJoinedLeagues()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.openConfirmationView(teams: self.myTeamsData, entryFee: self.tempFees, challengeID: self.tempCID)
        }
    }
    
    @IBAction func unwindToAddAccount(segue: UIStoryboardSegue) {
        fetchAccountData()
        setAccountData()
        getLeagues()
        getMyTeams()
        getJoinedLeagues()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.openConfirmationView(teams: self.myTeamsData, entryFee: self.tempFees, challengeID: self.tempCID)
        }
    }
}

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contestCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contestCategories[section].leagues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView ()
        guard let customView = Bundle.main.loadNibNamed("ContestCategoryTableHeaderView", owner: self, options: nil)?.first as? ContestCategoryTableHeaderView else  {
            return headerView
        }
        customView.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 70)
        headerView.addSubview(customView)
        customView.configureCell(category: contestCategories[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContestCategoryTableViewCell", for: indexPath) as! ContestCategoryTableViewCell
        if let leagues = contestCategories[indexPath.section].leagues {
            cell.configureCell(league: leagues[indexPath.row])
        }
        cell.winnerButtonClouser = {[weak self] cId, amt  in
            if let strongSelf = self {
                strongSelf.getWinnerBreakupData(challengeId: cId, ammount: amt)
            }
        }
        cell.joinButtonClouser = {[weak self] cId, fee  in
            if let strongSelf = self {
                if strongSelf.myTeamsData.count == 0 {
                    strongSelf.tempCID = cId
                    strongSelf.tempFees = fee
                    strongSelf.openCreateTeamVC()
                } else {
                    strongSelf.openConfirmationView(teams: strongSelf.myTeamsData, entryFee: fee, challengeID: cId)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kContestTVCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let leagues = contestCategories[indexPath.section].leagues {
            if let cID = leagues[indexPath.row].id, let fees = leagues[indexPath.row].entryfee {
                openLeaderboard(challengeId: cID, league: leagues[indexPath.row], entreFee: fees)
            }
        }
    }
}

