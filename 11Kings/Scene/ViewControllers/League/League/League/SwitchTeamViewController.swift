//
//  SwitchTeamViewController.swift
//  Club11
//
//  Created by Developer on 17/06/19.
//

import UIKit

class SwitchTeamViewController: BaseViewController {

    @IBOutlet weak var aCancelTeamButton: UIButton!
    @IBOutlet weak var aSwitchTeamTeamButton: UIButton!
    @IBOutlet weak var aVSLabel: UILabel!
    @IBOutlet weak var aTimerContainerView: UIView!
    @IBOutlet weak var aTimeLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var switchTeamsData = [SwitchTeamResponse]() {
        didSet {
            if aTableView != nil {
                aTableView.reloadDataInMainQueue()
            }
        }
    }
    var contestData: Any?
    var matchKey = ""
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var challengeId = 0
    var currentSelectedTeamID = -3
    var joinedID = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.register(UINib(nibName: SwitchTeamTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: SwitchTeamTableViewCell.identifier())
        setCornerRadius()
        addPullToRefresh() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Switch Teams", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: true)
        setContestData()
        getMyTeams()
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
        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey, "challenge_id": challengeId] as [String : Any]
        
        NetworkManager.post_Request(urlService: kMyTeamURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([SwitchTeamResponse].self, from: responseData)
                    self.switchTeamsData = responseModel
                    self.getPreviousTeamID()
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func getPreviousTeamID() {
        for team in switchTeamsData {
            if let selectedTeam = team.is_selected {
                if selectedTeam == 1 {
                    currentSelectedTeamID = team.teamid ?? -1
                }
            }
        }
    }
    
    @IBAction func switchTeamButtonAction(_ sender: UIButton) {
        switchTeam()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
 
    func previewAction(teams: SwitchTeamResponse) {
        openViewController(controller: PreviewViewController.self, storyBoard: .homeStoryBoard) { (vc) in
//            vc.teamInfo = teams
        }
    }
    
    func editAction(teams: SwitchTeamResponse, teamID: Int) {
        openViewController(controller: EditCloneTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.contestData
            let teamNum = teams.teamnumber
            vc.teamNumber = "\(teamNum ?? 999)"
            vc.teamId = teamID
        }
    }
    
    func cloneAction(teams: SwitchTeamResponse, teamID: Int) {
        openViewController(controller: EditCloneTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            vc.contestData = self.contestData
            vc.teamNumber = "\(self.switchTeamsData.count + 1)"  // for new and clone
            vc.teamId = teamID
        }
    }
    
    func switchTeam() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey, "challenge_id": challengeId,"teamid": currentSelectedTeamID, "joinid": joinedID] as [String : Any]
        
        NetworkManager.post_Request(urlService: kSwitchTeamURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([TeamUpdateResponse].self, from: responseData)
                    Loader.showToast(message: responseModel[0].status ?? "Team Updated", onView: self.view, bottomMargin: 200)
                    self.navigationController?.popViewController(animated: true)
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
        getMyTeams()
        aTableView.reloadData()
    }
}

extension SwitchTeamViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return switchTeamsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTeamTableViewCell.identifier(), for: indexPath) as! SwitchTeamTableViewCell
        cell.configureCell(data: switchTeamsData[indexPath.row])
        cell.cloneButtonClouser = { [weak self] id in
            if let strongSelf = self {
                if strongSelf.switchTeamsData.count == 6 {
                    Loader.showToast(message: "You create max 6 teams", onView: strongSelf.view, bottomMargin: 200)
                } else {
                    strongSelf.cloneAction(teams: strongSelf.switchTeamsData[indexPath.row], teamID: id)
                }
            }
        }
        cell.editButtonClouser = { [weak self] id in
            if let strongSelf = self {
                strongSelf.editAction(teams: strongSelf.switchTeamsData[indexPath.row], teamID: id)
            }
        }
        cell.previewButtonClouser = { [weak self] in
            if let strongSelf = self {
                strongSelf.previewAction(teams: strongSelf.switchTeamsData[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTeamId = switchTeamsData[indexPath.row].teamid
        let cell = aTableView.cellForRow(at: indexPath) as! SwitchTeamTableViewCell
        if checkAnyTeamSelected(teamData: switchTeamsData) {
            if selectedTeamId == currentSelectedTeamID {
                switchTeamsData[indexPath.row].is_selected = 0
                cell.setTeamSelection(teamSelected: false)
            } else {
                Loader.showToast(message: "Only one team can be selected", onView: self.view, bottomMargin: 200)
            }
        } else {
            switchTeamsData[indexPath.row].is_selected = 1
            currentSelectedTeamID = switchTeamsData[indexPath.row].teamid ?? -1
            cell.setTeamSelection(teamSelected: true)
        }
        aTableView.reloadDataInMainQueue()
    }
    
    func checkAnyTeamSelected(teamData: [SwitchTeamResponse]) -> Bool {
        var isSelected = false
        for team in teamData {
            if let selectedTeam = team.is_selected {
                if selectedTeam == 1 {
                    isSelected = true
                    currentSelectedTeamID = team.teamid ?? -1
                }
            }
        }
        return isSelected
    }
}

