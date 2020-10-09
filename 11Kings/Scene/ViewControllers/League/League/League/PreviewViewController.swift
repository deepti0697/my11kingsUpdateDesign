//
//  PreviewViewController.swift
//  Club11
//
//  Created by Developer on 08/06/19.
//

import UIKit

class PreviewViewController: BaseViewController {
    
    @IBOutlet weak var aTotalPointsLabel: UILabel!
    @IBOutlet weak var aWKCaptainLabel: UILabel!
    @IBOutlet weak var aWKContainerView: UIView!
    @IBOutlet weak var aWKImageView: UIImageView!
    @IBOutlet weak var aWKNameLabel: UILabel!
    @IBOutlet weak var aWKPointLabel: UILabel!
    @IBOutlet weak var aBat1CaptainLabel: UILabel!
    @IBOutlet weak var aBat1ContainerView: UIView!
    @IBOutlet weak var aBat1ImageView: UIImageView!
    @IBOutlet weak var aBat1NameLabel: UILabel!
    @IBOutlet weak var aBat1PointLabel: UILabel!
    @IBOutlet weak var aBat2CaptainLabel: UILabel!
    @IBOutlet weak var aBat2ContainerView: UIView!
    @IBOutlet weak var aBat2ImageView: UIImageView!
    @IBOutlet weak var aBat2NameLabel: UILabel!
    @IBOutlet weak var aBat2PointLabel: UILabel!
    @IBOutlet weak var aBat3CaptainLabel: UILabel!
    @IBOutlet weak var aBat3ContainerView: UIView!
    @IBOutlet weak var aBat3ImageView: UIImageView!
    @IBOutlet weak var aBat3NameLabel: UILabel!
    @IBOutlet weak var aBat3PointLabel: UILabel!
    @IBOutlet weak var aBat4CaptainLabel: UILabel!
    @IBOutlet weak var aBat4ContainerView: UIView!
    @IBOutlet weak var aBat4ImageView: UIImageView!
    @IBOutlet weak var aBat4NameLabel: UILabel!
    @IBOutlet weak var aBat4PointLabel: UILabel!
    @IBOutlet weak var aBat5CaptainLabel: UILabel!
    @IBOutlet weak var aBat5ContainerView: UIView!
    @IBOutlet weak var aBat5ImageView: UIImageView!
    @IBOutlet weak var aBat5NameLabel: UILabel!
    @IBOutlet weak var aBat5PointLabel: UILabel!
    @IBOutlet weak var aAR1CaptainLabel: UILabel!
    @IBOutlet weak var aAR1ContainerView: UIView!
    @IBOutlet weak var aAR1ImageView: UIImageView!
    @IBOutlet weak var aAR1NameLabel: UILabel!
    @IBOutlet weak var aAR1PointLabel: UILabel!
    @IBOutlet weak var aAR2CaptainLabel: UILabel!
    @IBOutlet weak var aAR2ContainerView: UIView!
    @IBOutlet weak var aAR2ImageView: UIImageView!
    @IBOutlet weak var aAR2NameLabel: UILabel!
    @IBOutlet weak var aAR2PointLabel: UILabel!
    @IBOutlet weak var aAR3CaptainLabel: UILabel!
    @IBOutlet weak var aAR3ContainerView: UIView!
    @IBOutlet weak var aAR3ImageView: UIImageView!
    @IBOutlet weak var aAR3NameLabel: UILabel!
    @IBOutlet weak var aAR3PointLabel: UILabel!
    @IBOutlet weak var aBall1CaptainLabel: UILabel!
    @IBOutlet weak var aBall1ContainerView: UIView!
    @IBOutlet weak var aBall1ImageView: UIImageView!
    @IBOutlet weak var aBall1NameLabel: UILabel!
    @IBOutlet weak var aBall1PointLabel: UILabel!
    @IBOutlet weak var aBall2CaptainLabel: UILabel!
    @IBOutlet weak var aBall2ContainerView: UIView!
    @IBOutlet weak var aBall2ImageView: UIImageView!
    @IBOutlet weak var aBall2NameLabel: UILabel!
    @IBOutlet weak var aBall2PointLabel: UILabel!
    @IBOutlet weak var aBall3CaptainLabel: UILabel!
    @IBOutlet weak var aBall3ContainerView: UIView!
    @IBOutlet weak var aBall3ImageView: UIImageView!
    @IBOutlet weak var aBall3NameLabel: UILabel!
    @IBOutlet weak var aBall3PointLabel: UILabel!
    @IBOutlet weak var aBall4CaptainLabel: UILabel!
    @IBOutlet weak var aBall4ContainerView: UIView!
    @IBOutlet weak var aBall4ImageView: UIImageView!
    @IBOutlet weak var aBall4NameLabel: UILabel!
    @IBOutlet weak var aBall4PointLabel: UILabel!
    @IBOutlet weak var aBall5CaptainLabel: UILabel!
    @IBOutlet weak var aBall5ContainerView: UIView!
    @IBOutlet weak var aBall5ImageView: UIImageView!
    @IBOutlet weak var aBall5NameLabel: UILabel!
    @IBOutlet weak var aBall5PointLabel: UILabel!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    @IBOutlet weak var aRefreshButton: UIButton!
    @IBOutlet weak var aEditButton: UIButton!
    
    var wk_Player_ID = 0
    var bat1_Player_ID = 0
    var bat2_Player_ID = 0
    var bat3_Player_ID = 0
    var bat4_Player_ID = 0
    var bat5_Player_ID = 0
    var ar1_Player_ID = 0
    var ar2_Player_ID = 0
    var ar3_Player_ID = 0
    var ball1_Player_ID = 0
    var ball2_Player_ID = 0
    var ball3_Player_ID = 0
    var ball4_Player_ID = 0
    var ball5_Player_ID = 0
    
    var teamInfo: MyTeamResponse?
    var wkArray = [Player]()
    var batArray = [Player]()
    var bowlArray = [Player]()
    var allArray = [Player]()
    var contestData: Any?
    var teamId = 0
    var challengeID = 0
    var isFromLeaderBoard = false
    var matchKey = ""
    var selectedIndex = -1
    var myTeamsData = [MyTeamResponse]() {
        didSet {
            getTeamInfo()
        }
    }
    var leaderBoardTeamArray = [LeaderBoardTeamResponse]() {
        didSet {
            getTeamInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aRefreshButton.isHidden = true
        aEditButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        addNavigationBar(navigationTitle: "", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false)
        setupUI()
        setContestData()
        if isFromLeaderBoard {
            getLeaderBoardTeams()
        } else {
            getMyTeamsData()
        }
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        if isFromLeaderBoard {
            getLeaderBoardTeams()
        } else {
            getMyTeamsData()
        }
    }
    
    fileprivate func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        aWKContainerView.isHidden = true
        aAR1ContainerView.isHidden = true
        aAR2ContainerView.isHidden = true
        aAR3ContainerView.isHidden = true
        aBat1ContainerView.isHidden = true
        aBat2ContainerView.isHidden = true
        aBat3ContainerView.isHidden = true
        aBat4ContainerView.isHidden = true
        aBat5ContainerView.isHidden = true
        aBall1ContainerView.isHidden = true
        aBall2ContainerView.isHidden = true
        aBall3ContainerView.isHidden = true
        aBall4ContainerView.isHidden = true
        aBall5ContainerView.isHidden = true
        aWKCaptainLabel.isHidden = true
        aAR1CaptainLabel.isHidden = true
        aAR2CaptainLabel.isHidden = true
        aAR3CaptainLabel.isHidden = true
        aBat1CaptainLabel.isHidden = true
        aBat2CaptainLabel.isHidden = true
        aBat3CaptainLabel.isHidden = true
        aBat4CaptainLabel.isHidden = true
        aBat5CaptainLabel.isHidden = true
        aBall1CaptainLabel.isHidden = true
        aBall2CaptainLabel.isHidden = true
        aBall3CaptainLabel.isHidden = true
        aBall4CaptainLabel.isHidden = true
        aBall5CaptainLabel.isHidden = true
        aWKCaptainLabel.setCornerRadius(value: 10)
        aAR1CaptainLabel.setCornerRadius(value: 10)
        aAR2CaptainLabel.setCornerRadius(value: 10)
        aAR3CaptainLabel.setCornerRadius(value: 10)
        aBat1CaptainLabel.setCornerRadius(value: 10)
        aBat2CaptainLabel.setCornerRadius(value: 10)
        aBat3CaptainLabel.setCornerRadius(value: 10)
        aBat4CaptainLabel.setCornerRadius(value: 10)
        aBat5CaptainLabel.setCornerRadius(value: 10)
        aBall1CaptainLabel.setCornerRadius(value: 10)
        aBall2CaptainLabel.setCornerRadius(value: 10)
        aBall3CaptainLabel.setCornerRadius(value: 10)
        aBall4CaptainLabel.setCornerRadius(value: 10)
        aBall5CaptainLabel.setCornerRadius(value: 10)
    }
    
    fileprivate func setContestData() {
        if let contest = contestData as? LiveMatchResponse {
            matchKey = contest.matchkey ?? ""
        }
        if let contest = contestData as? MyContestReponse {
            matchKey = contest.matchkey ?? ""
        }
    }
    
    fileprivate func getMyTeamsData() {
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
    
    func getLeaderBoardTeams() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1, "challenge": challengeID,"teamid": teamId] as [String : Any]
        
        NetworkManager.post_Request(urlService: KShowTeamOnGround, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([LeaderBoardTeamResponse].self, from: responseData)
                    self.leaderBoardTeamArray = responseModel
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func getTeamInfo() {
        if isFromLeaderBoard {
            setupPreviewDataForLeaderBoardTeams()
            aEditButton.isHidden = true
            aTotalPointsLabel.isHidden = false
            aRefreshButton.isHidden = false
        } else {
            if myTeamsData.count != 0 {
                teamInfo = myTeamsData[selectedIndex]
                setupPreviewDataForTeams()
                aEditButton.isHidden = false
                aTotalPointsLabel.isHidden = true
                aRefreshButton.isHidden = true
            }
        }
    }
    
    fileprivate func setupPreviewDataForTeams() {
        let teamNumber = teamInfo?.teamnumber
        aTeamNameLabel.text = "Team \(teamNumber ?? 0)"
        if let playerData = teamInfo?.player {
            setupPreviewTeam(players: playerData)
        }
    }
    
    fileprivate func setupPreviewTeam(players: [Player]) {
        for player in players {
            if let playerType = player.role {
                switch playerType {
                case "keeper" :
                    wkArray.append(player)
                case "batsman" :
                    batArray.append(player)
                case "allrounder" :
                    allArray.append(player)
                case "bowler" :
                    bowlArray.append(player)
                default:
                    break
                }
            }
        }
        setWKData()
        setBatData()
        setAllData()
        setBowlData()
    }
    
    fileprivate func setupPreviewDataForLeaderBoardTeams() {
        aTotalPointsLabel.text = "\(leaderBoardTeamArray[0].points ?? 0.0) Pts"
        let teamNumber = leaderBoardTeamArray[0].teamnumber
        aTeamNameLabel.text = "Team \(teamNumber ?? 0)"
        if let wkData = leaderBoardTeamArray[0].keeper {
            wkArray = wkData
        }
        if let allData = leaderBoardTeamArray[0].allrounder {
            allArray = allData
        }
        if let wkData = leaderBoardTeamArray[0].bowler {
            bowlArray = wkData
        }
        if let wkData = leaderBoardTeamArray[0].batsman {
            batArray = wkData
        }
        setWKData()
        setBatData()
        setAllData()
        setBowlData()
    }
    
    fileprivate func setWKData() {
        for player in wkArray {
            if player.team == "team1" {
                aWKNameLabel.backgroundColor = .orange
            } else {
                aWKNameLabel.backgroundColor = .black
            }
            wk_Player_ID = player.id ?? 0
            aWKNameLabel.text = player.player_name
            aWKPointLabel.text = "\(player.points ?? 0.0) pts"
            aWKContainerView.isHidden = false
            if player.captain == 1 {
                aWKCaptainLabel.isHidden = false
                aWKCaptainLabel.text = "C"
                aWKCaptainLabel.backgroundColor = .orange
            }
            if player.vicecaptain == 1 {
                aWKCaptainLabel.isHidden = false
                aWKCaptainLabel.text = "VC"
                aWKCaptainLabel.backgroundColor = .black
            }
            if let imagePath = player.image {
                let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                let imageUrl = URL(string: urlString1 ?? "")
                aWKImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                }
            }
        }
    }
    
    fileprivate func setBatData() {
        for (index,player) in batArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aBat1NameLabel.backgroundColor = .orange
                } else {
                    aBat1NameLabel.backgroundColor = .black
                }
                bat1_Player_ID = player.id ?? 0
                aBat1NameLabel.text = player.player_name ?? ""
                aBat1PointLabel.text = "\(player.points ?? 0.0) pts"
                aBat1ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "C"
                    aBat1CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "VC"
                    aBat1CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat1ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                if player.team == "team1" {
                    aBat2NameLabel.backgroundColor = .orange
                } else {
                    aBat2NameLabel.backgroundColor = .black
                }
                bat2_Player_ID = player.id ?? 0
                aBat2NameLabel.text = player.player_name ?? ""
                aBat2PointLabel.text = "\(player.points ?? 0.0) pts"
                aBat2ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "C"
                    aBat2CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "VC"
                    aBat2CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat2ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                if player.team == "team1" {
                    aBat3NameLabel.backgroundColor = .orange
                } else {
                    aBat3NameLabel.backgroundColor = .black
                }
                bat3_Player_ID = player.id ?? 0
                aBat3NameLabel.text = player.player_name ?? ""
                aBat3PointLabel.text = "\(player.points ?? 0.0) pts"
                aBat3ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "C"
                    aBat3CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "VC"
                    aBat3CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                if player.team == "team1" {
                    aBat4NameLabel.backgroundColor = .orange
                } else {
                    aBat4NameLabel.backgroundColor = .black
                }
                bat4_Player_ID = player.id ?? 0
                aBat4NameLabel.text = player.player_name ?? ""
                aBat4PointLabel.text = "\(player.points ?? 0.0) pts"
                aBat4ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "C"
                    aBat4CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "VC"
                    aBat4CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat4ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                if player.team == "team1" {
                    aBat5NameLabel.backgroundColor = .orange
                } else {
                    aBat5NameLabel.backgroundColor = .black
                }
                bat5_Player_ID = player.id ?? 0
                aBat5NameLabel.text = player.player_name ?? ""
                aBat5PointLabel.text = "\(player.points ?? 0.0) pts"
                aBat5ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "C"
                    aBat5CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "VC"
                    aBat5CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat5ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            default:
                break
            }
        }
    }
    
    fileprivate func setAllData() {
        for (index,player) in allArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aAR1NameLabel.backgroundColor = .orange
                } else {
                    aAR1NameLabel.backgroundColor = .black
                }
                ar1_Player_ID = player.id ?? 0
                aAR1NameLabel.text = player.player_name ?? ""
                aAR1PointLabel.text = "\(player.points ?? 0.0) pts"
                aAR1ContainerView.isHidden = false
                if player.captain == 1 {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "C"
                    aAR1CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "VC"
                    aAR1CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR1ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                if player.team == "team1" {
                    aAR2NameLabel.backgroundColor = .orange
                } else {
                    aAR2NameLabel.backgroundColor = .black
                }
                ar2_Player_ID = player.id ?? 0
                aAR2NameLabel.text = player.player_name ?? ""
                aAR2PointLabel.text = "\(player.points ?? 0.0) pts"
                aAR2ContainerView.isHidden = false
                if player.captain == 1 {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "C"
                    aAR2CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "VC"
                    aAR2CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR2ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                if player.team == "team1" {
                    aAR3NameLabel.backgroundColor = .orange
                } else {
                    aAR3NameLabel.backgroundColor = .black
                }
                ar3_Player_ID = player.id ?? 0
                aAR3NameLabel.text = player.player_name ?? ""
                aAR3PointLabel.text = "\(player.points ?? 0.0) pts"
                aAR3ContainerView.isHidden = false
                if player.captain == 1 {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "C"
                    aAR3CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "VC"
                    aAR3CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR3ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            default:
                break
            }
        }
    }
    
    fileprivate func setBowlData() {
        for (index,player) in bowlArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aBall1NameLabel.backgroundColor = .orange
                } else {
                    aBall1NameLabel.backgroundColor = .black
                }
                ball1_Player_ID = player.id ?? 0
                aBall1NameLabel.text = player.player_name ?? ""
                aBall1PointLabel.text = "\(player.points ?? 0.0) pts"
                aBall1ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "C"
                    aBall1CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "VC"
                    aBall1CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall1ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                if player.team == "team1" {
                    aBall2NameLabel.backgroundColor = .orange
                } else {
                    aBall2NameLabel.backgroundColor = .black
                }
                ball2_Player_ID = player.id ?? 0
                aBall2NameLabel.text = player.player_name ?? ""
                aBall2PointLabel.text = "\(player.points ?? 0.0) pts"
                aBall2ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "C"
                    aBall2CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "VC"
                    aBall2CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall2ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                if player.team == "team1" {
                    aBall3NameLabel.backgroundColor = .orange
                } else {
                    aBall3NameLabel.backgroundColor = .black
                }
                ball3_Player_ID = player.id ?? 0
                aBall3NameLabel.text = player.player_name ?? ""
                aBall3PointLabel.text = "\(player.points ?? 0.0) pts"
                aBall3ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "C"
                    aBall3CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "VC"
                    aBall3CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall3ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                if player.team == "team1" {
                    aBall4NameLabel.backgroundColor = .orange
                } else {
                    aBall4NameLabel.backgroundColor = .black
                }
                ball4_Player_ID = player.id ?? 0
                aBall4NameLabel.text = player.player_name ?? ""
                aBall4PointLabel.text = "\(player.points ?? 0.0) pts"
                aBall4ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "C"
                    aBall4CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "VC"
                    aBall4CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall4ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                if player.team == "team1" {
                    aBall5NameLabel.backgroundColor = .orange
                } else {
                    aBall5NameLabel.backgroundColor = .black
                }
                ball5_Player_ID = player.id ?? 0
                aBall5NameLabel.text = player.player_name ?? ""
                aBall5PointLabel.text = "\(player.points ?? 0.0) pts"
                aBall5ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "C"
                    aBall5CaptainLabel.backgroundColor = .orange
                }
                if player.vicecaptain == 1 {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "VC"
                    aBall5CaptainLabel.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall5ImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            default:
                break
            }
        }
    }
    
    @IBAction func aEditButtonAction(_ sender: Any) {
        openViewController(controller: EditCloneTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
            if self.isFromLeaderBoard {
                vc.contestData = self.contestData
                let teamNum = self.leaderBoardTeamArray[0].teamnumber
                vc.teamNumber = "\(teamNum ?? 999)"
                vc.teamId = self.teamId
            } else {
                vc.contestData = self.contestData
                let teamNum = self.teamInfo?.teamnumber
                vc.teamNumber = "\(teamNum ?? 999)"
                vc.teamId = self.teamId
            }
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func unwindToMyTeamsFromPowerPlay(segue: UIStoryboardSegue) {
        if isFromLeaderBoard {
            getLeaderBoardTeams()
        } else {
            getMyTeamsData()
        }
    }
    
    @IBAction func aWKButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: wk_Player_ID)
    }
    
    @IBAction func aBat1ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: bat1_Player_ID)
    }
    
    @IBAction func aBat2ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: bat2_Player_ID)
    }
    
    @IBAction func aBat3ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: bat3_Player_ID)
    }
    
    @IBAction func aBat4ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: bat4_Player_ID)
    }
    
    @IBAction func aBat5ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: bat5_Player_ID)
    }
    
    @IBAction func aAL1ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: ar1_Player_ID)
    }
    
    @IBAction func aAL2ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: ar2_Player_ID)
    }
    
    @IBAction func aAL3ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: ar3_Player_ID)
    }
    
    @IBAction func aBall1ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: ball1_Player_ID)
    }
    
    @IBAction func aBall2ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: ball2_Player_ID)
    }
    
    @IBAction func aBall3ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: ball3_Player_ID)
    }
    
    @IBAction func aBall4ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: ball4_Player_ID)
    }
    
    @IBAction func aBall5ButtonAction(_ sender: Any) {
        openPlayerInfoVC(id: ball5_Player_ID)
        
    }
    
    func openPlayerInfoVC(id: Int) {
        openViewController(controller: PlayerStaticsViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.teamId = self.teamId
            vc.matchKey = self.matchKey
            vc.playerID = id
        }
    }
}
