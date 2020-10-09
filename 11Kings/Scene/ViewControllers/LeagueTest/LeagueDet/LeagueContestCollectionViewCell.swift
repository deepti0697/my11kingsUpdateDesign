//
//  LeagueContestCollectionViewCell.swift
//  DreamTeam
//
//  Created by Test on 18/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol OpenVC {
    func openTermsAndConditionVC()
    func openCreateTeamViewController()
    func openwinnerBreakup(challenge_id:Int,matchKey :String,amount:Double)
    func openMyTeamVC(entryFee:Double, challengeID:Int,isMultiEntry:Bool,maxTeaLimit:Int)
    
    func openCaptainVc(check:Bool)
    
    func openLederboard(challengeId: Int, league: MyLeague, entreFee: Int)
    
    func openContestDetailViewController(contest:[MyLeague],challenge:Int)
    func openJoinedContestORCreateTeam()
    func openAllContest()
}

class LeagueContestCollectionViewCell: UICollectionViewCell {
    //
    
    @IBOutlet weak var createTeamViewHeight: NSLayoutConstraint!
    @IBOutlet weak var createteamView: UIView!
    @IBOutlet weak var announceImage: UIImageView!
    @IBOutlet weak var hiddnImageView: UIImageView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var totalMatch: UILabel!
    @IBOutlet weak var announcementHeight: NSLayoutConstraint!
    var getContestDetailA:GetMatchDetails? {
        didSet {
            if  getContestDetailA?.announcement != "" {
                announcementLbl.text = getContestDetailA?.announcement
                announcementHeight.constant = 50
                announceImage.isHidden = false
                  announcementLbl.isHidden = false
            }
            else {
                announcementHeight.constant = 0
                 announceImage.isHidden = true
                announcementLbl.isHidden = true
            }
        }
    }
    @IBOutlet weak var announcementLbl: UILabel!
    @IBOutlet weak var createTeamBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contestContaintView: UIView!
    @IBOutlet weak var HiddenButton: UIButton!
    @IBOutlet weak var upperLbl: UILabel!
    var winnerBreakUpView: WinnerBreakupView?
    var challengeid = 0
    var contestprice = 0.0
    var confirmationView: ConfirmationView?
    var indexItem = -1
    
    var createTeamButton: (() -> Void) = { }
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aNoDataLabel: UILabel!
    var selectedContest: ((MyContestReponse, HomeType) -> Void) = { _, _ in }
    var joinButtonClouser: ((Int, Double) -> Void) = { _, _ in}
    var viceCapID = 0
    var CapId = 0
    var totalContest: String? {
        didSet {
            totalMatch.text = "All Contest (\(totalContest ?? "0"))"
        }
    }
    var temp = 0
    var delgate:OpenVC?
    var selectedTeamArray = [Int]()
    var storeLeague = [MyLeague]()
    var fromEditBtn = false
    var fromCloneBtn = false
    var storeDataforContestDetail:[MyLeague]?
    var challengeId:Int?
    var itematIndex = -1 {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    //    var totalLeagueData = [MyLeague]() {
    //        didSet {
    //              totalMatch.text = "All Contest (\(totalLeagueData.count))"
    //        }
    //    }
    var contestDatas = [MyCatagries]() {
        didSet {
            
            if teamResponse.count >= 15 {
                createTeamBtnHeightConstraint.constant = 0
                createTeamViewHeight.constant = 0
                createteamView.isHidden = true
            }
            else {
                createBtn.setTitle("Create Team \(teamResponse.count + 1 )", for: .normal)
                createTeamBtnHeightConstraint.constant = 40
                createTeamViewHeight.constant = 80
                createteamView.isHidden = false
            }
            //
            
            aTableView.reloadDataInMainQueue()
        }
    }
    var joinLeague = [myjoinedContest]() {
        didSet {
            
            aTableView.reloadDataInMainQueue()
        }
    }
    var contestData = [MyContestReponse]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var teamResponse = [MyTeamResponses]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var myTeamPreviewResponse:MyTeamResponses?
    var didSelectClousure: ((Int) -> Void) = { _ in }
    
    var createLeague: (() -> Void) = {  }
    var enterContestCode: (() -> Void) = { }
    override func awakeFromNib() {
        super.awakeFromNib()
        totalMatch.text = totalContest
        if contestDatas.count == 0 {
            createBtn.isHidden = true
            createTeamBtnHeightConstraint.constant = 0
            createBtn.isHidden = true
        }
         if teamResponse.count >= 15{
            createBtn.isHidden = true
            createTeamBtnHeightConstraint.constant = 0
            
        }
        else {
            createTeamBtnHeightConstraint.constant = 40
            createBtn.setTitle("Create Team \(teamResponse.count + 1 )", for: .normal)
            createBtn.isHidden = false
        }
        addPullToRefresh()
        registerCell()
    }
    var refreshControl = UIRefreshControl()
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    @objc func refreshData(sender:AnyObject) {
        aTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        aTableView.reloadDataInMainQueue()
    }
    
    fileprivate func registerCell() {
        aTableView.register(UINib(nibName: "ContestCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ContestCategoryTableViewCell")
        
        aTableView.register(UINib(nibName: viewMoreMatch.identifier(), bundle: nil), forCellReuseIdentifier: viewMoreMatch.identifier())
        aTableView.register(UINib(nibName: "viewMoreMatch", bundle: nil), forCellReuseIdentifier: "viewMoreMatch")
    }
    
    @IBAction func OpenEnterContestCodeScreeninswiftios(_ sender: Any) {
        enterContestCode()
    }
    @IBAction func createLeagueAction(_ sender: Any) {
        createLeague()
    }
    @IBAction func showAll(_ sender: Any) {
        self.delgate?.openAllContest()
    }
    
    func showNoDataLabel(show: Bool, text: String,image:UIImage,text2:String,buttonText:String?,showButton:Bool) {
        aNoDataLabel.isHidden = !show
        hiddnImageView.isHidden = !show
        upperLbl.isHidden = !show
        aNoDataLabel.text = text
        upperLbl.text = text2
        hiddnImageView.image =  image
        HiddenButton.isHidden = !showButton
        HiddenButton.setTitle(buttonText, for: .normal) 
        
        
    }
    
    @IBAction func createTeam(_ sender: Any) {
        createTeamButton()
    }
    
    @IBAction func openTeamVC(_ sender: Any) {
        self.delgate?.openJoinedContestORCreateTeam()
    }
    
}
extension LeagueContestCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return contestDatas.count
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if contestDatas[section].leagues.count > 3 {
            return 3
        }
        else {
            return contestDatas[section].leagues.count
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView ()
        guard let customView = Bundle.main.loadNibNamed("ContestCategoryTableHeaderView", owner: self, options: nil)?.first as? ContestCategoryTableHeaderView else  {
            return headerView
        }
        customView.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 70)
        headerView.addSubview(customView)
        customView.configureCell(category: contestDatas[section])
        return headerView
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContestCategoryTableViewCell") as! ContestCategoryTableViewCell
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "viewMoreMatch") as! viewMoreMatch
        
        if indexPath.row != 2 {
            challengeid = contestDatas[indexPath.section].leagues[indexPath.row].challenge_category_id ?? 0
            contestprice = Double(contestDatas[indexPath.section].leagues[indexPath.row].entryfee ?? Int(0.0))
            cell.delegate = self
            
            cell.configureCell(league: contestDatas[indexPath.section].leagues[indexPath.row] )
            if contestDatas[indexPath.section].leagues[indexPath.row].challenge_type == "gadget" {
                cell.aAmountLabel.text = contestDatas[indexPath.section].leagues[indexPath.row].first_rank_prizes
                cell.winnerLbl.text = "\(contestDatas[indexPath.section].leagues[indexPath.row].first_rank_prizes ?? "")"
                  }
                  else {
                cell.winnerLbl.text = "\(contestDatas[indexPath.section].leagues[indexPath.row].first_rank_prize ?? 0)"
                    cell.aAmountLabel.text = "\(kRupeeIcon)\(contestDatas[indexPath.section].leagues[indexPath.row].win_amount ?? 0)"
                  }
            cell1.captainClooseClouser = { [weak self]  in
                if let strongSelf = self {
                    strongSelf.storeDataforContestDetail = self?.contestDatas[indexPath.row].leagues
                }
                //
            }
            return cell
        }
            
        else {
            cell1.delegate = self
          
            
            cell1.openDetailLeague.setTitle("View More > ", for: .normal)
            indexItem = indexPath.row
            cell1.selectionStyle = .none
            aTableView.backgroundView?.backgroundColor = .clear
            cell1.captainClooseClouser = { [weak self]  in
                if let strongSelf = self {
                    self?.challengeid = self?.contestDatas[indexPath.section].leagues[indexPath.row].challenge_category_id ?? 0
                    strongSelf.storeDataforContestDetail = self?.contestDatas[indexPath.section].leagues
                    
                }
                //
            }
            return cell1
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        return 50
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == indexItem {
            return 30
        }
        else if contestDatas[indexPath.section].leagues[indexPath.row].announcement == "" {
            return 160
        }
        else {
            return  170
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itematIndex == 0 {
            let leagues = contestDatas[indexPath.section].leagues
            if let cID = leagues[indexPath.row].id, let fees = leagues[indexPath.row].entryfee {
                self.delgate?.openLederboard(challengeId: cID, league: leagues[indexPath.row], entreFee: fees)
            }
        }
        
    }
    
    fileprivate func viewCloseAction() {
        winnerBreakUpView?.removeFromSuperview()
        winnerBreakUpView = nil
        confirmationView?.removeFromSuperview()
        confirmationView = nil
    }
    
    
    
}


extension LeagueContestCollectionViewCell:openConfirmationView {
    
    
    func openConfirmationView(teams: [MyTeamResponses], entryFee: Double, challengeID: Int) {
        if confirmationView == nil {
            confirmationView = Bundle.main.loadNibNamed("ConfirmationView", owner: self, options: nil)?.first as? ConfirmationView
            confirmationView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            APP_DEL.window?.addSubview(confirmationView!)
            confirmationView?.myTeamsData = teams
            confirmationView?.entryFees = Double(entryFee)
            confirmationView?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.viewCloseAction()
                }
            }
        }
        confirmationView?.termsConditionButtonClouser = { [weak self] in
            if let strongSelf = self {
                strongSelf.viewCloseAction()
                self?.delgate?.openTermsAndConditionVC()
            }
        }
    }
    func openwinningView(challengeid: Int, winningAmount: Double, matchKey: String) {
        self.delgate?.openwinnerBreakup(challenge_id: challengeid, matchKey: matchKey, amount: winningAmount)
    }
    
    func openVC(challengeid: Int, contestAmount: Double,EntryType: Bool,maxLimit:Int) {
        if teamResponse.count == 0 {
            self.delgate?.openCreateTeamViewController()
        }
        else {
            //            openConfirmationView(teams: teamResponse, entryFee:contestAmount , challengeID: challengeid)
            self.delgate?.openMyTeamVC(entryFee: contestAmount, challengeID: challengeid, isMultiEntry: EntryType, maxTeaLimit: maxLimit)
        }
    }
    
    
    
    
    
    
    
    
    
}
extension LeagueContestCollectionViewCell : sendDatatoDetail {
    func check() {
        self.delgate?.openContestDetailViewController(contest: storeDataforContestDetail ?? [MyLeague](), challenge:  challengeid )
    }
    
    
}
