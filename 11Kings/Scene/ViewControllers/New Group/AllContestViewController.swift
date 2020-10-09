////
////  AllContestViewController.swift
////  FantasyCricket
////
////  Created by Developer on 27/05/19.
////
//
import UIKit
//
class AllContestViewController: BaseClass {
//
}
//    @IBOutlet weak var aEntryFeeImageView: UIImageView!
//    @IBOutlet weak var aWinnersImageView: UIImageView!
//    @IBOutlet weak var aTeamImageView: UIImageView!
//    @IBOutlet weak var aWinningImageView: UIImageView!
//    @IBOutlet weak var aJoinedCount: UILabel!
//    @IBOutlet weak var aMyTeamsCount: UILabel!
//    @IBOutlet weak var aVSLabel: UILabel!
//    @IBOutlet weak var aTimerContainerView: UIView!
//    @IBOutlet weak var aTimeLabel: UILabel!
//    @IBOutlet weak var aContestTableView: UITableView!
//    @IBOutlet weak var aMyTeamButton: UIButton!
//    @IBOutlet weak var aJoinedContestButton: UIButton!
//
//    var refreshControl = UIRefreshControl()
//    var matchKey = ""
//    var availableBalance = ""
//    var usableBalance = ""
//    var winnerBreakUpView: WinnerBreakupView?
//   // var confirmationView: ConfirmationView?
//    var allLeagueData = [Leagues]()
//    var contestData: Any?
//    var releaseDate: NSDate?
//    var countdownTimer = Timer()
////    var myTeamsData = [MyTeamResponse]() {
////        didSet {
////            setMyTeamButtonData()
////        }
////    }
//   // var myJoinedLeagueData = [JoinLeagueResponse]()
//    var tempCID = 0
//    var tempFees = 0.0
//    var homeType: HomeType = .upcomming
////    var myBalanceDataArray = [MyBalanceModel]() {
////        didSet {
////            setAccountData()
////        }
////    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        registerCell()
//        setContestData()
//        setCornerRadius()
//        addPullToRefresh()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        addNavigationBar(navigationTitle: "Contest", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: true)
//        setMyTeamButtonData()
//        seJoinedLeagueButtonData()
//        getMyTeams()
//        fetchAccountData()
//    }
//
//    fileprivate func registerCell() {
//        aContestTableView.register(UINib(nibName: "ContestCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ContestCategoryTableViewCell")
//    }
//
//    func addPullToRefresh() {
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
//        aContestTableView.refreshControl = refreshControl
//    }
//
//    @objc func refreshData(sender:AnyObject) {
//        fetchAccountData()
//        setMyTeamButtonData()
//        seJoinedLeagueButtonData()
//        getMyTeams()
//        aContestTableView.reloadData()
//        self.refreshControl.endRefreshing()
//    }
//
//    fileprivate func setContestData() {
//        if let contest = contestData as? LiveMatchResponse {
//            aVSLabel.text = "\(contest.team1name ?? "") vs \(contest.team2name ?? "")"
//            setReleaseTime(releaseDateString: contest.time_start ?? "0")
//        }
//        if let contest = contestData as? MyContestReponse {
//            aVSLabel.text = "\(contest.team1display ?? "") vs \(contest.team2display ?? "")"
//            setReleaseTime(releaseDateString: contest.start_date ?? "0")
//        }
//    }
//
//    fileprivate func setCornerRadius() {
//        aTimerContainerView.setCornerRadius(value: 5)
//        aMyTeamsCount.setBorder(color: .white, size: 1)
//        aMyTeamsCount.setCornerRadius(value: 2)
//        aJoinedCount.setBorder(color: .white, size: 1)
//        aJoinedCount.setCornerRadius(value: 2)
//    }
//
//    fileprivate func setReleaseTime(releaseDateString: String) {
//        let releaseDateFormatter = DateFormatter()
//        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
//        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//    }
//
//    @objc func updateTime() {
//        let currentDate = Date()
//        let calendar = Calendar.current
//        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
//        var day = diffDateComponents.day ?? 00
//        var hour = diffDateComponents.hour ?? 00
//        var minute = diffDateComponents.minute ?? 00
//        var second = diffDateComponents.second ?? 00
//        if day < 0 {
//            day = 0
//        }
//        if hour < 0 {
//            hour = 0
//        }
//        if minute < 0 {
//            minute = 0
//        }
//        if second < 0 {
//            second = 0
//        }
//        let countdown = "\(Utility.getStringFrom(seconds: day))D \(Utility.getStringFrom(seconds: hour))H \(Utility.getStringFrom(seconds: minute))M \(Utility.getStringFrom(seconds: second))S"
//        switch homeType {
//        case .live:
//            aTimeLabel.text = "In Progress"
//            aTimeLabel.textColor = .orange
//        case .result:
//            aTimeLabel.text = "Winner Declared"
//            aTimeLabel.textColor = UIColor(red: 93 / 255, green: 180 / 255, blue: 84 / 255, alpha: 1.0)
//        case .upcomming:
//            aTimeLabel.text = countdown
//            aTimeLabel.textColor = .orange
//        }
//        if day == 0 && hour == 0 && minute == 0 && second == 0 {
//            countdownTimer.invalidate()
//        }
//    }
//
//    func fetchAccountData() {
////        showActivityIndicator(sMessage: "Loading...")
////        let headers = [
////            "content-type": "application/x-www-form-urlencoded",
////            "cache-control": "no-cache"
////        ]
////        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1]
////        NetworkManager.post_Request(urlService: kMyBalance, param: parameters, head: headers) { (response) in
////            self.hideActivityIndicator()
////            do {
////                if response != nil {
////                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
////                    let responseModel = try JSONDecoder().decode(Array<MyBalanceModel>.self, from: responseData)
////                    if responseModel.count > 0 {
////                        self.myBalanceDataArray = responseModel
////                    } else {
////                        Loader.showAlert(message: "Unable to get account data")
////                    }
////                }
////            } catch {
////                Loader.showAlert(message: "Status code 500: server internal error")
////            }
////        }
//    }
//
//    fileprivate func getLeagues() {
//        //        showActivityIndicator(sMessage: "Loading...")
//        //        let headers = [
//        //            "content-type": "application/x-www-form-urlencoded",
//        //            "cache-control": "no-cache",
//        //        ]
//        //        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey] as [String : Any]
//        //
//        //        NetworkManager.post_Request(urlService: kGetChallengeURL, param: parameters, head: headers) { (response) in
//        //            self.hideActivityIndicator()
//        //            do {
//        //                if response != nil {
//        //                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
//        //                    let responseModel = try JSONDecoder().decode(HomeContestResponse.self, from: responseData)
//        //                    if let categories = responseModel.categories {
//        //                        self.contestCategories = categories
//        //                        for data in categories {
//        //                            if let leagues = data.leagues {
//        //                                for league in leagues {
//        //                                    self.allContestData.append(league)
//        //                                }
//        //                            }
//        //                        }
//        //                    }
//        //                    self.aContestCountLabel.text = "  \(self.allContestData.count)  "
//        //                    self.aContestTableView.reloadData()
//        //                }
//        //            } catch {
//        //        Loader.showAlert(message: "Status code 500: server internal error")
//        //            }
//        //        }
//    }
//
//    fileprivate func getMyTeams() {
////        showActivityIndicator(sMessage: "Loading...")
////        let headers = [
////            "content-type": "application/x-www-form-urlencoded",
////            "cache-control": "no-cache"
////        ]
////        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey] as [String : Any]
////
////        NetworkManager.post_Request(urlService: kMyTeamURL, param: parameters, head: headers) { (response) in
////            self.hideActivityIndicator()
////            do {
////                if response != nil {
////                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
////                    let responseModel = try JSONDecoder().decode([MyTeamResponse].self, from: responseData)
////                    self.myTeamsData = responseModel
////                }
////            } catch {
////                Loader.showAlert(message: "Status code 500: server internal error")
////            }
////        }
//    }
//
//    @IBAction func joinedButtonAction(_ sender: UIButton) {
////        openViewController(controller: JoinedContestViewController.self, storyBoard: .homeStoryBoard) { (vc) in
////            vc.myJoinedLeagueData = self.myJoinedLeagueData
////            vc.contestData = self.contestData
////            vc.myTeamsData = self.myTeamsData
////        }
//    }
//
//    @IBAction func myTeamButtonAction(_ sender: UIButton) {
////        openViewController(controller: MyTeamViewController.self, storyBoard: .homeStoryBoard) { (vc) in
////            vc.myTeamsData = self.myTeamsData
////            vc.contestData = self.contestData
////        }
//    }
//
//    func setMyTeamButtonData() {
//        aMyTeamsCount.text = "  \(myTeamsData.count)  "
//    }
//
//    func seJoinedLeagueButtonData() {
//        aJoinedCount.text = "  \(myJoinedLeagueData.count)  "
//    }
//
//    override func handleBackButtonAction() {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    func getWinnerBreakupData(challengeId: Int, ammount: Double) {
////        showActivityIndicator(sMessage: "Loading...")
////        let headers = [
////            "content-type": "application/x-www-form-urlencoded",
////            "cache-control": "no-cache"
////        ]
////        let parameters = ["challenege_id": challengeId, "matchkey": matchKey] as [String : Any]
////
////        NetworkManager.post_Request(urlService: kWinnerbreakUpURL, param: parameters, head: headers) { (response) in
////            self.hideActivityIndicator()
////            do {
////                if response != nil {
////                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
////                    let responseModel = try JSONDecoder().decode([WinnerbreakUpResponse].self, from: responseData)
////                    self.openWinnerBreakupView(winnerArr: responseModel, ammount: ammount)
////                }
////            } catch {
////                Loader.showAlert(message: "Status code 500: server internal error")
////            }
////        }
//    }
//
//    func openWinnerBreakupView(winnerArr: [WinnerbreakUpResponse], ammount: Double) {
////        if winnerArr.count == 0 {
////            Loader.showToast(message: "No Winner Breakup", onView: self.view, bottomMargin: 200)
////            return
////        }
////        if winnerBreakUpView == nil {
////            winnerBreakUpView = Bundle.main.loadNibNamed("WinnerBreakupView", owner: self, options: nil)?.first as? WinnerBreakupView
////            winnerBreakUpView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
////            APP_DEL.window?.addSubview(winnerBreakUpView!)
////            winnerBreakUpView?.winnerBreakupArr = winnerArr
////            winnerBreakUpView?.totalAmmount = ammount
////            winnerBreakUpView?.closeButtonClouser = { [weak self] in
////                if let strongSelf = self {
////                    strongSelf.viewCloseAction()
////                }
////            }
////        }
//    }
//
//    func openConfirmationView(teams: [MyTeamResponse], entryFee: Double, challengeID: Int) {
////        if confirmationView == nil {
////            confirmationView = Bundle.main.loadNibNamed("ConfirmationView", owner: self, options: nil)?.first as? ConfirmationView
////            confirmationView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
////            APP_DEL.window?.addSubview(confirmationView!)
////            confirmationView?.myTeamsData = teams
////            confirmationView?.availableBalance = availableBalance
////            confirmationView?.usableBalance = usableBalance
////            confirmationView?.entryFees = entryFee
////            confirmationView?.closeButtonClouser = { [weak self] in
////                if let strongSelf = self {
////                    strongSelf.viewCloseAction()
////                }
////            }
////            confirmationView?.joinButtonClouser = { [weak self] teamID in
////                if let strongSelf = self {
////                    strongSelf.joinContest(challengeId: challengeID, teamID: teamID)
////                }
////            }
////            confirmationView?.termsConditionButtonClouser = { [weak self] in
////                if let strongSelf = self {
////                    strongSelf.viewCloseAction()
////                    strongSelf.openTermsAndCondition()
////                }
////            }
////        }
//    }
//
//    func joinContest(challengeId: Int, teamID: Int) {
////        showActivityIndicator(sMessage: "Loading...")
////        let headers = [
////            "content-type": "application/x-www-form-urlencoded",
////            "cache-control": "no-cache"
////        ]
////        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey, "challengeid": challengeId,"teamid": teamID] as [String : Any]
////
////        NetworkManager.post_Request(urlService: kJoinContest, param: parameters, head: headers) { (response) in
////            self.hideActivityIndicator()
////            do {
////                if response != nil {
////                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
////                    let responseModel = try JSONDecoder().decode([JoinContest].self, from: responseData)
////                    if let responseMessage = responseModel[0].message {
////                        if kInsufficientBalance.caseInsensitiveCompare(responseMessage) == .orderedSame {
////                            self.viewCloseAction()
////                            self.openAddMoneyVC()
////                        } else if kPleaseSelectTeam.caseInsensitiveCompare(responseMessage) == .orderedSame {
////                            Loader.showToast(message: responseMessage, onView: self.view, bottomMargin: 200)
////                        } else {
////                            self.viewCloseAction()
////                            Loader.showToast(message: responseMessage, onView: self.view, bottomMargin: 200)
////                        }
////                    }
////                }
////            } catch {
////                Loader.showAlert(message: "Status code 500: server internal error")
////            }
////        }
//    }
//
//    fileprivate func viewCloseAction() {
//        winnerBreakUpView?.removeFromSuperview()
//        winnerBreakUpView = nil
//        confirmationView?.removeFromSuperview()
//        confirmationView = nil
//    }
//
//    func setAccountData() {
//        guard myBalanceDataArray.count > 0  else {
//            return
//        }
//        let data = myBalanceDataArray[0]
//        usableBalance = "\(kRupeeIcon ) \(data.winning ?? 0)"
//        availableBalance = "\(kRupeeIcon) \(data.totalamount ?? 0)"
//    }
//
//    func openLeaderboard(challengeId: Int, league: Leagues, entreFee: Double) {
////        openViewController(controller: LeaderBooardViewController.self, storyBoard: .homeStoryBoard) { (vc) in
////            vc.matchKey = self.matchKey
////            vc.challengeId = challengeId
////            vc.league = league
////            vc.contestData = self.contestData
////            vc.myTeamsData = self.myTeamsData
////            vc.entreeFee = entreFee
////            vc.homeType = self.homeType
////        }
//    }
//
//    @IBAction func winningButtonAction(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
////        if sender.isSelected {
////            aWinningImageView.image = UIImage(named: "Arrow_Sort_UP")
////            aTeamImageView.image = UIImage(named: "")
////            aWinnersImageView.image = UIImage(named: "")
////            aEntryFeeImageView.image = UIImage(named: "")
////            allLeagueData = allLeagueData.sorted(by: { (obj1, obj2) -> Bool in
////                return obj1.win_amount ?? 0 < obj2.win_amount ?? 0
////            })
////        } else {
////            aWinningImageView.image = UIImage(named: "Arrow_Sort_Down")
////            aTeamImageView.image = UIImage(named: "")
////            aWinnersImageView.image = UIImage(named: "")
////            aEntryFeeImageView.image = UIImage(named: "")
////            allLeagueData = allLeagueData.sorted(by: { (obj1, obj2) -> Bool in
////                return obj1.win_amount ?? 0 > obj2.win_amount ?? 0
////            })
////        }
////        aContestTableView.reloadDataInMainQueue()
//    }
//
//    @IBAction func teamButtonAction(_ sender: UIButton) {
////        sender.isSelected = !sender.isSelected
////        if sender.isSelected {
////            aWinningImageView.image = UIImage(named: "")
////            aTeamImageView.image = UIImage(named: "Arrow_Sort_UP")
////            aWinnersImageView.image = UIImage(named: "")
////            aEntryFeeImageView.image = UIImage(named: "")
////            allLeagueData = allLeagueData.sorted(by: { (obj1, obj2) -> Bool in
////                return obj1.maximum_user ?? 0 < obj2.maximum_user ?? 0
////            })
////        } else {
////            aWinningImageView.image = UIImage(named: "")
////            aTeamImageView.image = UIImage(named: "Arrow_Sort_Down")
////            aWinnersImageView.image = UIImage(named: "")
////            aEntryFeeImageView.image = UIImage(named: "")
////            allLeagueData = allLeagueData.sorted(by: { (obj1, obj2) -> Bool in
////                return obj1.maximum_user ?? 0 > obj2.maximum_user ?? 0
////            })
////        }
////        aContestTableView.reloadDataInMainQueue()
//    }
//
//    @IBAction func winnersButtonAction(_ sender: UIButton) {
////        sender.isSelected = !sender.isSelected
////        if sender.isSelected {
////            aWinningImageView.image = UIImage(named: "")
////            aTeamImageView.image = UIImage(named: "")
////            aWinnersImageView.image = UIImage(named: "Arrow_Sort_UP")
////            aEntryFeeImageView.image = UIImage(named: "")
////            allLeagueData = allLeagueData.sorted(by: { (obj1, obj2) -> Bool in
////                return obj1.totalwinners ?? "0" < obj2.totalwinners ?? "0"
////            })
////        } else {
////            aWinningImageView.image = UIImage(named: "")
////            aTeamImageView.image = UIImage(named: "")
////            aWinnersImageView.image = UIImage(named: "Arrow_Sort_Down")
////            aEntryFeeImageView.image = UIImage(named: "")
////            allLeagueData = allLeagueData.sorted(by: { (obj1, obj2) -> Bool in
////                return obj1.totalwinners ?? "0" > obj2.totalwinners ?? "0"
////            })
////        }
//        aContestTableView.reloadDataInMainQueue()
//    }
//
//    @IBAction func entryFeeButtonAction(_ sender: UIButton) {
////        sender.isSelected = !sender.isSelected
////        if sender.isSelected {
////            aWinningImageView.image = UIImage(named: "")
////            aTeamImageView.image = UIImage(named: "")
////            aWinnersImageView.image = UIImage(named: "")
////            aEntryFeeImageView.image = UIImage(named: "Arrow_Sort_UP")
////            allLeagueData = allLeagueData.sorted(by: { (obj1, obj2) -> Bool in
////                return Int(obj1.entryfee ?? 0) < Int(obj2.entryfee ?? 0)
////            })
////        } else {
////            aWinningImageView.image = UIImage(named: "")
////            aTeamImageView.image = UIImage(named: "")
////            aWinnersImageView.image = UIImage(named: "")
////            aEntryFeeImageView.image = UIImage(named: "Arrow_Sort_Down")
////            allLeagueData = allLeagueData.sorted(by: { (obj1, obj2) -> Bool in
////                return Int(obj1.entryfee ?? 0) > Int(obj2.entryfee ?? 0)
////            })
////        }
////        aContestTableView.reloadDataInMainQueue()
//    }
//
//    func openCreateTeamVC() {
////        openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
////            vc.contestData = self.contestData
////            vc.teamNumber = "\(self.myTeamsData.count + 1)"
////        }
//    }
//
//    func openTermsAndCondition(){
////        openViewController(controller: TermsAndConditionViewController.self, storyBoard: .moreStoryBoard, handler: { (vc) in
////
////        })
//    }
//
//    func openAddMoneyVC() {
////        openViewController(controller: AddMoneyViewController.self, storyBoard: .accountStoryBoard, handler: { (vc) in
////            vc.isFromVC = self
////        })
//    }
//
//    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
//        fetchAccountData()
//        setMyTeamButtonData()
//        seJoinedLeagueButtonData()
//        getMyTeams()
//        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
//            self.openConfirmationView(teams: self.myTeamsData, entryFee: self.tempFees, challengeID: self.tempCID)
//        }
//    }
//
//    @IBAction func unwindToAddAccount(segue: UIStoryboardSegue) {
//        fetchAccountData()
//        setMyTeamButtonData()
//        seJoinedLeagueButtonData()
//        getMyTeams()
//        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
//            self.openConfirmationView(teams: self.myTeamsData, entryFee: self.tempFees, challengeID: self.tempCID)
//        }
//    }
//}
//
//extension AllContestViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return allLeagueData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ContestCategoryTableViewCell", for: indexPath) as! ContestCategoryTableViewCell
//        cell.configureCell(league: allLeagueData[indexPath.row])
//        cell.winnerButtonClouser = {[weak self] cId, amt  in
//            if let strongSelf = self {
//                strongSelf.getWinnerBreakupData(challengeId: cId, ammount: amt)
//            }
//        }
//        cell.joinButtonClouser = {[weak self] cId, fee  in
//            if let strongSelf = self {
//                if strongSelf.myTeamsData.count == 0 {
//                    strongSelf.tempCID = cId
//                    strongSelf.tempFees = fee
//                    strongSelf.openCreateTeamVC()
//                } else {
//                    strongSelf.openConfirmationView(teams: strongSelf.myTeamsData, entryFee: fee, challengeID: cId)
//                }
//            }
//        }
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return kContestTVCellHeight
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cID = allLeagueData[indexPath.row].id, let fees = allLeagueData[indexPath.row].entryfee {
//            openLeaderboard(challengeId: cID, league: allLeagueData[indexPath.row], entreFee: fees)
//        }
//    }
//}
