//
//  ContestWinnerBreakupVC.swift
//  Club11
//
//  Created by Developer on 09/06/19.
//

import UIKit
import SwiftyJSON
import Kingfisher
class ContestWinnerBreakupVC: BaseClass {
    
    
    @IBOutlet weak var entry: UILabel!
    @IBOutlet weak var contestSize: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var prizePoolLbl: UILabel!
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var aSetButton: UIButton!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aNumberOfWinnersTextField: UITextField!
    var contestSizes = ""
    var releaseDate: NSDate?
      var countdownTimer = Timer()
    var arraydict:[String:Any] = [:]
    var objArray:[contestWinner] = []
    var nsarr:[NSArray] = []
    var refreshControl = UIRefreshControl()
    var contestData: Any?
    var entryFee = 0.0
    var numberOfPlyers = 0.0
    var totalAmount = 0.0
    var isMultipleJoin = false
    var numberOfWinners = 0
    var winnerAmountArray = [Double]()
    var rankArray = [Int]()
    var winnerPercentageArray = [Double]()
    var matchKey = ""
    var contestName = ""
    var confirmationView: ConfirmationView?
    var availableBalance = ""
    var usableBalance = ""
    var myTeamsData = [MyTeamResponses]()
    var isBreakupSet = false
    var tempCID = 0
    var creaateContest = [CreateContestResponses]()
    //    var myBalanceDataArray = [MyBalanceModel]() {
    //        didSet {
    //            setAccountData()
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.register(UINib(nibName: ContestWinnerTVCell.identifier(), bundle: nil), forCellReuseIdentifier: ContestWinnerTVCell.identifier())
        aSetButton.setCornerRadiusButton(value: 5)
        addPullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Set Winning Breakup", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: true, isBinButtonShow: false)
        //        getMyTeams()
        setup()
        getMyTeamResponse()
        //fetchAccountData()
    }
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    func setup() {
        prizePoolLbl.text = "\(totalAmount)"
        contestSize.text = contestSizes
        entry.text = "\(entryFee)"
        if let data = contestData as? GetMatchDetails {
            team1Name.text = data.team1display
            team2Name.text = data.team2display
            if let imagePath1 = data.team1logo {

                let imageUrl = URL(string: imagePath1 )
                team1Image.kf.setImage(with: imageUrl)
            }

            if let imagePath2 = data.team2logo {


                let imageUrl = URL(string:imagePath2 )
                team2Image.kf.setImage(with: imageUrl)
            }
            if team1Image.image == nil {
                team1Image.image = #imageLiteral(resourceName: "team_placeholder")
            }
            if team2Image.image == nil {
                           team1Image.image = #imageLiteral(resourceName: "team_placeholder")
                       }
            if let time = data.time_start {
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
    override func handleWalletButtonAction() {
        openViewController(controller: AccountCollectinViewController.self, storyBoard: .accountStoryBoard) { (vc) in
              
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
        let countdown = "\(Utility.getStringFrom(seconds: hour))H \(Utility.getStringFrom(seconds: minute))M \(Utility.getStringFrom(seconds: second))S"
        timeLbl.text = countdown
        if day == 0 && hour == 0 && minute == 0 && second == 0 {
            countdownTimer.invalidate()
        }
        
    }
    
    
    
    
    @objc func refreshData(sender:AnyObject) {
        //        fetchAccountData()
        //        getMyTeams()
        getMyTeamResponse()
        aTableView.reloadData()
        self.refreshControl.endRefreshing()
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
                         "sport_key":"CRICKET"]
            NetworkManager.post_Request2(urlService: kMyTeamURL, param: param as [String : Any], head: headers) { (response) in
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
                }
                    
                    
                    
                catch{
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
    
    @IBAction func setButtonAction(_ sender: Any) {
        if let text = aNumberOfWinnersTextField.text {
            if let textInt = Int(text) {
                if textInt >= 1 {
                    if textInt > Int(contestSizes) ?? 0 {
//                        Loader.showAlert(message: "Number of winners can't be more than number of Participants")
                        self.view.makeToast(message: "Number of winners can't be more than number of Participants")
                    }
                    else {
                        numberOfWinners = textInt
                        getInitialWinnerBreakup()
                        isBreakupSet = true
                    }
                    
                } else {
                    self.view.endEditing(true)
                    Loader.showToast(message: "Number Of winners is more then 1", onView: self.view, bottomMargin: 200, color: .red)
                }
            }
        } else {
            self.view.endEditing(true)
            Loader.showToast(message: "Please enter number of winners", onView: self.view, bottomMargin: 200, color: .red)
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
    
    func getWinnerBreakupForUpdate(updatedText: Double, index: Int , rank:Int) {
        let tempArray = winnerPercentageArray
        winnerPercentageArray[index] = updatedText
        let nextIndex = index + 1
        var previousPercentage = 0.0
        for ind in 0...index {
            previousPercentage += winnerPercentageArray[ind]
        }
        let remainingPercentage = 100.0 - previousPercentage
        if remainingPercentage < 0 {
            Loader.showToast(message: "Winning percentage maximum 100%", onView: self.view, bottomMargin: 200, color: .red)
            winnerPercentageArray = tempArray
            for ind in 0...numberOfWinners - 1 {
                let amount = ((totalAmount * winnerPercentageArray[ind]) / 100)
                winnerAmountArray[ind] = amount
            }
        }
            
        else {
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
    
    func getPriceCards() -> [[String:Any]] {
        var amountArray = [String]()
        var dict = [String:Any]()
        var count = 0
        for amount in winnerAmountArray {
            let amtStr = "\(amount)"
            amountArray.append(amtStr)
            //            dict[count] = ["winningAmmount":amtStr]
            
            
        }
        for perrcent in winnerPercentageArray {
            let prcntStr = "\(perrcent)"
            dict["winningPer"] = prcntStr
            var index = 1
            dict["rank"] = index
            index += 1
        }
        
        
        //        let priceCard = amountArray.joined(separator: ",")
        
        return [dict]
    }
    
    @IBAction func createChallengeAction(_ sender: Any) {
        if !isBreakupSet {
            Loader.showToast(message: "Please select number of teams", onView: self.view, bottomMargin: 200, color: .red)
            return
        }
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDQ4MDkyOCwiZXhwIjoxNTY0NDg0NTI4LCJuYmYiOjE1NjQ0ODA5MjgsImp0aSI6IlF0aVJyanpQSzZjSVU5RDEiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.MGNiLJ9XmcJhxox3Dcn1o_8x56om0eTqeulfxuph6Vc",
            "Content-Type": "application/json",
            "Accept" : "application/json"
            
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id"), "matchkey": matchKey, "win_amount": "\(totalAmount)", "maximum_user": "\(numberOfPlyers)", "entryfee": "\(entryFee)", "pricecards": getParameters(), "name": contestName,"multi_entry": isMultipleJoin,"is_public":"0"]
            NetworkManager.post_Request2(urlService: kCreateChallengeURL, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let data = try JSON(data: response as! Data)
                        let result = data["result"]
                        for arr in result.arrayValue {
                            self.creaateContest.append(CreateContestResponses(json:arr))
                        }
                        if let response = self.creaateContest[0].message {
                            if response {
                                guard let cID = self.creaateContest[0].challengeid else {
                                    Loader.showToast(message: "Challenge Not Created", onView: self.view, bottomMargin: 200, color: .red)
                                    return
                                }
                                Loader.showToast(message: "Challenge Created:\(cID)", onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 22))
                                self.JoinCreatedContest(challengeID: cID)
                            } else {
                                Loader.showToast(message: "Challenge Not Created", onView: self.view, bottomMargin: 200, color: .red)
                            }
                        }
                    }
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }}
    
    func JoinCreatedContest(challengeID: Int) {
        if myTeamsData.count == 0 {
            openCreateTeamVC()
        } else {
            tempCID = challengeID
            openMyTeamVC(entryFee: entryFee, challengeID: tempCID)
        }
    }
    func openMyTeamVC(entryFee: Double, challengeID: Int) {
        
        openViewController(controller: MyTeamViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.myTeamsData = self.myTeamsData
            vc.contestData = self.contestData as? GetMatchDetails
            vc.challengeid = challengeID
            vc.enteryFees =  entryFee
            
            
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
            confirmationView?.entryFees = Double(entryFee)
            confirmationView?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.viewCloseAction()
                }
            }
            confirmationView?.joinButtonClouser = { [weak self] teamID in
                if let strongSelf = self {
                    // strongSelf.joinContest(challengeId: challengeID, teamID: teamID)
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
            vc.contestData = self.contestData as! GetMatchDetails
            vc.teamNumber = "\(self.myTeamsData.count + 1)"
        }
    }
    
    //    func joinContest(challengeId: Int, teamID: Int) {
    //        showActivityIndicator(sMessage: "Loading...")
    //        let headers = [
    //            "content-type": "application/x-www-form-urlencoded",
    //            "cache-control": "no-cache"
    //        ]
    //        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey, "challengeid": challengeId,"teamid": teamID] as [String : Any]
    //
    //        NetworkManager.post_Request(urlService: kJoinContest, param: parameters, head: headers) { (response) in
    //            self.hideActivityIndicator()
    //            do {
    //                if response != nil {
    //                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
    //                    let responseModel = try JSONDecoder().decode([JoinContest].self, from: responseData)
    //                    if let responseMessage = responseModel[0].message {
    //                        if kInsufficientBalance.caseInsensitiveCompare(responseMessage) == .orderedSame {
    //                            self.viewCloseAction()
    //                            self.openAddMoneyVC()
    //                        } else if kPleaseSelectTeam.caseInsensitiveCompare(responseMessage) == .orderedSame {
    //                            Loader.showToast(message: responseMessage, onView: self.view, bottomMargin: 200)
    //                        } else {
    //                            self.viewCloseAction()
    //                            Loader.showToast(message: responseMessage, onView: self.view, bottomMargin: 200)
    //                            let inviteCode = responseModel[0].refercode
    //                            self.inviteAction(code: inviteCode ?? "")
    //                        }
    //                    }
    //                }
    //            } catch {
    //                Loader.showAlert(message: "Status code 500: server internal error")
    //            }
    //        }
    //    }
    
    func inviteAction(code: String) {
        let textToShare = [ "Here I challenge you to join my challenge Click \(APP_DEL.appStoreUrl) to download My11Kings app & use my code \(code) to Play with me." ]
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
        openViewController(controller: TermAndConditionViewController.self, storyBoard: .moreStoryBoard, handler: { (vc) in
            
        })
    }
    
    func openAddMoneyVC() {
        openViewController(controller: AddMoneyViewController.self, storyBoard: .accountStoryBoard, handler: { (vc) in
            vc.isFromVC = self
        })
    }
    func getParameters() -> [[String: Any]] {
        var result = [[String: Any]]()
        
        for mmap in objArray {
            let material: [String: Any] = [
                "winningPer": mmap.percent ?? "",
                "winningAmmount": mmap.winingAmount ?? "",
                "rank": mmap.rank ?? ""]
            
            
            result.append(material)
            
            
            
        }
        
        return result
    }
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
        //  fetchAccountData()
        getMyTeamResponse()
        // getMyTeams()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            //            self.openConfirmationView(challengeID: self.tempCID)
            
        }
    }
    
    @IBAction func unwindToAddAccount(segue: UIStoryboardSegue) {
        //  fetchAccountData()
        //  getMyTeams()
        getMyTeamResponse()
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
        var obj = contestWinner()
        obj.percent = "\(winnerPercentageArray[indexPath.row])"
        obj.rank = String(indexPath.row + 1)
        obj.winingAmount = "\(winnerAmountArray[indexPath.row])"
        objArray.append(obj)
        arraydict["winningAmmount"] = "\(winnerPercentageArray[indexPath.row])"
        arraydict["winningPer"] = "\(winnerPercentageArray[indexPath.row])"
        arraydict["rank"] =  String(indexPath.row + 1)
        
        //        nsarr = objArray
        cell.getPercentInput = {[weak self] str, index,rank in
            if let strongSelf = self {
                strongSelf.getWinnerBreakupForUpdate(updatedText: str, index: index,rank: rank)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

