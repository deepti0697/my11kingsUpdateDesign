//
//  KabaddiPreviewViewController.swift
//  DreamTeam
//
//  Created by Test on 05/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol KabaddiPreview {
    func checkFrom(check:Bool)
}
class KabaddiPreviewViewController: BaseClass {
    var getContestDetail:GetMatchDetails?
    var arrayOFSelectedPlayer = [Int]()
    var contestLiveDatas:MyContestLiveLeagues?
    @IBOutlet weak var aRStackView: UIStackView!
    @IBOutlet weak var centerStackView: UIStackView!
    @IBOutlet weak var pGStackView: UIStackView!
    @IBOutlet weak var wkStackView: UIStackView!
    @IBOutlet weak var batStackView: UIStackView!
    
    @IBOutlet weak var bat1PlayingView: UIView!
    @IBOutlet weak var bat2PlayingView: UIView!
    @IBOutlet weak var bat3PlayingView: UIView!
    @IBOutlet weak var bat4PlayingView: UIView!
    
    @IBOutlet weak var wk1PlayingView: UIView!
    @IBOutlet weak var wk2PlayingView: UIView!
    @IBOutlet weak var wk3PlayingView: UIView!
    @IBOutlet weak var wk4PlayingView: UIView!
    
    @IBOutlet weak var all1PlayingView: UIView!
    @IBOutlet weak var all2PlayingView: UIView!
    @IBOutlet weak var all3PlayingView: UIView!
    @IBOutlet weak var all4PlayingView: UIView!
    
    
    @IBOutlet weak var aPF1PlayingView: UIView!
    @IBOutlet weak var aPF2PlayingView: UIView!
    @IBOutlet weak var aPF3PlayingView: UIView!
    @IBOutlet weak var aPF4PlayingView: UIView!
    
    @IBOutlet weak var aCenter1PlayingView: UIView!
    @IBOutlet weak var aCenter2PlayingView: UIView!
    @IBOutlet weak var aCenter3PlayingView: UIView!
    @IBOutlet weak var aCenter4PlayingView: UIView!
    
    @IBOutlet weak var all1UIView: UIView!
    @IBOutlet weak var all2UIView: UIView!
    @IBOutlet weak var all3UIView: UIView!
    @IBOutlet weak var all4UIView: UIView!
    
    @IBOutlet weak var pF1UIIView: UIView!
    @IBOutlet weak var pF2UIView: UIView!
    @IBOutlet weak var pF3UIView: UIView!
    @IBOutlet weak var pF4UIVIew: UIView!
    
    @IBOutlet weak var aCenter4UIVIew: UIView!
    @IBOutlet weak var aCenter3UIView: UIView!
    @IBOutlet weak var aCenter1UIView: UIView!
    @IBOutlet weak var aCenter2UIView: UIView!
    
    @IBOutlet weak var wk1UIView: UIView!
    @IBOutlet weak var wk2UIView: UIView!
    @IBOutlet weak var wk3UIView: UIView!
    
    @IBOutlet weak var wk4UIVIew: UIView!
    @IBOutlet weak var bat4UIVIew: UIView!
    @IBOutlet weak var bat1UiView: UIView!
    @IBOutlet weak var bat2UiView: UIView!
    @IBOutlet weak var bat3UiView: UIView!
    
    @IBOutlet weak var editImageView: UIImageView!
    @IBOutlet weak var croosBtn: UIButton!
    @IBOutlet weak var editLbl: UILabel!
    @IBOutlet weak var editView: UIView!
    
    var teamName = ""
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
    
    @IBOutlet weak var aAR4CaptainLabel: UILabel!
    @IBOutlet weak var aAR4ContainerView: UIView!
    @IBOutlet weak var aAR4ImageView: UIImageView!
    @IBOutlet weak var aAR4NameLabel: UILabel!
    @IBOutlet weak var aAR4PointLabel: UILabel!
    
    @IBOutlet weak var aAR3PointLabel: UILabel!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    
    @IBOutlet weak var aEditButton: UIButton!
    @IBOutlet weak var aWk2ImageView: UIImageView!
    @IBOutlet weak var awk2CaptainLbl: UILabel!
    @IBOutlet weak var awk1ContainerView: UIView!
    
    @IBOutlet weak var aPowerForword1ContainerView: UIView!
    @IBOutlet weak var aPFCaptainLbl: UILabel!
    @IBOutlet weak var aPFPointLbl: UILabel!
    @IBOutlet weak var aPF1NameLabel: UILabel!
    @IBOutlet weak var aPF1ImageView: UIImageView!
    
    @IBOutlet weak var aPowerForword2ContainerView: UIView!
    @IBOutlet weak var aPF2CaptainLbl: UILabel!
    @IBOutlet weak var aPF2PointLbl: UILabel!
    @IBOutlet weak var aPF2NameLabel: UILabel!
    @IBOutlet weak var aPF2ImageView: UIImageView!
    
    @IBOutlet weak var aPowerForword3ContainerView: UIView!
    @IBOutlet weak var aPF3CaptainLbl: UILabel!
    @IBOutlet weak var aPF3PointLbl: UILabel!
    @IBOutlet weak var aPF3NameLabel: UILabel!
    @IBOutlet weak var aPF3ImageView: UIImageView!
    
    @IBOutlet weak var aPowerForword4ContainerView: UIView!
    @IBOutlet weak var aPF4CaptainLbl: UILabel!
    @IBOutlet weak var aPF4PointLbl: UILabel!
    @IBOutlet weak var aPF4NameLabel: UILabel!
    @IBOutlet weak var aPF4ImageView: UIImageView!
    
    
    @IBOutlet weak var awk3CaptianLbl: UILabel!
    @IBOutlet weak var awk3PointLbl: UILabel!
    @IBOutlet weak var awk3NameLbl: UILabel!
    @IBOutlet weak var awk3ImageView: UIImageView!
    @IBOutlet weak var awk3ContainerView: UIView!
    
    @IBOutlet weak var awk4CaptianLbl: UILabel!
    @IBOutlet weak var awk4PointLbl: UILabel!
    @IBOutlet weak var awk4NameLbl: UILabel!
    @IBOutlet weak var awk4ImageView: UIImageView!
    @IBOutlet weak var awk4ContainerView: UIView!
    
    @IBOutlet weak var awkCaptainLbl: UILabel!
    @IBOutlet weak var awk1PointLbl: UILabel!
    @IBOutlet weak var awk1NameLbl: UILabel!
    @IBOutlet weak var awk1ImageView: UIImageView!
    @IBOutlet weak var awk2ContainerView: UIView!
    @IBOutlet weak var awk2PointLabel: UILabel!
    @IBOutlet weak var awk2NameLBl: UILabel!
    
    @IBOutlet weak var aCenter1ContainerView: UIView!
    @IBOutlet weak var aCenterPointLbl: UILabel!
    @IBOutlet weak var aCenter1CaptainLabel: UILabel!
    @IBOutlet weak var aCenterNameLbl: UILabel!
    @IBOutlet weak var aCenter1ImageView: UIImageView!
    
    @IBOutlet weak var aCenter2ContainerView: UIView!
    @IBOutlet weak var aCenter2PointLbl: UILabel!
    @IBOutlet weak var aCenter2CaptainLabel: UILabel!
    @IBOutlet weak var aCenter2NameLbl: UILabel!
    @IBOutlet weak var aCenter2ImageView: UIImageView!
    
    @IBOutlet weak var aCenter3ContainerView: UIView!
    @IBOutlet weak var aCenter3PointLbl: UILabel!
    @IBOutlet weak var aCenter3CaptainLabel: UILabel!
    @IBOutlet weak var aCenter3NameLbl: UILabel!
    @IBOutlet weak var aCenter3ImageView: UIImageView!
    
    @IBOutlet weak var aCenter4ContainerView: UIView!
    @IBOutlet weak var aCenter4PointLbl: UILabel!
    @IBOutlet weak var aCenter4CaptainLabel: UILabel!
    @IBOutlet weak var aCenter4NameLbl: UILabel!
    @IBOutlet weak var aCenter4ImageView: UIImageView!
    
    var getTeamResponse:MyTeamResponses?
    var isComingFromMyteam = false
    var isFromEditClone = false
    var comingromFromPReview = false
    var delegate:KabaddiPreview?
    
    var wk1_Player_ID = 0
    var wk2_Player_ID = 0
    var wk3_Player_ID = 0
    var wk4_Player_ID = 0
    
    
    var bat1_Player_ID = 0
    var bat2_Player_ID = 0
    var bat3_Player_ID = 0
    var bat4_Player_ID = 0
    
    var ar1_Player_ID = 0
    var ar2_Player_ID = 0
    var ar3_Player_ID = 0
    var ar4_Player_ID = 0
    
    var pf1_Player_ID = 0
    var pf2_Player_ID = 0
    var pf3_Player_ID = 0
    var pf4_Player_ID = 0
    
    var center1_Player_ID = 0
    var center2_Player_ID = 0
    var center3_Player_ID = 0
    var center4_Player_ID = 0
    
    var wkArray = [PlayerDetail]()
    var batArray = [PlayerDetail]()
    var bowlArray = [PlayerDetail]()
    var allArray = [PlayerDetail]()
    var pgArray = [PlayerDetail]()
    var centerArray = [PlayerDetail]()
    var ball1_Player_ID = 0
    var ball2_Player_ID = 0
    var ball3_Player_ID = 0
    
    var teamInfo: MyTeamResponses?
    
    var wkArrayList = [PlayerListResponses]()
    var batArrayList = [PlayerListResponses]()
    var bowlArrayList = [PlayerListResponses]()
    var allArrayList = [PlayerListResponses]()
    var pgArrayList = [PlayerListResponses]()
    var centerArrayList = [PlayerListResponses]()
    var allRounder = [LeaderBoardPlayerDetail]()
    var defender = [LeaderBoardPlayerDetail]()
    var raider = [LeaderBoardPlayerDetail]()
    var pg = [LeaderBoardPlayerDetail]()
    var center = [LeaderBoardPlayerDetail]()
    var contestData: GetMatchDetails?
    var teamId = 0
    var teamID = 0
    var challengeID = 0
    var isFromLeaderBoard = false
    var isFromCreateTEam = false
    var matchKey = ""
    var selectedIndex = -1
    var captainID:String?
    var viceCaptianID:String?
    var c = 0
    var v = 0
    var vcID = 0
    var cId = 0
    var myTeamsData = [MyTeamResponses]() {
        didSet {
            getTeamInfo()
        }
    }
    
    var leaderBoardTeamArray :LeaderBoardKabaddiDetail? {
        didSet {
            getTeamInfo()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewControllerB = segue.destination as? TeamViewController {
            viewControllerB.fromPreview = comingromFromPReview
            //Do what you want in here!
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //   aRefreshButton.isHidden = true
        // aEditButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "KK", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
        setupUI()
        setContestData()
        if isFromLeaderBoard {
            getLeaderBoardTeams()
        }
        else if isComingFromMyteam {
            setupPReviewForMyTeam(data: (getTeamResponse!))
        }
        else  {
            setupPreviewTeamFromCreate()
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
        
        wk1PlayingView.isHidden = true
        wk2PlayingView.isHidden = true
        wk3PlayingView.isHidden =  true
        wk4PlayingView.isHidden = true
        bat1PlayingView.isHidden = true
        bat2PlayingView.isHidden = true
        bat3PlayingView.isHidden = true
        bat4PlayingView.isHidden = true
        all1PlayingView.isHidden = true
        all2PlayingView.isHidden = true
        all3PlayingView.isHidden = true
        all4PlayingView.isHidden = true
        aPF1PlayingView.isHidden = true
        aPF2PlayingView.isHidden  = true
        aPF3PlayingView.isHidden = true
        aPF4PlayingView.isHidden = true
        aCenter1PlayingView.isHidden = true
        aCenter2PlayingView.isHidden = true
        aCenter3PlayingView.isHidden = true
        aCenter4PlayingView.isHidden = true
        
        
        
        self.navigationController?.isNavigationBarHidden = true
        
        wk1PlayingView.layer.cornerRadius = wk1PlayingView.frame.size.width/2
        wk1PlayingView.clipsToBounds = true
        
        wk1PlayingView.layer.borderColor = UIColor.white.cgColor
        wk1PlayingView.layer.borderWidth = 5.0
        
        wk2PlayingView.layer.cornerRadius = wk2PlayingView.frame.size.width/2
        wk2PlayingView.clipsToBounds = true
        wk2PlayingView.layer.borderColor = UIColor.white.cgColor
        wk2PlayingView.layer.borderWidth = 5.0
        
        wk3PlayingView.layer.cornerRadius = wk3PlayingView.frame.size.width/2
        wk3PlayingView.clipsToBounds = true
        wk3PlayingView.layer.borderColor = UIColor.white.cgColor
        wk3PlayingView.layer.borderWidth = 5.0
        
        wk4PlayingView.layer.cornerRadius = wk4PlayingView.frame.size.width/2
        wk4PlayingView.clipsToBounds = true
        wk4PlayingView.layer.borderColor = UIColor.white.cgColor
        wk4PlayingView.layer.borderWidth = 5.0
        
        bat1PlayingView.layer.cornerRadius = bat1PlayingView.frame.size.width/2
        bat1PlayingView.clipsToBounds = true
        
        bat1PlayingView.layer.borderColor = UIColor.white.cgColor
        bat1PlayingView.layer.borderWidth = 5.0
        bat2PlayingView.layer.cornerRadius = bat2PlayingView.frame.size.width/2
        bat2PlayingView.clipsToBounds = true
        
        bat2PlayingView.layer.borderColor = UIColor.white.cgColor
        bat2PlayingView.layer.borderWidth = 5.0
        bat3PlayingView.layer.cornerRadius = bat3PlayingView.frame.size.width/2
        bat3PlayingView.clipsToBounds = true
        
        bat3PlayingView.layer.borderColor = UIColor.white.cgColor
        bat3PlayingView.layer.borderWidth = 5.0
        
        bat4PlayingView.layer.cornerRadius = bat4PlayingView.frame.size.width/2
        bat4PlayingView.clipsToBounds = true
        
        bat4PlayingView.layer.borderColor = UIColor.white.cgColor
        bat4PlayingView.layer.borderWidth = 5.0
        
        all1PlayingView.layer.cornerRadius = all1PlayingView.frame.size.width/2
        all1PlayingView.clipsToBounds = true
        all1PlayingView.layer.borderColor = UIColor.white.cgColor
        all1PlayingView.layer.borderWidth = 5.0
        
        all2PlayingView.layer.cornerRadius = all2PlayingView.frame.size.width/2
        all2PlayingView.clipsToBounds = true
        all2PlayingView.layer.borderColor = UIColor.white.cgColor
        all2PlayingView.layer.borderWidth = 5.0
        
        all3PlayingView.layer.cornerRadius = all3PlayingView.frame.size.width/2
        all3PlayingView.clipsToBounds = true
        all3PlayingView.layer.borderColor = UIColor.white.cgColor
        all3PlayingView.layer.borderWidth = 5.0
        
        all4PlayingView.layer.cornerRadius = all4PlayingView.frame.size.width/2
        all4PlayingView.clipsToBounds = true
        all4PlayingView.layer.borderColor = UIColor.white.cgColor
        all4PlayingView.layer.borderWidth = 5.0
        
        
        aPF1PlayingView.layer.cornerRadius = aPF1PlayingView.frame.size.width/2
        aPF1PlayingView.clipsToBounds = true
        aPF1PlayingView.layer.borderColor = UIColor.white.cgColor
        aPF1PlayingView.layer.borderWidth = 5.0
        
        aPF2PlayingView.layer.cornerRadius = aPF2PlayingView.frame.size.width/2
        aPF2PlayingView.clipsToBounds = true
        aPF2PlayingView.layer.borderColor = UIColor.white.cgColor
        aPF2PlayingView.layer.borderWidth = 5.0
        
        aPF3PlayingView.layer.cornerRadius = aPF3PlayingView.frame.size.width/2
        aPF3PlayingView.clipsToBounds = true
        aPF3PlayingView.layer.borderColor = UIColor.white.cgColor
        aPF3PlayingView.layer.borderWidth = 5.0
        
        aPF4PlayingView.layer.cornerRadius = aPF3PlayingView.frame.size.width/2
        aPF4PlayingView.clipsToBounds = true
        aPF4PlayingView.layer.borderColor = UIColor.white.cgColor
        aPF4PlayingView.layer.borderWidth = 5.0
        
        
        aCenter1PlayingView.layer.cornerRadius = aCenter1PlayingView.frame.size.width/2
        aCenter1PlayingView.clipsToBounds = true
        aCenter1PlayingView.layer.borderColor = UIColor.white.cgColor
        aCenter1PlayingView.layer.borderWidth = 5.0
        
        awk1ContainerView.isHidden = true
        awk3ContainerView.isHidden = true
        awk2ContainerView.isHidden = true
        awk4ContainerView.isHidden = true
        
        aAR1ContainerView.isHidden = true
        aAR2ContainerView.isHidden = true
        aAR3ContainerView.isHidden = true
        aAR4ContainerView.isHidden = true
        
        aBat1ContainerView.isHidden = true
        aBat2ContainerView.isHidden = true
        aBat3ContainerView.isHidden = true
        aBat4ContainerView.isHidden = true
        aCenter1ContainerView.isHidden = true
        aCenter2ContainerView.isHidden = true
        aCenter3ContainerView.isHidden = true
        aCenter4ContainerView.isHidden = true
        
        aPowerForword1ContainerView.isHidden = true
        aPowerForword2ContainerView.isHidden = true
        aPowerForword3ContainerView.isHidden = true
        aPowerForword4ContainerView.isHidden = true
        
        
        aPFCaptainLbl.isHidden = true
        aPF2CaptainLbl.isHidden = true
        aPF3CaptainLbl.isHidden = true
        aPF4CaptainLbl.isHidden = true
        
        aCenter4CaptainLabel.isHidden = true
        aCenter3CaptainLabel.isHidden = true
        aCenter2CaptainLabel.isHidden = true
        aCenter1CaptainLabel.isHidden = true
        
        
        awk3CaptianLbl.isHidden = true
        awk2CaptainLbl.isHidden = true
        awkCaptainLbl.isHidden = true
        awk4CaptianLbl.isHidden = true
        
        aAR1CaptainLabel.isHidden = true
        aAR2CaptainLabel.isHidden = true
        aAR3CaptainLabel.isHidden = true
        aAR4CaptainLabel.isHidden = true
        
        aBat4CaptainLabel.isHidden = true
        aBat1CaptainLabel.isHidden = true
        aBat2CaptainLabel.isHidden = true
        aBat3CaptainLabel.isHidden = true
        
        
        awk4CaptianLbl.setCornerRadius(value: 10)
        awk3CaptianLbl.setCornerRadius(value: 10)
        awk2CaptainLbl.setCornerRadius(value: 10)
        awkCaptainLbl.setCornerRadius(value: 10)
        
        aAR1CaptainLabel.setCornerRadius(value: 10)
        aAR2CaptainLabel.setCornerRadius(value: 10)
        aAR3CaptainLabel.setCornerRadius(value: 10)
        aAR4CaptainLabel.setCornerRadius(value: 10)
        
        aBat1CaptainLabel.setCornerRadius(value: 10)
        aBat2CaptainLabel.setCornerRadius(value: 10)
        aBat3CaptainLabel.setCornerRadius(value: 10)
        aBat4CaptainLabel.setCornerRadius(value: 10)
        aPFCaptainLbl.setCornerRadius(value: 10)
        aPF2CaptainLbl.setCornerRadius(value: 10)
        aPF3CaptainLbl.setCornerRadius(value: 10)
        aPF4CaptainLbl.setCornerRadius(value: 10)
        
        aCenter4CaptainLabel.setCornerRadius(value: 10)
        aCenter3CaptainLabel.setCornerRadius(value: 10)
        aCenter2CaptainLabel.setCornerRadius(value: 10)
        aCenter1CaptainLabel.setCornerRadius(value: 10)
    }
    
    fileprivate func setContestData() {
        aTeamNameLabel.text = teamName
        if let contest = getContestDetail  {
            matchKey = contest.matchkey ?? ""
        }
        if let contest = contestData  {
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
                    let teamRespons =  try JSON(data:response as! Data)
                    
                    let results = teamRespons["result"]
                    let cat = results["teams"]
                    
                    self.myTeamsData.removeAll()
                    for arr in cat.arrayValue{
                        self.myTeamsData.append(MyTeamResponses(json:arr))
                        
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
            
        }
    }
    
    fileprivate func setupPReviewForMyTeam(data:MyTeamResponses) {
        
        croosBtn.isHidden = true
        editLbl.isHidden = false
        aEditButton.isHidden   = false
        editView.isHidden = false
        editImageView.isHidden = false
        if let players = data.players {
            
            for player in players {
                arrayOFSelectedPlayer.append(player.id ?? 0)
                if player.captain == 1 {
                    self.vcID = player.id ?? 0
                }
                if player.vicecaptain == 1 {
                    self.cId = player.id ?? 0
                }
                
                if player.role == "Small forward" {
                    
                    batArray.append(player)
                }
                if player.role == "Shooting guard" {
                    allArray.append(player)
                }
                
                if player.role == "Point guard" {
                    wkArray.append(player)
                }
                if player.role == "Center" {
                    centerArray.append(player)
                }
                if player.role == "Power forward" {
                    pgArray.append(player)
                }
            }
            
        }
        setWKData()
        setAllData()
        setBatData()
        setPGData()
        setCentreData()
        
    }
    fileprivate func setupPreviewTeamFromCreate() {
        croosBtn.isHidden = false
        editLbl.isHidden = true
        aEditButton.isHidden = true
        editView.isHidden = true
        editImageView.isHidden = true
        for player in APP_DEL.kabbaddiChoosedTeamArray {
            
            if player.role == "Small forward" {
                batArrayList.append(player)
            }
            if player.role == "Shooting guard" {
                allArrayList.append(player)
            }
            if player.role == "Point guard" {
                wkArrayList.append(player)
            }
            if player.role == "Center" {
                centerArrayList.append(player)
            }
            if player.role == "Power forward" {
                pgArrayList.append(player)
            }
        }
        
        
        setWKDataList()
        setBatDataList()
        setAllDataList()
        setPGDataList()
        setCenterDataList()
        
    }
    fileprivate func setCenterDataList() {
        for (index,player) in centerArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aCenter1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenterNameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter1UIView.backgroundColor = .black
                    aCenterNameLbl.backgroundColor = .black
                }
                center1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenterNameLbl.text = sortName
                }
                
                aCenterPointLbl.text = "\(player.credit ?? "") cr."
                aCenter1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aCenter1CaptainLabel.isHidden = false
                    aCenter1CaptainLabel.text = "SK"
                    aCenter1CaptainLabel.backgroundColor = UIColor(red: 190, green: 40, blue: 45)
                    aCenter1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if temp == self.viceCaptianID {
                    aCenter1CaptainLabel.isHidden = false
                    aCenter1CaptainLabel.text = "K"
                    aCenter1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aCenter1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 1:
                centerStackView.spacing = 100
                if player.team == "team1" {
                    aCenter2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenter2NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter2UIView.backgroundColor = .black
                    aCenter2NameLbl.backgroundColor = .black
                }
                center2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenter2NameLbl.text = sortName
                }
                
                aCenter2PointLbl.text = "\(player.credit ?? "") cr."
                aCenter2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aCenter2CaptainLabel.isHidden = false
                    aCenter2CaptainLabel.text = "SK"
//
                    
                    aCenter2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aCenter2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aCenter2CaptainLabel.isHidden = false
                    aCenter2CaptainLabel.text = "K"
                    
                    aCenter2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aCenter2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 2:
                centerStackView.spacing = 70
                if player.team == "team1" {
                    aCenter3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenter3NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenter3NameLbl.backgroundColor = .black
                }
                center3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenter3NameLbl.text = sortName
                }
                
                aCenter3PointLbl.text = "\(player.credit ?? "") cr."
                aCenter3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    
                    aCenter3CaptainLabel.isHidden = false
                    aCenter3CaptainLabel.text = "SK"
                    aCenter3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aCenter3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                   
                }
                if temp == self.viceCaptianID {
                    aCenter3CaptainLabel.isHidden = false
                    aCenter3CaptainLabel.text = "K"
                   aCenter3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aCenter3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 3:
                centerStackView.spacing = 30
                if player.team == "team1" {
                    aCenter4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenter4NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter4NameLbl.backgroundColor = .black
                    aPF4NameLabel.backgroundColor = .black
                }
                center4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenter4NameLbl.text = sortName
                }
                
                aCenter4PointLbl.text = "\(player.credit ?? "") cr."
                aCenter4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    
                    aCenter4CaptainLabel.isHidden = false
                    aCenter4CaptainLabel.text = "SK"
                    aCenter4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aCenter4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                 
                }
                if temp == self.viceCaptianID {
                    aCenter4CaptainLabel.isHidden = false
                    aCenter4CaptainLabel.text = "K"
                     aCenter4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                       aCenter4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            default:break
                
            }
        }
    }
    fileprivate func setPGDataList()  {
        for (index,player) in pgArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    pF1UIIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF1UIIView.backgroundColor = .black
                    aPF1NameLabel.backgroundColor = .black
                }
                pf1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aPF1NameLabel.text = sortName
                }
                
                aPFPointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aPFCaptainLbl.isHidden = false
                    aPFCaptainLbl.text = "SK"
                     aPFCaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aPFCaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aPFCaptainLbl.isHidden = false
                    aPFCaptainLbl.text = "K"
                    aPFCaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aPFCaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
            //                            }
            case 1:
                pGStackView.spacing = 100
                if player.team == "team1" {
                    pF2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF2UIView.backgroundColor = .black
                    aPF2NameLabel.backgroundColor = .black
                }
                pf2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aPF2NameLabel.text = sortName
                }
                //                            awk2NameLBl.text = player.name ?? ""
                aPF2PointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aPF2CaptainLbl.isHidden = false
                    aPF2CaptainLbl.text = "SK"
                    aPF2CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aPF2CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aPF2CaptainLbl.isHidden = false
                    aPF2CaptainLbl.text = "K"
                     aPF2CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aPF2CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 2:
                pGStackView.spacing = 70
                if player.team == "team1" {
                    pF3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF3UIView.backgroundColor = .black
                    aPF3NameLabel.backgroundColor = .black
                }
                pf4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk3NameLbl.text = sortName
                }
                
                aPF3PointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                  
                    aPF3CaptainLbl.isHidden = false
                    aPF3CaptainLbl.text = "SK"
                    aPF3CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aPF3CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aPF3CaptainLbl.isHidden = false
                    aPF3CaptainLbl.text = "K"
                      aPF3CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                        aPF3CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 3:
                pGStackView.spacing = 30
                if player.team == "team1" {
                    pF4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF4UIVIew.backgroundColor = .black
                    aPF4NameLabel.backgroundColor = .black
                }
                pf4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aPF4NameLabel.text = sortName
                }
                
                aPF4PointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                  
                    aPF4CaptainLbl.isHidden = false
                    aPF4CaptainLbl.text = "SK"
                    aPF4CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                      aPF4CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                   
                }
                
                if temp == self.viceCaptianID {
                    aPF4CaptainLbl.isHidden = false
                    aPF4CaptainLbl.text = "K"
                      aPF4CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                            aPF4CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            default:break
                
            }
        }
    }
    fileprivate func setPGData(){
        for (index,player) in pgArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    pF1UIIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF1UIIView.backgroundColor = .black
                    aPF1NameLabel.backgroundColor = .black
                }
                pf1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aPF1NameLabel.text = sortName
                }
                
                aPFPointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aPFCaptainLbl.isHidden = false
                    aPFCaptainLbl.text = "SK"
                     aPFCaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aPFCaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                    
                }
                
                if temp == self.viceCaptianID {
                    aPFCaptainLbl.isHidden = false
                    aPFCaptainLbl.text = "K"
                    aPFCaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aPFCaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
            //                            }
            case 1:
                pGStackView.spacing = 100
                if player.team == "team1" {
                    pF2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF2UIView.backgroundColor = .black
                    aPF2NameLabel.backgroundColor = .black
                }
                pf2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aPF2NameLabel.text = sortName
                }
                //                            awk2NameLBl.text = player.name ?? ""
                aPF2PointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aPF2CaptainLbl.isHidden = false
                    aPF2CaptainLbl.text = "SK"
                   aPF2CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                            aPF2CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aPF2CaptainLbl.isHidden = false
                    aPF2CaptainLbl.text = "K"
                   aPF2CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aPF2CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 2:
                pGStackView.spacing = 70
                if player.team == "team1" {
                    pF3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF3UIView.backgroundColor = .black
                    aPF3NameLabel.backgroundColor = .black
                }
                pf4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk3NameLbl.text = sortName
                }
                
                aPF3PointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aPF3CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aPF3CaptainLbl.isHidden = false
                    aPF3CaptainLbl.text = "SK"
                     aPF3CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                      aPF3CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aPF3CaptainLbl.isHidden = false
                    aPF3CaptainLbl.text = "K"
                      aPF3CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                      aPF3CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 3:
                pGStackView.spacing = 30
                if player.team == "team1" {
                    pF4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF4UIVIew.backgroundColor = .black
                    aPF4NameLabel.backgroundColor = .black
                }
                pf4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aPF4NameLabel.text = sortName
                }
                
                aPF4PointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                   
                    aPF4CaptainLbl.isHidden = false
                    aPF4CaptainLbl.text = "SK"
                   aPF4CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aPF4CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aPF4CaptainLbl.isHidden = false
                    aPF4CaptainLbl.text = "K"
                   aPF4CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aPF4CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            default:break
                
            }
        }
    }
    fileprivate func setCentreData() {
        for (index,player) in centerArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aCenter1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenterNameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter1UIView.backgroundColor = .black
                    aCenterNameLbl.backgroundColor = .black
                }
                center1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenterNameLbl.text = sortName
                }
                //                            awk1NameLbl.text = player.name ?? ""
                aCenterPointLbl.text = "\(player.credit ?? "") cr."
                aCenter1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aCenter1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aCenter1CaptainLabel.isHidden = false
                    aCenter1CaptainLabel.text = "SK"
                    aCenter1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aCenter1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aCenter1CaptainLabel.isHidden = false
                    aCenter1CaptainLabel.text = "K"
                      aCenter1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                        aCenter1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            //                            }
            case 1:
                centerStackView.spacing = 100
                if player.team == "team1" {
                    aCenter2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenter2NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter2UIView.backgroundColor = .black
                    aCenter2NameLbl.backgroundColor = .black
                }
                center2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenter2NameLbl.text = sortName
                }
                //                            awk2NameLBl.text = player.name ?? ""
                aCenter2PointLbl.text = "\(player.credit ?? "") cr."
                aCenter2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    
                    aCenter2CaptainLabel.isHidden = false
                    aCenter2CaptainLabel.text = "SK"
                    aCenter2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aCenter2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aCenter2CaptainLabel.isHidden = false
                    aCenter2CaptainLabel.text = "K"
                     aCenter2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                     aCenter2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 2:
                centerStackView.spacing = 70
                if player.team == "team1" {
                    aCenter3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenterNameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenterNameLbl.backgroundColor = .black
                }
                center3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenter3NameLbl.text = sortName
                }
                
                aCenter3PointLbl.text = "\(player.credit ?? "") cr."
                aCenter3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    
                    aCenter3CaptainLabel.isHidden = false
                    aCenter3CaptainLabel.text = "SK"
                     aCenter3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                     aCenter3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aCenter3CaptainLabel.isHidden = false
                    aCenter3CaptainLabel.text = "K"
                       aCenter3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                          aCenter3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 3:
                centerStackView.spacing = 30
                if player.team == "team1" {
                    aCenter4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenter4NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter4NameLbl.backgroundColor = .black
                    aCenter4UIVIew.backgroundColor = .black
                }
                center4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenter4NameLbl.text = sortName
                }
                
                aCenter4PointLbl.text = "\(player.credit ?? "") cr."
                aCenter4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    
                    aCenter4CaptainLabel.isHidden = false
                    aCenter4CaptainLabel.text = "SK"
                    aCenter4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aCenter4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aCenter4CaptainLabel.isHidden = false
                    aCenter4CaptainLabel.text = "K"
                   aCenter4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aCenter4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                    
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            default:break
                
            }
        }
    }
    fileprivate func setWKData() {
        for (index,player) in wkArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    wk1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk1NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk1UIView.backgroundColor = .black
                    awk1NameLbl.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wk1PlayingView.isHidden = false
                        
                        wk1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wk1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wk1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    wk1PlayingView.isHidden = false
                }
                wk1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk1NameLbl.text = sortName
                }
                
                awk1PointLbl.text = "\(player.credit ?? "") cr."
                awk1ContainerView.isHidden = false
                
                if player.captain == 1 {
                    
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "SK"
                   awkCaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awkCaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1  {
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "K"
                     awkCaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                        awkCaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
            //                            }
            case 1:
                wkStackView.spacing = 100
                if player.team == "team1" {
                    wk2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk2NameLBl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk2UIView.backgroundColor = .black
                    awk2NameLBl.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wk2PlayingView.isHidden = false
                        
                        wk2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wk2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wk2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    wk2PlayingView.isHidden = false
                }
                wk2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk2NameLBl.text = sortName
                }
                
                awk2PointLabel.text = "\(player.credit ?? "") cr."
                awk2ContainerView.isHidden = false
                if player.captain == 1 {
                    awk2CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awk2CaptainLbl.isHidden = false
                    awk2CaptainLbl.text = "SK"
                   awk2CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                   awk2CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    awk2CaptainLbl.isHidden = false
                    awk2CaptainLbl.text = "K"
                     awk2CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                     awk2CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aWk2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 2:
                wkStackView.spacing = 70
                if player.team == "team1" {
                    wk3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk3NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk3UIView.backgroundColor = .black
                    awk3NameLbl.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wk3PlayingView.isHidden = false
                        
                        wk3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wk3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wk3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    wk3PlayingView.isHidden = false
                }
                wk3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk3NameLbl.text = sortName
                }
                
                awk3PointLbl.text = "\(player.credit ?? "") cr."
                awk3ContainerView.isHidden = false
                
                if player.captain == 1{
                    
                    awk3CaptianLbl.isHidden = false
                    awk3CaptianLbl.text = "SK"
                    awk3CaptianLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awk3CaptianLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    awk3CaptianLbl.isHidden = false
                    awk3CaptianLbl.text = "K"
                    awk3CaptianLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awk3CaptianLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 3:
                wkStackView.spacing = 30
                if player.team == "team1" {
                    wk4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk4NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk4UIVIew.backgroundColor = .black
                    awk4NameLbl.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wk4PlayingView.isHidden = false
                        
                        wk4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wk4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wk4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    wk4PlayingView.isHidden = false
                }
                wk4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk4NameLbl.text = sortName
                }
                
                awk3PointLbl.text = "\(player.credit ?? "") cr."
                awk4ContainerView.isHidden = false
                
                if player.captain == 1 {
                    
                    awk4CaptianLbl.isHidden = false
                    awk4CaptianLbl.text = "SK"
                    awk4CaptianLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awk4CaptianLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    awk4CaptianLbl.isHidden = false
                    awk4CaptianLbl.text = "K"
                     awk4CaptianLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awk4CaptianLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            default:break
                
            }
        }
    }
    
    fileprivate func setBatData() {
        for (index,player) in batArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    bat1UiView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat1UiView.backgroundColor = .black
                    aBat1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat1PlayingView.isHidden = false
                        
                        bat1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        bat1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    bat1PlayingView.isHidden = false
                }
                bat1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat1NameLabel.text = sortName
                }
                //                aBat1NameLabel.text = player.name ?? ""
                aBat1PointLabel.text = "\(player.credit ?? "") cr."
                aBat1ContainerView.isHidden = false
                if player.captain == 1 {
                   
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "SK"
                    aBat1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                    
                }
                if player.vicecaptain == 1 {
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "K"
                     aBat1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                batStackView.spacing = 100
                if player.team == "team1" {
                    bat2UiView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat2UiView.backgroundColor = .black
                    aBat2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat2PlayingView.isHidden = false
                        
                        bat2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        bat2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    bat2PlayingView.isHidden = false
                }
                bat2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat2NameLabel.text = sortName
                }
                //                aBat2NameLabel.text = player.name ?? ""
                aBat2PointLabel.text = "\(player.credit ?? "") cr."
                aBat2ContainerView.isHidden = false
                if player.captain == 1 {
                    
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "SK"
                   aBat2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "K"
                     aBat2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                batStackView.spacing = 70
                if player.team == "team1" {
                    bat3UiView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat3UiView.backgroundColor = .black
                    aBat3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat3PlayingView.isHidden = false
                        
                        bat3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        bat3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    bat3PlayingView.isHidden = false
                }
                bat3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat3NameLabel.text = sortName
                }
                //                aBat3NameLabel.text = player.name ?? ""
                aBat3PointLabel.text = "\(player.credit ?? "") cr."
                aBat3ContainerView.isHidden = false
                if player.captain == 1 {
                    
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "SK"
                    aBat3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "K"
                       aBat3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                batStackView.spacing = 30
                if player.team == "team1" {
                    bat4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat4UIVIew.backgroundColor = .black
                    aBat4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat4PlayingView.isHidden = false
                        
                        bat4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        bat4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    bat4PlayingView.isHidden = false
                }
                bat4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat4NameLabel.text = sortName
                }
                //                aBat3NameLabel.text = player.name ?? ""
                aBat4PointLabel.text = "\(player.credit ?? "") cr."
                aBat4ContainerView.isHidden = false
                if player.captain == 1 {
                   
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "SK"
                    aBat4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "K"
                       aBat4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                         aBat4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
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
                    all1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all1UIView.backgroundColor = .black
                    aAR1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all1PlayingView.isHidden = false
                        
                        all1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        all1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    all1PlayingView.isHidden = false
                }
                ar1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR1NameLabel.text = sortName
                }
                
                //                aAR1NameLabel.text = player.name ?? ""
                aAR1PointLabel.text = "\(player.credit ?? "") cr."
                aAR1ContainerView.isHidden = false
                if player.captain == 1 {
                 
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "SK"
                   aAR1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                   aAR1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "K"
                     aAR1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                aRStackView.spacing = 100
                if player.team == "team1" {
                    all2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all2UIView.backgroundColor = .black
                    aAR2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all2PlayingView.isHidden = false
                        
                        all2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        all2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    all2PlayingView.isHidden = false
                }
                ar2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR2NameLabel.text = sortName
                }
                //                aAR2NameLabel.text = player.name ?? ""
                aAR2PointLabel.text = "\(player.credit ?? "") cr."
                aAR2ContainerView.isHidden = false
                if player.captain == 1 {  aAR2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "SK"
                    
               aAR2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
               aAR2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "K"
                     aAR2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                aRStackView.spacing = 70
                if player.team == "team1" {
                    all3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all3UIView.backgroundColor = .black
                    aAR3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all3PlayingView.isHidden = false
                        
                        all3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        all3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    all3PlayingView.isHidden = false
                }
                ar3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR3NameLabel.text = sortName
                }
                //                aAR3NameLabel.text = player.name ?? ""
                aAR3PointLabel.text = "\(player.credit ?? "") cr."
                aAR3ContainerView.isHidden = false
                if player.captain == 1 {
                    aAR3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "SK"
                    aAR3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "K"
                     aAR3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                aRStackView.spacing = 30
                if player.team == "team1" {
                    all4UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all4UIView.backgroundColor = .black
                    aAR4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all4PlayingView.isHidden = false
                        
                        all4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        all4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    all4PlayingView.isHidden = false
                }
                ar4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR4NameLabel.text = sortName
                }
                //                aAR3NameLabel.text = player.name ?? ""
                aAR4PointLabel.text = "\(player.credit ?? "") cr."
                aAR4ContainerView.isHidden = false
                if player.captain == 1 {
                    
                    aAR4CaptainLabel.isHidden = false
                    aAR4CaptainLabel.text = "SK"
                    aAR4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aAR4CaptainLabel.isHidden = false
                    aAR4CaptainLabel.text = "K"
                     aAR4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
                
            default:
                break
            }
        }
    }
    
    @IBAction func editBtnAction(_ sender: Any) {
        openEditVc(arryOfPlayer :arrayOFSelectedPlayer,viceCaptainID : vcID,captainID :cId,teamIDs:teamId)
    }
    func openEditVc(arryOfPlayer :[Int],viceCaptainID : Int,captainID :Int,teamIDs:Int){
        openViewController(controller: KABADDITeamViewController.self, storyBoard: .teamStoryBoard, handler: { (vc) in
            vc.arrayOFPlayer  = arryOfPlayer
            vc.contestData = self.contestData
            vc.viceCaptian = viceCaptainID
            vc.Captain = captainID
            vc.teamId = teamIDs
            vc.fromEditVC = true
            vc.matchKey = self.matchKey
            vc.fromPreview = false
            vc.contestLiveData = self.contestLiveDatas
            
        })
    }
    @IBAction func crossBtnAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Team", bundle: nil).instantiateViewController(withIdentifier: "KABADDITeamViewController") as! KABADDITeamViewController
        vc.fromPreview = true
        delegate?.checkFrom(check: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func getLeaderBoardTeams() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization" : "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDY1ODE4MCwiZXhwIjoxNTY0NjYxNzgwLCJuYmYiOjE1NjQ2NTgxODAsImp0aSI6IkhGMlJqeG91ZzhiUXhwN1IiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.8WU1ibQPqfzrXDprmQP277lRw1LVuGTNdQBf8kdkmCY",
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id") ?? -1, "challenge": challengeID,"teamid": teamId,"sport_key":"BASKETBALL"] as [String : Any]
            
            NetworkManager.post_Request2(urlService: KShowTeamOnGround, param: parameters, head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let jsonData = try JSON(data:response as! Data)
                        let status = jsonData["status"].intValue
                        let message = jsonData["message"].stringValue
                        let result = jsonData["result"]
                        
                        if status == 1 {
                            self.leaderBoardTeamArray = LeaderBoardKabaddiDetail(json: result)
                            
                        }
                        else {
                            Loader.showToast(message: message, onView: self.view, bottomMargin: 0, color: UIColor(red: 240, green: 75, blue: 80))
                        }
                    }
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    
    func getTeamInfo() {
        if isFromLeaderBoard {
            setupPreviewDataForLeaderBoardTeams()
            //  aEditButton.isHidden = true
            
            // aRefreshButton.isHidden = false
            aEditButton.isHidden = true
            editView.isHidden = true
            editLbl.isHidden = true
            editImageView.isHidden = true
            croosBtn.isHidden = false
        } else {
            if myTeamsData.count != 0 {
                teamInfo = myTeamsData[selectedIndex]
                setupPreviewDataForTeams()
                //  aEditButton.isHidden = false
                
                //aRefreshButton.isHidden = true
            }
        }
    }
    
    
    
    fileprivate func setupPreviewDataForTeams() {
        //              let teamNumber = teamInfo?.teamnumber
        //              aTeamNameLabel.text = "Team \(teamNumber ?? 0)"
        //              if let playerData = teamInfo?.players {
        //                  setupPreviewTeam(players: playerData)
        //              }
    }
    
    
    @IBAction func editButton(_ sender: Any) {
        delegate?.checkFrom(check: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    fileprivate func setupPreviewDataForLeaderBoardTeams() {
        let teamNumber = leaderBoardTeamArray?.teamnumber
        aTeamNameLabel.text = "Team \(teamNumber ?? 0)"
        if let wkData = leaderBoardTeamArray?.Pointguard {
            allRounder = wkData
        }
        if let allData = leaderBoardTeamArray?.Smallforward {
            raider = allData
        }
        
        if let wkData = leaderBoardTeamArray?.Shootingguard {
            defender = wkData
        }
        if let pgData = leaderBoardTeamArray?.Powerforward {
            pg = pgData
        }
        if let centerDataLeaderBoard = leaderBoardTeamArray?.Center {
            center = centerDataLeaderBoard
        }
        
        setWKDataLeaderBoard()
        setBatDataLeaderBoard()
        setAllDataLeaderBoard()
        setPGDataLeaderBoard()
        setCentreDataLeaderBoard()
    }
    fileprivate func setCentreDataLeaderBoard() {
        for (index,player) in center.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aCenter1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenterNameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter1UIView.backgroundColor = .black
                    aCenterNameLbl.backgroundColor = .black
                }
                center1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenterNameLbl.text = sortName
                }
                //                            awk1NameLbl.text = player.name ?? ""
                aCenterPointLbl.text = "\(player.credit ?? "") cr."
                aCenter1ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aCenter1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aCenter1CaptainLabel.isHidden = false
                    aCenter1CaptainLabel.text = "SK"
                     aCenter1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                        aCenter1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aCenter1CaptainLabel.isHidden = false
                    aCenter1CaptainLabel.text = "K"
                       aCenter1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                        aCenter1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            //                            }
            case 1:
                centerStackView.spacing = 100
                if player.team == "team1" {
                    aCenter2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenter2NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter2UIView.backgroundColor = .black
                    aCenter2NameLbl.backgroundColor = .black
                }
                center2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenter2NameLbl.text = sortName
                }
                //                            awk2NameLBl.text = player.name ?? ""
                aCenter2PointLbl.text = "\(player.credit ?? "") cr."
                aCenter2ContainerView.isHidden = false
                
                if player.captain == 1{
                   
                    aCenter2CaptainLabel.isHidden = false
                    aCenter2CaptainLabel.text = "SK"
                    aCenter2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aCenter2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aCenter2CaptainLabel.isHidden = false
                    aCenter2CaptainLabel.text = "K"
                    aCenter2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                        aCenter2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 2:
                centerStackView.spacing = 70
                if player.team == "team1" {
                    aCenter3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenter3NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter3UIView.backgroundColor = .black
                    aCenter3NameLbl.backgroundColor = .black
                }
                center3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenter3NameLbl.text = sortName
                }
                
                aCenter3PointLbl.text = "\(player.credit ?? "") cr."
                aCenter3ContainerView.isHidden = false
                
                if player.captain == 1 {
                    
                    aCenter3CaptainLabel.isHidden = false
                    aCenter3CaptainLabel.text = "SK"
                    aCenter3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aCenter3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aCenter3CaptainLabel.isHidden = false
                    aCenter3CaptainLabel.text = "K"
                   aCenter3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aCenter3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 3:
                centerStackView.spacing = 30
                if player.team == "team1" {
                    aCenter4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aCenter4NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aCenter4NameLbl.backgroundColor = .black
                    aCenter4UIVIew.backgroundColor = .black
                }
                center4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aCenter4NameLbl.text = sortName
                }
                
                aCenter4PointLbl.text = "\(player.credit ?? "") cr."
                aCenter4ContainerView.isHidden = false
                
                if player.captain == 1 {
                    
                    aCenter4CaptainLabel.isHidden = false
                    aCenter4CaptainLabel.text = "SK"
                    aCenter4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aCenter4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aCenter4CaptainLabel.isHidden = false
                    aCenter4CaptainLabel.text = "K"
                   aCenter3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aCenter3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aCenter4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            default:break
                
            }
        }
    }
    fileprivate func setPGDataLeaderBoard() {
        for (index,player) in pg.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    pF1UIIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF1UIIView.backgroundColor = .black
                    aPF1NameLabel.backgroundColor = .black
                }
                pf1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aPF1NameLabel.text = sortName
                }
                //                            awk1NameLbl.text = player.name ?? ""
                aPFPointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword1ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aPFCaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aPFCaptainLbl.isHidden = false
                    aPFCaptainLbl.text = "SK"
                   aPFCaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aPFCaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aPFCaptainLbl.isHidden = false
                    aPFCaptainLbl.text = "K"
                    aCenter3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aCenter3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
            //                            }
            case 1:
                pGStackView.spacing = 100
                if player.team == "team1" {
                    pF2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF2UIView.backgroundColor = .black
                    aPF2NameLabel.backgroundColor = .black
                }
                pf2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aPF2NameLabel.text = sortName
                }
                //                            awk2NameLBl.text = player.name ?? ""
                aPF2PointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword2ContainerView.isHidden = false
                
                if player.captain == 1 {
                  
                    aPF2CaptainLbl.isHidden = false
                    aPF2CaptainLbl.text = "SK"
                     aPF2CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aPF2CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aPF2CaptainLbl.isHidden = false
                    aPF2CaptainLbl.text = "K"
                   aCenter3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                     aCenter3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 2:
                pGStackView.spacing = 70
                if player.team == "team1" {
                    pF3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF3NameLabel.backgroundColor = .black
                }
                pf4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk3NameLbl.text = sortName
                }
                
                aPF3PointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword3ContainerView.isHidden = false
                
                if player.captain == 1 {
                    
                    aPF3CaptainLbl.isHidden = false
                    aPF3CaptainLbl.text = "SK"
                    aPF3CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aPF3CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aPF3CaptainLbl.isHidden = false
                    aPF3CaptainLbl.text = "K"
                    aPF3CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                     aPF3CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 3:
                pGStackView.spacing = 30
                if player.team == "team1" {
                    pF4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aPF4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    pF4UIVIew.backgroundColor = .black
                    aPF4NameLabel.backgroundColor = .black
                }
                pf4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aPF4NameLabel.text = sortName
                }
                
                aPF4PointLbl.text = "\(player.credit ?? "") cr."
                aPowerForword4ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aPF4CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aPF4CaptainLbl.isHidden = false
                    aPF4CaptainLbl.text = "SK"
                    aPF4CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aPF4CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aPF4CaptainLbl.isHidden = false
                    aPF4CaptainLbl.text = "K"
                    aPF4CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                     aPF4CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aPF4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            default:break
                
            }
        }
    }
    fileprivate func setWKDataLeaderBoard() {
        for (index,player) in allRounder.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    wk1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk1NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk1UIView.backgroundColor = .black
                    awk1NameLbl.backgroundColor = .black
                }
                self.wk1PlayingView.isHidden = true
                wk1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk1NameLbl.text = sortName
                }
                
                awk1PointLbl.text = "\(player.credit ?? "") cr."
                awk1ContainerView.isHidden = false
                if player.captain == 1 {
                   
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "Sk"
                   awkCaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                 awkCaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "K"
                       awkCaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                        awkCaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                wkStackView.spacing = 100
                if player.team == "team1" {
                    wk2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk2NameLBl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk2UIView.backgroundColor = .black
                    awk2NameLBl.backgroundColor = .black
                }
                self.wk2PlayingView.isHidden = true
                wk2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk2NameLBl.text = sortName
                }
                //                                awk2NameLBl.text = player.name ?? ""
                awk2PointLabel.text = "\(player.credit ?? "") cr."
                awk2ContainerView.isHidden = false
                
                if player.captain == 1 {
                  
                    awk2CaptainLbl.isHidden = false
                    awk2CaptainLbl.text = "Sk"
                    awk2CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awk2CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    awk2CaptainLbl.isHidden = false
                    awk2CaptainLbl.text = "K"
                     awk2CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awk2CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aWk2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
            //
            case 2:
                wkStackView.spacing = 70
                if player.team == "team1" {
                    wk3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk3NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk3UIView.backgroundColor = .black
                    awk3NameLbl.backgroundColor = .black
                }
                self.wk3PlayingView.isHidden = true
                wk3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk3NameLbl.text = sortName
                }
                //                                awk3NameLbl.text = player.name ?? ""
                awk3PointLbl.text = "\(player.credit ?? "") cr."
                awk3ContainerView.isHidden = false
                
                if player.captain == 1 {
                    
                    awk3CaptianLbl.isHidden = false
                    awk3CaptianLbl.text = "SK"
                   awk3CaptianLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awk3CaptianLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    awk3CaptianLbl.isHidden = false
                    awk3CaptianLbl.text = "K"
                     awk3CaptianLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awk3CaptianLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
            case 3:
                wkStackView.spacing = 30
                if player.team == "team1" {
                    wk4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk4NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk4UIVIew.backgroundColor = .black
                    awk4NameLbl.backgroundColor = .black
                }
                self.wk4PlayingView.isHidden = true
                wk4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk4NameLbl.text = sortName
                }
                //                                awk3NameLbl.text = player.name ?? ""
                awk4PointLbl.text = "\(player.credit ?? "") cr."
                awk3ContainerView.isHidden = false
                
                if player.captain == 1 {
                    
                    awk4CaptianLbl.isHidden = false
                    awk4CaptianLbl.text = "SK"
                    awk4CaptianLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awk4CaptianLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                
                if player.vicecaptain == 1 {
                    awk4CaptianLbl.isHidden = false
                    awk4CaptianLbl.text = "K"
                      awk4CaptianLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awk4CaptianLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                    
                }
                
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
                
            default:break
                
            }
        }
        
    }
    
    fileprivate func setAllDataLeaderBoard() {
        for (index,player) in raider.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    all1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all1UIView.backgroundColor = .black
                    aAR1NameLabel.backgroundColor = .black
                }
                self.all1PlayingView.isHidden = true
                
                ar1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR1NameLabel.text = sortName
                }
                //                    aAR1NameLabel.text = player.name ?? ""
                aAR1PointLabel.text = "\(player.credit ?? "") cr."
                aAR1ContainerView.isHidden = false
                if player.captain == 1 {
                    aAR1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "SK"
                    aAR1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "K"
                       aAR1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                       aAR1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                aRStackView.spacing = 100
                if player.team == "team1" {
                    all2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all2UIView.backgroundColor = .black
                    aAR2NameLabel.backgroundColor = .black
                }
                self.all2PlayingView.isHidden = true
                ar2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR2NameLabel.text = sortName
                }
                //                    aAR2NameLabel.text = player.name ?? ""
                aAR2PointLabel.text = "\(player.credit ?? "") cr."
                aAR2ContainerView.isHidden = false
                if player.captain == 1 {
                    aAR2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "SK"
                    aAR2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "K"
                     aAR2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                     aAR2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 2:
                aRStackView.spacing = 70
                if player.team == "team1" {
                    all3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all3UIView.backgroundColor = .black
                    aAR3NameLabel.backgroundColor = .black
                }
                self.all3PlayingView.isHidden = true
                ar3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR3NameLabel.text = sortName
                }
                //                    aAR3NameLabel.text = player.name ?? ""
                aAR3PointLabel.text = "\(player.credit ?? "") cr."
                aAR3ContainerView.isHidden = false
                if player.captain == 1 {
                   
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "SK"
                    aAR3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "K"
                      aAR3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 3:
                aRStackView.spacing = 30
                if player.team == "team1" {
                    all4UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all3UIView.backgroundColor = .black
                    aAR3NameLabel.backgroundColor = .black
                }
                self.all4PlayingView.isHidden = true
                ar4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR4NameLabel.text = sortName
                }
                //                    aAR3NameLabel.text = player.name ?? ""
                aAR4PointLabel.text = "\(player.credit ?? "") cr."
                aAR4ContainerView.isHidden = false
                if player.captain == 1 {
                    
                    aAR4CaptainLabel.isHidden = false
                    aAR4CaptainLabel.text = "SK"
                      aAR4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aAR4CaptainLabel.isHidden = false
                    aAR4CaptainLabel.text = "K"
                    aAR4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            default:
                break
            }
        }
    }
    fileprivate func setBatDataLeaderBoard() {
        for (index,player) in defender.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    bat1UiView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat1UiView.backgroundColor = .black
                    aBat1NameLabel.backgroundColor = .black
                }
                self.bat1PlayingView.isHidden = true
                bat1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat1NameLabel.text = sortName
                }
                //                    aBat1NameLabel.text = player.name ?? ""
                aBat1PointLabel.text = "\(player.credit ?? "") cr."
                aBat1ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "SK"
                   aBat1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                    
                }
                if player.vicecaptain == 1 {
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "K"
                     aBat1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                     aBat1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 1:
                batStackView.spacing = 100
                if player.team == "team1" {
                    bat2UiView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat2UiView.backgroundColor = .black
                    aBat2NameLabel.backgroundColor = .black
                }
                self.bat2PlayingView.isHidden = true
                bat2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat2NameLabel.text = sortName
                }
                //                    aBat2NameLabel.text = player.name ?? ""
                aBat2PointLabel.text = "\(player.credit ?? "") cr."
                aBat2ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "SK"
                    aBat2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "K"
                      aBat2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                batStackView.spacing = 70
                if player.team == "team1" {
                    bat3UiView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat3UiView.backgroundColor = .black
                    aBat3NameLabel.backgroundColor = .black
                }
                self.bat3PlayingView.isHidden = true
                bat3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat3NameLabel.text = sortName
                }
                //                    aBat3NameLabel.text = player.name ?? ""
                aBat3PointLabel.text = "\(player.credit ?? "") cr."
                aBat3ContainerView.isHidden = false
                if player.captain == 1 {
                  
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "SK"
                    aBat3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "K"
                   aBat3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                batStackView.spacing = 30
                if player.team == "team1" {
                    bat4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat4UIVIew.backgroundColor = .black
                    aBat4NameLabel.backgroundColor = .black
                }
                self.bat4PlayingView.isHidden = true
                bat4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat4NameLabel.text = sortName
                }
                //                    aBat3NameLabel.text = player.name ?? ""
                aBat4PointLabel.text = "\(player.credit ?? "") cr."
                aBat4ContainerView.isHidden = false
                if player.captain == 1 {
                   
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "SK"
                     aBat4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                aBat4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "K"
                    aBat4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            default:
                break
            }
        }
    }
    fileprivate func setWKDataList() {
        for (index,player) in wkArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    wk1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk1NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk1UIView.backgroundColor = .black
                    awk1NameLbl.backgroundColor = .black
                }
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk1NameLbl.text = sortName
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wk1PlayingView.isHidden = false
                        
                        wk1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wk1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wk1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    wk1PlayingView.isHidden = false
                }
                awk1PointLbl.text = "\(player.credit ?? "") cr."
                awk1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    awkCaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "SK"
                    awkCaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awkCaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "K"
                     awkCaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awkCaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 1:
                wkStackView.spacing = 100
                if player.team == "team1" {
                    wk2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk2NameLBl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk2UIView.backgroundColor = .black
                    awk2NameLBl.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wk2PlayingView.isHidden = false
                        
                        wk2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wk2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wk2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    wk2PlayingView.isHidden = false
                }
                wk2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk2NameLBl.text = sortName
                }
                //                            awk2NameLBl.text = player.name ?? ""
                awk2PointLabel.text = "\(player.credit ?? "") cr."
                awk2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    
                    awk2CaptainLbl.isHidden = false
                    awk2CaptainLbl.text = "SK"
                    awk2CaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awk2CaptainLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    awk2CaptainLbl.isHidden = false
                    awk2CaptainLbl.text = "K"
                      awk2CaptainLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                      awk2CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aWk2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                wkStackView.spacing = 70
                if player.team == "team1" {
                    wk3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk3NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk3UIView.backgroundColor = .black
                    awk3NameLbl.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wk3PlayingView.isHidden = false
                        
                        wk3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wk3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wk3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    wk3PlayingView.isHidden = false
                }
                wk3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk3NameLbl.text = sortName
                }
                //                            awk3NameLbl.text = player.name ?? ""
                awk3PointLbl.text = "\(player.credit ?? "") cr."
                awk3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    awk3CaptianLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awk3CaptianLbl.isHidden = false
                    awk3CaptianLbl.text = "SK"
                    awk3CaptianLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awk3CaptianLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    awk3CaptianLbl.isHidden = false
                    awk3CaptianLbl.text = "K"
                      awk3CaptianLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                awk3CaptianLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 3:
                wkStackView.spacing = 30
                if player.team == "team1" {
                    wk4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk4NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wk4UIVIew.backgroundColor = .black
                    awk4NameLbl.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wk4PlayingView.isHidden = false
                        
                        wk4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wk4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wk4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    wk4PlayingView.isHidden = false
                }
                wk4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk3NameLbl.text = sortName
                }
                //                            awk3NameLbl.text = player.name ?? ""
                awk4PointLbl.text = "\(player.credit ?? "") cr."
                awk4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    awk4CaptianLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    awk4CaptianLbl.isHidden = false
                    awk4CaptianLbl.text = "SK"
                   awk4CaptianLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    awk4CaptianLbl.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    awk4CaptianLbl.isHidden = false
                    awk4CaptianLbl.text = "K"
                     awk4CaptianLbl.borderColor = UIColor(red: 49, green: 139, blue: 22)
                     awk4CaptianLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            default:break
                
            }
        }
        
    }
    
    fileprivate func setAllDataList() {
        for (index,player) in allArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    all1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all1UIView.backgroundColor = .black
                    aAR1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all1PlayingView.isHidden = false
                        
                        all1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        all1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    all1PlayingView.isHidden = false
                }
                ar1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR1NameLabel.text = sortName
                }
                //                  aAR1NameLabel.text = player.name ?? ""
                aAR1PointLabel.text = "\(player.credit ?? "") cr."
                aAR1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aAR1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "SK"
                    aAR1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "K"
                      aAR1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR1ImageView?.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aAR1ImageView == nil {
                    //                        aAR1ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                    //                    }
                }
                
            case 1:
                aRStackView.spacing = 100
                if player.team == "team1" {
                    all2UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all2UIView.backgroundColor = .black
                    aAR2NameLabel.backgroundColor = .black
                }
                if player.team == "team1" {
                    all1UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all2UIView.backgroundColor = .black
                    aAR1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all2PlayingView.isHidden = false
                        
                        all2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        all2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    all2PlayingView.isHidden = false
                }
                ar2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR2NameLabel.text = sortName
                }
                //                  aAR2NameLabel.text = player.name ?? ""
                aAR2PointLabel.text = "\(player.credit ?? "") cr."
                aAR2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if  temp == self.captainID {
                    
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "SK"
                    aAR2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "K"
                    aAR2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aAR2ImageView == nil {
                    //                        aAR2ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                    //                    }
                }
                
            case 2:
                aRStackView.spacing = 70
                if player.team == "team1" {
                    all3UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all3UIView.backgroundColor = .black
                    aAR3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all3PlayingView.isHidden = false
                        
                        all3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        all3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    all3PlayingView.isHidden = false
                }
                ar3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR3NameLabel.text = sortName
                }
                //                  aAR3NameLabel.text = player.name ?? ""
                aAR3PointLabel.text = "\(player.credit ?? "") cr."
                aAR3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aAR3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "SK"
                    aAR3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == viceCaptianID {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "K"
                   aAR3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aAR3ImageView == nil {
                    //                        aR4ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                }
            case 3:
                aRStackView.spacing = 30
                if player.team == "team1" {
                    all4UIView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    all4UIView.backgroundColor = .black
                    aAR4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all4PlayingView.isHidden = false
                        
                        all4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        all4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    all4PlayingView.isHidden = false
                }
                ar4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR4NameLabel.text = sortName
                }
                //                  aAR3NameLabel.text = player.name ?? ""
                aAR4PointLabel.text = "\(player.credit ?? "") cr."
                aAR4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aAR4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR4CaptainLabel.isHidden = false
                    aAR4CaptainLabel.text = "SK"
                    aAR4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aAR4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == viceCaptianID {
                    aAR4CaptainLabel.isHidden = false
                    aAR4CaptainLabel.text = "K"
                     aAR4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                       aAR4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aAR3ImageView == nil {
                    //                        aR4ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                }
                
            default:
                break
            }
        }
    }
    fileprivate func setBatDataList() {
        for (index,player) in batArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    bat1UiView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat1UiView.backgroundColor = .black
                    aBat1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat1PlayingView.isHidden = false
                        
                        bat1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        bat1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    bat1PlayingView.isHidden = false
                }
                bat1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat1NameLabel.text = sortName
                }
                //                aBat1NameLabel.text = player.name ?? ""
                aBat1PointLabel.text = "\(player.credit ?? "") cr."
                aBat1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                
                if temp ==  self.captainID {
                    aBat1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "SK"
                    aBat1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                   aBat1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp ==  self.viceCaptianID{
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "K"
                    aBat1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
                //                }
                
            case 1:
                batStackView.spacing = 100
                if player.team == "team1" {
                    bat2UiView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat2UiView.backgroundColor = .black
                    aBat2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat2PlayingView.isHidden = false
                        
                        bat2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        bat2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    bat2PlayingView.isHidden = false
                }
                bat2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat2NameLabel.text = sortName
                }
                //                aBat2NameLabel.text = player.name ?? ""
                aBat2PointLabel.text = "\(player.credit ?? "") cr."
                aBat2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBat2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "SK"
                    aBat2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "K"
                    aBat2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                       aBat2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                batStackView.spacing = 70
                if player.team == "team1" {
                    bat3UiView.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat3UiView.backgroundColor = .black
                    aBat3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat3PlayingView.isHidden = false
                        
                        bat3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        bat3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    bat3PlayingView.isHidden = false
                }
                bat3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat3NameLabel.text = sortName
                }
                //                aBat3NameLabel.text = player.name ?? ""
                aBat3PointLabel.text = "\(player.credit ?? "") cr."
                aBat3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBat3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "SK"
                     aBat3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "K"
                      aBat3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                                          aBat3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                batStackView.spacing = 30
                if player.team == "team1" {
                    bat4UIVIew.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    bat4UIVIew.backgroundColor = .black
                    aBat4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat4PlayingView.isHidden = false
                        
                        bat4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        bat4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    bat4PlayingView.isHidden = false
                }
                bat4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat4NameLabel.text = sortName
                }
                //                aBat3NameLabel.text = player.name ?? ""
                aBat4PointLabel.text = "\(player.credit ?? "") cr."
                aBat4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBat4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "SK"
                    aBat4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "K"
                     aBat4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                                                                              aBat4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            default:
                break
            }
        }
    }
    @IBAction func aEditButtonAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Team", bundle: nil).instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
        vc.fromPreview = true
        //              delegate?.checkFrom(check: true)(check: true)
        self.navigationController?.popViewController(animated: true)
        //        openViewController(controller: EditCloneTeamViewController.self, storyBoard: .teamStoryBoard) { (vc) in
        //            if self.isFromLeaderBoard {
        //                vc.contestData = self.contestData
        //                let teamNum = self.leaderBoardTeamArray[0].teamnumber
        //                vc.teamNumber = "\(teamNum ?? 999)"
        //                vc.teamId = self.teamId
        //            } else {
        //                vc.contestData = self.contestData
        //                let teamNum = self.teamInfo?.teamnumber
        //                vc.teamNumber = "\(teamNum ?? 999)"
        //                vc.teamId = self.teamId
        //            }
        //        }
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
}
