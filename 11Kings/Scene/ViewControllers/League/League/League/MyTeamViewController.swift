//
//  MyTeamViewController.swift
//  Club11
//
//  Created by Developer on 28/05/19.
//

import UIKit

class MyTeamViewController: BaseViewController {
    
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aCreateTeamButton: UIButton!
    @IBOutlet weak var aVSLabel: UILabel!
    @IBOutlet weak var aTimerContainerView: UIView!
    @IBOutlet weak var aTimeLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aCreateTeamButtonHeightConstraint: NSLayoutConstraint!
    
    var refreshControl = UIRefreshControl()
    var myTeamsData = [MyTeamResponse]() {
        didSet {
            if aTableView != nil {
                aTableView.reloadDataInMainQueue()
                aContainerView.isHidden = myTeamsData.count == 0 ? false : true
            }
        }
    }
    var contestData: Any?
    var matchKey = ""
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.register(UINib(nibName: MyTeamTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MyTeamTableViewCell.identifier())
        setCornerRadius()
        addPullToRefresh() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "My Teams", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: true)
        setContestData()
        getMyTeams()
        showHideCreateButton()
        aContainerView.isHidden = myTeamsData.count == 0 ? false : true
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
        getMyTeams()
        showHideCreateButton()
        aContainerView.isHidden = myTeamsData.count == 0 ? false : true
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
                    self.aContainerView.isHidden = self.myTeamsData.count == 0 ? false : true
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    @IBAction func createTeamButtonAction(_ sender: UIButton) {
        openCreateTeamVC()
    }
    
    func showHideCreateButton() {
        if myTeamsData.count >= 6 {
            aCreateTeamButton.setTitle("", for: .normal)
            aCreateTeamButtonHeightConstraint.constant = 0
        } else {
            aCreateTeamButton.setTitle("CREATE NEW TEAM", for: .normal)
            aCreateTeamButtonHeightConstraint.constant = 50
        }
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func openCreateTeamVC() {
        openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.contestData
            vc.teamNumber = "\(self.myTeamsData.count + 1)"
        }
    }
    
    func previewAction(teamID: Int, index: Int) {
        openViewController(controller: PreviewViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.teamId = teamID
            vc.contestData = self.contestData
            vc.selectedIndex = index
        }
    }
    
    func editAction(teams: MyTeamResponse, teamID: Int) {
        openViewController(controller: EditCloneTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.contestData
            let teamNum = teams.teamnumber
            vc.teamNumber = "\(teamNum ?? 999)"
            vc.teamId = teamID
        }
    }
    
    func cloneAction(teams: MyTeamResponse, teamID: Int) {
        openViewController(controller: EditCloneTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.contestData
            vc.teamNumber = "\(self.myTeamsData.count + 1)"  // for new and clone
            vc.teamId = teamID
        }
    }
    
    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
        getMyTeams()
        showHideCreateButton()
        aContainerView.isHidden = myTeamsData.count == 0 ? false : true
    }
}

extension MyTeamViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTeamsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTeamTableViewCell.identifier(), for: indexPath) as! MyTeamTableViewCell
        cell.configureCell(data: myTeamsData[indexPath.row])
        cell.cloneButtonClouser = { [weak self] id in
            if let strongSelf = self {
                if strongSelf.myTeamsData.count == 6 {
                    Loader.showToast(message: "You create max 6 teams", onView: strongSelf.view, bottomMargin: 200)
                } else {
                    strongSelf.cloneAction(teams: strongSelf.myTeamsData[indexPath.row], teamID: id)
                }
            }
        }
        cell.editButtonClouser = { [weak self] id in
            if let strongSelf = self {
                strongSelf.editAction(teams: strongSelf.myTeamsData[indexPath.row], teamID: id)
            }
        }
        cell.previewButtonClouser = { [weak self] id in
            if let strongSelf = self {
                strongSelf.previewAction(teamID: id, index: indexPath.row)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125 //113 when powerplay invisible
    }
    
}

