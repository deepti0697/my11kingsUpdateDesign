//
//  ContestWinnerBreakupVC.swift
//  Club11
//
//  Created by Developer on 09/06/19.
//

import UIKit

class ContestWinnerBreakupVC: BaseViewController {
    
    @IBOutlet weak var aSetButton: UIButton!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aNumberOfWinnersTextField: UITextField!
    
    var refreshControl = UIRefreshControl()
    var contestData: Any?
    var entryFee = 0.0
    var numberOfPlyers = 0.0
    var totalAmount = 0.0
    var isMultipleJoin = false
    var numberOfWinners = 0
    var winnerAmountArray = [Double]()
    var winnerPercentageArray = [Double]()
    var matchKey = ""
    var contestName = ""
    var confirmationView: ConfirmationView?
    var availableBalance = ""
    var usableBalance = ""
    var myTeamsData = [MyTeamResponse]()
    var isBreakupSet = false
    var tempCID = 0
    var myBalanceDataArray = [MyBalanceModel]() {
        didSet {
            setAccountData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.register(UINib(nibName: ContestWinnerTVCell.identifier(), bundle: nil), forCellReuseIdentifier: ContestWinnerTVCell.identifier())
        aSetButton.setCornerRadiusButton(value: 5)
        addPullToRefresh() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Set Winning Breakup", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: true)
        getMyTeams()
        fetchAccountData()
    }
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(sender:AnyObject) {
        fetchAccountData()
        getMyTeams()
        aTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    fileprivate func getMyTeams() {
        showActivityIndicator(sMessage: "Loading...")
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
    
    @IBAction func setButtonAction(_ sender: Any) {
        if let text = aNumberOfWinnersTextField.text {
            if let textInt = Int(text) {
                if textInt >= 1 {
                    numberOfWinners = textInt
                    getInitialWinnerBreakup()
                    isBreakupSet = true
                } else {
                    self.view.endEditing(true)
                    Loader.showToast(message: "Number Of winners is more then 1", onView: self.view, bottomMargin: 200)
                }
            }
        } else {
            self.view.endEditing(true)
            Loader.showToast(message: "Please enter number of winners", onView: self.view, bottomMargin: 200)
        }
    }
    
    func getInitialWinnerBreakup() {
        winnerAmountArray.removeAll()
        winnerPercentageArray.removeAll()
        let amt =  totalAmount / Double(numberOfWinners)
        for _ in 1...numberOfWinners {
            winnerAmountArray.append(amt)
        }
        let percentage = 100 / Double(numberOfWinners)
        for _ in 1...numberOfWinners {
            winnerPercentageArray.append(percentage)
        }
        aTableView.reloadDataInMainQueue()
    }
    
    func getWinnerBreakupForUpdate(updatedText: Double, index: Int) {
        let tempArray = winnerPercentageArray
        winnerPercentageArray[index] = updatedText
        let nextIndex = index + 1
        var previousPercentage = 0.0
        for ind in 0...index {
            previousPercentage += winnerPercentageArray[ind]
        }
        let remainingPercentage = 100.0 - previousPercentage
        if remainingPercentage < 0 {
            Loader.showToast(message: "Winning percentage maximum 100%", onView: self.view, bottomMargin: 200)
            winnerPercentageArray = tempArray
            for ind in 0...numberOfWinners - 1 {
                let amount = ((totalAmount * winnerPercentageArray[ind]) / 100)
                winnerAmountArray[ind] = amount
            }
        } else {
            let remainingIndex = Double(numberOfWinners - nextIndex)
            let percentageForRemainings = remainingPercentage / remainingIndex
            for ind in nextIndex...numberOfWinners - 1 {
                winnerPercentageArray[ind] = percentageForRemainings
            }
            for ind in 0...numberOfWinners - 1 {
                let amount = ((totalAmount * winnerPercentageArray[ind]) / 100)
                winnerAmountArray[ind] = amount
            }
        }
        aTableView.reloadDataInMainQueue()
    }
    
    func getPriceCards() -> String {
        var amountArray = [String]()
        for amount in winnerAmountArray {
            let amtStr = "\(amount)"
            amountArray.append(amtStr)
        }
        let priceCard = amountArray.joined(separator: ",")
        return priceCard
    }
    
    @IBAction func createChallengeAction(_ sender: Any) {
        if !isBreakupSet {
            Loader.showToast(message: "Please select number of teams", onView: self.view, bottomMargin: 200)
            return
        }
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1, "matchkey": matchKey, "win_amount": "\(totalAmount)", "maximum_user": "\(numberOfPlyers)", "entryfee": "\(entryFee)", "pricecards": getPriceCards(), "name": contestName]
        NetworkManager.post_Request(urlService: kCreateChallengeURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([CreateContestResponse].self, from: responseData)
                    if let response = responseModel[0].message {
                        if response {
                            guard let cID = responseModel[0].challengeid else {
                                Loader.showToast(message: "Challenge Not Created", onView: self.view, bottomMargin: 200)
                                return
                            }
                            Loader.showToast(message: "Challenge Created:\(cID)", onView: self.view, bottomMargin: 200)
                            self.JoinCreatedContest(challengeID: cID)
                        } else {
                            Loader.showToast(message: "Challenge Not Created", onView: self.view, bottomMargin: 200)
                        }
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func JoinCreatedContest(challengeID: Int) {
        if myTeamsData.count == 0 {
            openCreateTeamVC()
        } else {
            tempCID = challengeID
            openConfirmationView(challengeID: challengeID)
        }
    }
    
    func openConfirmationView(challengeID: Int) {
        if confirmationView == nil {
            confirmationView = Bundle.main.loadNibNamed("ConfirmationView", owner: self, options: nil)?.first as? ConfirmationView
            confirmationView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            APP_DEL.window?.addSubview(confirmationView!)
            confirmationView?.myTeamsData = myTeamsData
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
    
    func openCreateTeamVC() {
        openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.contestData
            vc.teamNumber = "\(self.myTeamsData.count + 1)"
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
                            let inviteCode = responseModel[0].refercode
                            self.inviteAction(code: inviteCode ?? "")
                        }
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func inviteAction(code: String) {
        let textToShare = [ "Here I challenge you to join my challenge Click \(kAppStoreURL) to download Club11 app & use my code \(code) to Play with me." ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.mail ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    fileprivate func viewCloseAction() {
        confirmationView?.removeFromSuperview()
        confirmationView = nil
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
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
        fetchAccountData()
        getMyTeams()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.openConfirmationView(challengeID: self.tempCID)
        }
    }
    
    @IBAction func unwindToAddAccount(segue: UIStoryboardSegue) {
        fetchAccountData()
        getMyTeams()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            self.openConfirmationView(challengeID: self.tempCID)
        }
    }
}

extension ContestWinnerBreakupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfWinners
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContestWinnerTVCell.identifier(), for: indexPath) as! ContestWinnerTVCell
        cell.tag = indexPath.row
        cell.configureCell(index: indexPath.row, amount: winnerAmountArray[indexPath.row], percent: winnerPercentageArray[indexPath.row], isLastIndex: indexPath.row == numberOfWinners - 1 ? true : false)
        cell.getPercentInput = {[weak self] str, index in
            if let strongSelf = self {
                strongSelf.getWinnerBreakupForUpdate(updatedText: str, index: index)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
