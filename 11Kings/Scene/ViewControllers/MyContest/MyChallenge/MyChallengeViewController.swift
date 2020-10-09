//
//  MyChallengeViewController.swift
//  Club11
//
//  Created by Developer on 28/05/19.
//

import UIKit
import SwiftyJSON
protocol goBackToMyContestFromChallenge {
    func checkBoolType(check:Bool)
}
class MyChallengeViewController: BaseClass {
    
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var announceHeight: NSLayoutConstraint!
    @IBOutlet weak var announceImage: UIImageView!
    @IBOutlet weak var announceLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var team2Name: UILabel!
     var pdfURl = ""
    var delegat : goBackToMyContestFromChallenge?
    @IBOutlet weak var aNoDataLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    var MatchType = ""
    var contestData: Any?
        
    
    var amountText:String?
    var matchKey = "" {
        didSet {
            getLeagues()
        }
    }
    var challengesArray = [ChallengeRespnse]() {
        didSet {
//            pdfURl = self.challengesArray[0].pdf ?? ""
            self.aNoDataLabel.isHidden = self.challengesArray.count == 0 ? false : true
            self.aTableView.isHidden = self.challengesArray.count == 0 ? true : false
        }
    }
    
    var homeType: HomeType = .live
var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.estimatedRowHeight = 150
        aTableView.rowHeight = UITableView.automaticDimension
        registerCell()
    }
    func addPullToRefresh() {
               refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
               refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
               aTableView.refreshControl = refreshControl
           }
           
           @objc func refreshData(sender:AnyObject) {
             getLeagues()
    //          getMyContest()
    //           setNoDataLabel()
               aTableView.reloadData()
               self.refreshControl.endRefreshing()
           }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        amountLbl.text = amountText
        setContestData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func backbutton(_ sender: Any) {
        let vc = UIStoryboard(name: "MyMatches", bundle: nil).instantiateViewController(withIdentifier: "MyContestViewViewController") as! MyContestViewViewController
                     vc.fromBack = true
               self.delegat?.checkBoolType(check: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewPlayerPoint(_ sender: Any) {
        openViewController(controller: PlayerPointViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchKey = self.matchKey
            vc.cpntestData = self.contestData
            vc.hometype = self.homeType
        }
    }
    
    fileprivate func registerCell() {
        aTableView.register(UINib(nibName: MyChallengeTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MyChallengeTableViewCell.identifier())
    }
    
    fileprivate func setContestData() {
        if let contest = contestData as? MyContestLiveLeagues {
                matchKey = contest.matchkey ?? ""
            team1Name.text = contest.team2display
            team2Name.text = contest.team1display
            if contest.announcement != "" {
                announceImage.isHidden = false
                announceLbl.isHidden = false
                announceHeight.constant = 50
            }
            else {
                announceImage.isHidden = true
                announceLbl.isHidden = true
                announceHeight.constant = 0
            }
                                
            if homeType == .live
            {
                timeLbl.text = "In Progress"
            }
            else {
                timeLbl.text = "Winner declared"
            }
//                team1displayName.text = contest.team1display
//                team2DisplayName.text = contest.team2display
//                setReleaseTime(releaseDateString: contest.time_start ?? "0")
            }
       
        if let contest = contestData as? MyContestReponse {
            matchKey = contest.matchkey ?? ""
        }
    }
    
    fileprivate func getLeagues() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                  
                  let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id") ?? "","matchkey": matchKey,"showLeaderBoard": "false"] as [String : Any]
        
        NetworkManager.post_Request2(urlService: kRefreshContestDataURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let jsonResponse = try JSON(data:response as! Data)
                    let result = jsonResponse["result"]
                    let status = jsonResponse["status"].intValue
                    let contestResult = result["contest"]
                    if status == 1 {
                        self.challengesArray.removeAll()
                    for arr in contestResult.arrayValue {
                        self.challengesArray.append(ChallengeRespnse(json: arr))
                    }
                         self.aTableView.reloadDataInMainQueue()
                    }
                    else {
                         self.aNoDataLabel.isHidden = false
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
        }
    
    }
    
    @IBAction func walletAction(_ sender: Any) {
   openViewController(controller: AccountCollectinViewController.self, storyBoard: .accountStoryBoard) { (vc) in
    }
    }
    @IBAction func openNotification(_ sender: Any) {
        openViewController(controller: NotificationViewController.self, storyBoard: .homeStoryBoard) { (vc) in
        }
    }
    
    func openLeaderboard(challenge: ChallengeRespnse) {
        openViewController(controller: LeaderBoaardContestViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchKey = self.matchKey
            vc.challengeId = challenge.id ?? 0
            vc.homeType = self.homeType
            vc.entreeFee = challenge.entryfee ?? Int(0.0)
            vc.pdfURLStr = challenge.pdf ?? ""
            vc.amount = challenge.win_amount ?? ""
            vc.winning = (challenge.name ?? "0") ?? ""
            vc.winners = challenge.totalwinners ?? "0" //TODO
            vc.challngeRespnse = challenge
            vc.contestLiveData = self.contestData
            vc.ifFromJoinedContest = true
            vc.amountString = self.amountText
            vc.homeType = self.homeType
            vc.matchOFType = self.MatchType
            vc.pdfURLStr = challenge.pdf ?? ""
        }
    }
    
    override func handleBackButtonAction() -> Void {
       
        navigationController?.popViewController(animated: true)
    }
    
}

extension MyChallengeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyChallengeTableViewCell.identifier(), for: indexPath) as! MyChallengeTableViewCell
        cell.configureCell(challenge: challengesArray[indexPath.row], homeType: homeType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openLeaderboard(challenge: challengesArray[indexPath.row])
    }
    
    
}
