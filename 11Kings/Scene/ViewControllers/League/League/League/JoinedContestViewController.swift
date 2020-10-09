//
//  JoinedContestViewController.swift
//  Club11
//
//  Created by Developer on 28/05/19.
//

import UIKit

class JoinedContestViewController: BaseViewController {
    
    @IBOutlet weak var aNoDataLabel: UILabel!
    @IBOutlet weak var aVSLabel: UILabel!
    @IBOutlet weak var aTimerContainerView: UIView!
    @IBOutlet weak var aTimeLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var availableBalance = ""
    var usableBalance = ""
    var winnerBreakUpView: WinnerBreakupView?
    var confirmationView: ConfirmationView?
    var myJoinedLeagueData = [JoinLeagueResponse]() {
        didSet {
            setNoDataLabel()
            if aTableView != nil {
                aTableView.reloadDataInMainQueue()
            }
        }
    }
    var contestData: Any?
    var matchKey = ""
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var myTeamsData = [MyTeamResponse]()
    var myBalanceDataArray = [MyBalanceModel]() {
        didSet {
            setAccountData()
        }
    }
    var tempCID = 0
    var tempFee = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.register(UINib(nibName: JoinedContestTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: JoinedContestTableViewCell.identifier())
        setCornerRadius()
        addPullToRefresh() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Joined Contest", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: true)
        setContestData()
        getJoinedLeagues()
        setNoDataLabel()
        fetchAccountData()
    }
    
    func setNoDataLabel() {
        if aNoDataLabel != nil {
            aNoDataLabel.isHidden = myJoinedLeagueData.count == 0 ? false : true
            aNoDataLabel.text = myJoinedLeagueData.count == 0 ? "No Contest Join" : ""
        }
    }
    
    fileprivate func setCornerRadius() {
        aTimerContainerView.setCornerRadius(value: 5)
    }
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(sender:AnyObject) {
        fetchAccountData()
        getJoinedLeagues()
        setNoDataLabel()
        aTableView.reloadData()
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
                    let responseModel = try JSONDecoder().decode(Array<JoinLeagueResponse>.self, from: responseData)
                    if responseModel[0].status == 0 {
                        self.aNoDataLabel.isHidden = false
                    } else {
                        self.myJoinedLeagueData = responseModel
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
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
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    fileprivate func viewCloseAction() {
        winnerBreakUpView?.removeFromSuperview()
        winnerBreakUpView = nil
        confirmationView?.removeFromSuperview()
        confirmationView = nil
    }
    
    func inviteAction(code: String) {
        let textToShare = [ "Here I challenge you to join my challenge Click \(kAppStoreURL) to download Club11 app & use my code \(code) to Play with me." ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.mail ]
        self.present(activityViewController, animated: true, completion: nil)
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
    
    func openCreateTeamVC() {
        openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.contestData
            vc.teamNumber = "\(self.myTeamsData.count + 1)"
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
    
    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
        getJoinedLeagues()
        setNoDataLabel()
        fetchAccountData()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.openConfirmationView(teams: self.myTeamsData, entryFee: self.tempFee, challengeID: self.tempCID)
        }
    }
    
    @IBAction func unwindToAddAccount(segue: UIStoryboardSegue) {
        getJoinedLeagues()
        setNoDataLabel()
        fetchAccountData()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.openConfirmationView(teams: self.myTeamsData, entryFee: self.tempFee, challengeID: self.tempCID)
        }
    }
    
    func openLeaderboard(challengeId: Int, league: JoinLeagueResponse, entreFee: Double) {
        openViewController(controller: LeaderBooardViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchKey = self.matchKey
            vc.challengeId = challengeId
            vc.league = league
            vc.contestData = self.contestData
            vc.myTeamsData = self.myTeamsData
            vc.entreeFee = entreFee
            vc.homeType = .upcomming
        }
    }
}

extension JoinedContestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myJoinedLeagueData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JoinedContestTableViewCell.identifier(), for: indexPath) as! JoinedContestTableViewCell
        let leagues = myJoinedLeagueData[indexPath.row]
        cell.configureCell(data: leagues)
        cell.winnerButtonClouser = {[weak self] cId, amt in
            if let strongSelf = self {
                strongSelf.getWinnerBreakupData(challengeId: cId, ammount: amt)
            }
        }
        cell.joinButtonClouser = {[weak self] cId, fee  in
            if let strongSelf = self {
                if strongSelf.myTeamsData.count == 0 {
                    strongSelf.openCreateTeamVC()
                } else {
                    strongSelf.tempCID = cId
                    strongSelf.tempFee = fee
                    strongSelf.openConfirmationView(teams: strongSelf.myTeamsData, entryFee: fee, challengeID: cId)
                }
            }
        }
        cell.inviteButtonClouser = {[weak self] iCode  in
            if let strongSelf = self {
                strongSelf.inviteAction(code: iCode)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kContestTVCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cID = myJoinedLeagueData[indexPath.row].challenge_id, let fees = myJoinedLeagueData[indexPath.row].entryfee {
            openLeaderboard(challengeId: cID, league: myJoinedLeagueData[indexPath.row], entreFee: fees)
        }
    }
}
