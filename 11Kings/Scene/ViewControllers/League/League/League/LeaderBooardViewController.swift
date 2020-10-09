//
//  LeaderBooardViewController.swift
//  Club11
//
//  Created by Developer on 09/06/19.
//

import UIKit

class LeaderBooardViewController: BaseViewController {
    
    @IBOutlet weak var aBottomButtonContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var aBottomButtonContainerView: UIView!
    @IBOutlet weak var aVSLabel: UILabel!
    @IBOutlet weak var aTimerContainerView: UIView!
    @IBOutlet weak var aTimeLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var availableBalance = ""
    var usableBalance = ""
    var confirmationView: ConfirmationView?
    var myTeamsData = [MyTeamResponse]()
    var entreeFee = 0.0
    var winnerBreakUpView: WinnerBreakupView?
    var contestData: Any?
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var matchKey = ""
    var challengeId = 0
    var league: Any?
    var leaderBoardArray = [LeaderBoardResponse]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var joinedID = 0
    var homeType: HomeType = .upcomming
    var pdfURLStr = ""
    var amount = 0.0
    var winning = ""
    var winners = 0
    var myBalanceDataArray = [MyBalanceModel]() {
        didSet {
            setAccountData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setCornerRadius()
        addPullToRefresh() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Contest", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: true)
        setContestData()
        getLeaderboardData()
        fetchAccountData()
        if homeType == .upcomming {
            aBottomButtonContainerView.isHidden = false
            aBottomButtonContainerHeightConstraint.constant = 50
        } else {
            aBottomButtonContainerView.isHidden = true
            aBottomButtonContainerHeightConstraint.constant = 0
        }
    }
    
    fileprivate func registerCell() {
        aTableView.register(UINib(nibName: LeaderBoardTeamTVCell.identifier(), bundle: nil), forCellReuseIdentifier: LeaderBoardTeamTVCell.identifier())
        aTableView.register(UINib(nibName: LeaderBoardContestTVCell.identifier(), bundle: nil), forCellReuseIdentifier: LeaderBoardContestTVCell.identifier())
        aTableView.register(UINib(nibName: LeaderBoardHeaderTVCell.identifier(), bundle: nil), forCellReuseIdentifier: LeaderBoardHeaderTVCell.identifier())
    }
    
    fileprivate func setCornerRadius() {
        aTimerContainerView.setCornerRadius(value: 5)
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
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(sender:AnyObject) {
        getLeaderboardData()
        fetchAccountData()
        if homeType == .upcomming {
            aBottomButtonContainerView.isHidden = false
            aBottomButtonContainerHeightConstraint.constant = 50
        } else {
            aBottomButtonContainerView.isHidden = true
            aBottomButtonContainerHeightConstraint.constant = 0
        }
        aTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    fileprivate func setContestData() {
        if let contest = contestData as? LiveMatchResponse {
            aVSLabel.text = "\(contest.team1name ?? "") vs \(contest.team2name ?? "")"
            setReleaseTime(releaseDateString: contest.time_start ?? "0")
        }
        if let contest = contestData as? MyContestReponse {
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
    
    @IBAction func joinButtonAction(_ sender: UIButton) {
        if myTeamsData.count == 0 {
            openCreateTeamVC()
        } else {
            openConfirmationView()
        }
    }
    
    @IBAction func switchTeamAction(_ sender: UIButton) {
        openViewController(controller: SwitchTeamViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchKey = self.matchKey
            vc.challengeId = self.challengeId
            vc.contestData = self.contestData
            vc.joinedID = self.joinedID
        }
    }
    
    func getLeaderboardData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey, "challenge_id": challengeId] as [String : Any]
        
        NetworkManager.post_Request(urlService: kLeaderboardURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([LeaderBoardResponse].self, from: responseData)
                    self.leaderBoardArray = responseModel
                    if responseModel.count > 0 {
                        self.joinedID = responseModel[0].join_id ?? 0
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
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
    
    func openConfirmationView() {
        if confirmationView == nil {
            confirmationView = Bundle.main.loadNibNamed("ConfirmationView", owner: self, options: nil)?.first as? ConfirmationView
            confirmationView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            APP_DEL.window?.addSubview(confirmationView!)
            confirmationView?.myTeamsData = myTeamsData
            confirmationView?.availableBalance = availableBalance
            confirmationView?.usableBalance = usableBalance
            confirmationView?.entryFees = entreeFee
            confirmationView?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.viewCloseAction()
                }
            }
            confirmationView?.joinButtonClouser = { [weak self] teamID in
                if let strongSelf = self {
                    strongSelf.joinContest(challengeId: strongSelf.challengeId, teamID: teamID)
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
    
    func openCreateTeamVC() {
        openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.contestData
            vc.teamNumber = "\(self.myTeamsData.count + 1)"
        }
    }
    
    fileprivate func viewCloseAction() {
        winnerBreakUpView?.removeFromSuperview()
        winnerBreakUpView = nil
        confirmationView?.removeFromSuperview()
        confirmationView = nil
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
    
    func openTermsAndCondition(){
        openViewController(controller: TermsAndConditionViewController.self, storyBoard: .moreStoryBoard, handler: { (vc) in
            
        })
    }
    
    override func handleBackButtonAction() -> Void {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
        getLeaderboardData()
        fetchAccountData()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.openConfirmationView()
        }
    }
    
    func openAddMoneyVC() {
        openViewController(controller: AddMoneyViewController.self, storyBoard: .accountStoryBoard, handler: { (vc) in
            vc.isFromVC = self
        })
    }
    
    func openTeamPreview(teamID: Int, challengeID: Int, userID: Int) {
        openViewController(controller: PreviewViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.teamId = teamID
            vc.contestData = self.contestData
            vc.isFromLeaderBoard = true
            vc.challengeID = challengeID
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
        let fileName = String((url!.lastPathComponent)) as NSString
        // Create destination URL
        guard let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as? URL else {
            return
        }
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
        //Create URL to the source file you want to download
        let fileURL = URL(string: pdfURLStr)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
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
                                self.present(activityViewController, animated: true, completion: nil)
                            }
                        }
                    }
                    catch (let err) {
                        print("error: \(err)")
                    }
                } catch (let writeError) {
                    Loader.showToast(message: "File already exist", onView: self.view, bottomMargin: 200)
                    print("\(writeError)")
                }
            } else {
                Loader.showToast(message: "Unable to find PDF", onView: self.view, bottomMargin: 200)
                print("\(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
    }
}

extension LeaderBooardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderBoardArray.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardContestTVCell.identifier(), for: indexPath) as! LeaderBoardContestTVCell
            cell.homeType = homeType
            if let leagueData = league {
                cell.configureCellForUpcommimg(league: leagueData, homeType: homeType)
            } else {
                cell.configureCell(homeType: homeType, entryFee: entreeFee, amount: amount, chalID: challengeId, winning: winning, winners: winners)
            }
            cell.winnerButtonClouser = {[weak self] cId, amt in
                if let strongSelf = self {
                    strongSelf.getWinnerBreakupData(challengeId: cId, ammount: amt)
                }
            }
            cell.downloadButtonClouser = {[weak self] in
                if let strongSelf = self {
                    strongSelf.downloadButtonAction()
                }
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardHeaderTVCell.identifier(), for: indexPath) as! LeaderBoardHeaderTVCell
            cell.configureCell(count: leaderBoardArray.count, homeType: homeType)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardTeamTVCell.identifier(), for: indexPath) as! LeaderBoardTeamTVCell
            cell.configureCell(teams: leaderBoardArray[indexPath.row - 2], homeType: homeType)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            switch homeType {
            case .live:
                return 130
            case .result:
                return 130
            case .upcomming:
                return UITableView.automaticDimension
            }
        } else if indexPath.row == 1 {
            return 30
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else if indexPath.row == 1 {
            
        } else {
            if homeType != .upcomming {
                let data = leaderBoardArray[indexPath.row - 2]
                if let tID = data.team_id, let cID = data.challenge_id, let uID = data.user_id {
                   openTeamPreview(teamID: tID, challengeID: cID, userID: uID)
                }
            } else {
                 Loader.showToast(message: "You can preview team after match start", onView: self.view, bottomMargin: 200)
                
            }
        }
    }
}
