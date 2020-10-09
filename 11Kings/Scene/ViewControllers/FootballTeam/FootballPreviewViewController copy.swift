//
//  FootballPreviewViewController.swift
//  
//
//  Created by Test on 06/06/20.
//


import UIKit
import SwiftyJSON
import Alamofire
protocol FootbaalPreviewDetail {
    func checkComingFromPReview(check :Bool)
}
class FootballPreviewViewController: BaseClass {
    
    var teamName:String?
    
    var contestLiveDatas:MyContestLiveLeagues?
    @IBOutlet weak var goalkeeperPlayingView: UIView!
    
    @IBOutlet weak var defStackView: UIStackView!
    @IBOutlet weak var fwdStackView: UIStackView!
    @IBOutlet weak var midStackView: UIStackView!
    @IBOutlet weak var mid4PlayingView: UIView!
    @IBOutlet weak var mid6PlayingView: UIView!
    @IBOutlet weak var mid5PlayingView: UIView!
    @IBOutlet weak var mid3PlayingView: UIView!
    @IBOutlet weak var mid2PlayingView: UIView!
    @IBOutlet weak var mid1PlayingView: UIView!
    
    @IBOutlet weak var def6PlayingView: UIView!
    
    @IBOutlet weak var def5PlayingView: UIView!
    @IBOutlet weak var def4PlayingView: UIView!
    @IBOutlet weak var def3PlayingView: UIView!
    @IBOutlet weak var def2PlayingView: UIView!
    @IBOutlet weak var def1PlayingView: UIView!
    @IBOutlet weak var aGoalKeeperView1: UIView!
    
    @IBOutlet weak var fowrd1PlayingView: UIView!
    @IBOutlet weak var forword3PlayingView: UIView!
    @IBOutlet weak var forword2PlayingView: UIView!
    @IBOutlet weak var forword4PlayingView: UIView!
    
    @IBOutlet weak var aDefView1: UIView!
    @IBOutlet weak var aDefView2: UIView!
    @IBOutlet weak var aDefView3: UIView!
    @IBOutlet weak var aDefView4: UIView!
    @IBOutlet weak var aDefView5: UIView!
    @IBOutlet weak var aDefView6: UIView!
    
    @IBOutlet weak var aMidView1: UIView!
    @IBOutlet weak var aMidView2: UIView!
    @IBOutlet weak var aMidView3: UIView!
    @IBOutlet weak var aMidView4: UIView!
    @IBOutlet weak var aMidView5: UIView!
    @IBOutlet weak var aMidView6: UIView!
    
    
    @IBOutlet weak var aForwordView1: UIView!
    @IBOutlet weak var aForwordView2: UIView!
    @IBOutlet weak var aForwordView3: UIView!
    @IBOutlet weak var aForwordView4: UIView!
    
    @IBOutlet weak var editLbl: UILabel!
    @IBOutlet weak var editBtnAction: UIButton!
    
    @IBOutlet weak var editImageView: UIImageView!
    @IBOutlet weak var crossBtn: UIButton!
    
    
    @IBOutlet weak var aGKCaptainLabel: UILabel!
    @IBOutlet weak var aGKContainerView: UIView!
    @IBOutlet weak var aGKImageView: UIImageView!
    @IBOutlet weak var aGKNameLabel: UILabel!
    @IBOutlet weak var aGKPointLabel: UILabel!
    
    @IBOutlet weak var aDef1CaptainLabel: UILabel!
    @IBOutlet weak var aDef1ContainerView: UIView!
    @IBOutlet weak var aDef1ImageView: UIImageView!
    @IBOutlet weak var aDef1NameLabel: UILabel!
    @IBOutlet weak var aDef1PointLabel: UILabel!
    
    @IBOutlet weak var aDef2CaptainLabel: UILabel!
    @IBOutlet weak var aDef2ContainerView: UIView!
    @IBOutlet weak var aDef2ImageView: UIImageView!
    @IBOutlet weak var aDef2NameLabel: UILabel!
    @IBOutlet weak var aDef2PointLabel: UILabel!
    
    @IBOutlet weak var aDef3CaptainLabel: UILabel!
    @IBOutlet weak var aDef3ContainerView: UIView!
    @IBOutlet weak var aBat3ImageView: UIImageView!
    @IBOutlet weak var aDef3NameLabel: UILabel!
    @IBOutlet weak var aDef3PointLabel: UILabel!
    
    @IBOutlet weak var aDef4CaptainLabel: UILabel!
    @IBOutlet weak var aDef4ContainerView: UIView!
    @IBOutlet weak var aDef4ImageView: UIImageView!
    @IBOutlet weak var aDef4NameLabel: UILabel!
    @IBOutlet weak var aDef4PointLabel: UILabel!
    
    @IBOutlet weak var aDef5CaptainLabel: UILabel!
    @IBOutlet weak var aDef5ContainerView: UIView!
    @IBOutlet weak var aDef5ImageView: UIImageView!
    @IBOutlet weak var aDef5NameLabel: UILabel!
    @IBOutlet weak var aDef5PointLabel: UILabel!
    
    @IBOutlet weak var aDef6CaptainLabel: UILabel!
    @IBOutlet weak var aDef6ContainerView: UIView!
    @IBOutlet weak var aDef6ImageView: UIImageView!
    @IBOutlet weak var aDef6NameLabel: UILabel!
    @IBOutlet weak var aDef6PointLabel: UILabel!
    
    @IBOutlet weak var aFwd1CaptainLabel: UILabel!
    @IBOutlet weak var aFwd1ContainerView: UIView!
    @IBOutlet weak var aFwd1ImageView: UIImageView!
    @IBOutlet weak var aFwd1NameLabel: UILabel!
    @IBOutlet weak var aFwd1PointLabel: UILabel!
    
    @IBOutlet weak var aFwd2CaptainLabel: UILabel!
    @IBOutlet weak var aFwd2ContainerView: UIView!
    @IBOutlet weak var aFwd2ImageView: UIImageView!
    @IBOutlet weak var aFwd2NameLabel: UILabel!
    @IBOutlet weak var aFwd2PointLabel: UILabel!
    
    @IBOutlet weak var aFwd3CaptainLabel: UILabel!
    @IBOutlet weak var aFwd3ContainerView: UIView!
    @IBOutlet weak var aFwd3ImageView: UIImageView!
    @IBOutlet weak var aFwd3NameLabel: UILabel!
    @IBOutlet weak var aFwd3PointLabel: UILabel!
    
    @IBOutlet weak var aFwd4CaptainLabel: UILabel!
    @IBOutlet weak var aFwd4ContainerView: UIView!
    @IBOutlet weak var aFwd4ImageView: UIImageView!
    @IBOutlet weak var aFwd4NameLabel: UILabel!
    @IBOutlet weak var aFwd4PointLabel: UILabel!
    
    @IBOutlet weak var aMid1CaptainLabel: UILabel!
    @IBOutlet weak var aMid1ContainerView: UIView!
    @IBOutlet weak var aMid1ImageView: UIImageView!
    @IBOutlet weak var aMid1NameLabel: UILabel!
    @IBOutlet weak var aMid1PointLabel: UILabel!
    
    @IBOutlet weak var aMid2CaptainLabel: UILabel!
    @IBOutlet weak var aMid2ContainerView: UIView!
    @IBOutlet weak var aMid2ImageView: UIImageView!
    @IBOutlet weak var aMid2NameLabel: UILabel!
    @IBOutlet weak var aMid2PointLabel: UILabel!
    
    @IBOutlet weak var aMid3CaptainLabel: UILabel!
    @IBOutlet weak var aMid3ContainerView: UIView!
    @IBOutlet weak var aMid3ImageView: UIImageView!
    @IBOutlet weak var aMid3NameLabel: UILabel!
    @IBOutlet weak var aMid3PointLabel: UILabel!
    
    @IBOutlet weak var aMid4CaptainLabel: UILabel!
    @IBOutlet weak var aMid4ContainerView: UIView!
    @IBOutlet weak var amid4ImageView: UIImageView!
    @IBOutlet weak var aMid4NameLabel: UILabel!
    @IBOutlet weak var aMid4PointLabel: UILabel!
    
    @IBOutlet weak var aMid5CaptainLabel: UILabel!
    @IBOutlet weak var aMid5ContainerView: UIView!
    @IBOutlet weak var aMid5ImageView: UIImageView!
    @IBOutlet weak var aMid5NameLabel: UILabel!
    @IBOutlet weak var aMid5PointLabel: UILabel!
    @IBOutlet weak var aMid6CaptainLabel: UILabel!
    @IBOutlet weak var aMid6ContainerView: UIView!
    @IBOutlet weak var aMid6ImageView: UIImageView!
    @IBOutlet weak var aMid6NameLabel: UILabel!
    @IBOutlet weak var aMid6PointLabel: UILabel!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    
    var getTeamResponse:MyTeamResponses?
    var isComingFromMyteam = false
    var isFromEditClone = false
    var teamId = 0
    
    var arrayOFSelectedPlayer = [Int]()
    var comingromFromPReview = false
    var vcID = 0
    var cId = 0
    var c = 0
    var v = 0
    
    var delegate : FootbaalPreviewDetail?
    
    var gk1_Player_ID = 0
    
    var def1_Player_ID = 0
    var def2_Player_ID = 0
    var def3_Player_ID = 0
    var def4_Player_ID = 0
    var def5_Player_ID = 0
    var def6_Player_ID = 0
    
    var fwd1_Player_ID = 0
    var fwd2_Player_ID = 0
    var fwd3_Player_ID = 0
    var fwd4_Player_ID = 0
    
    var mid1_Player_ID = 0
    var mid2_Player_ID = 0
    var mid3_Player_ID = 0
    var mid4_Player_ID = 0
    var mid5_Player_ID = 0
    var mid6_Player_ID = 0
    
    var gkArrayList = [PlayerListResponses]()
    var defArrayList = [PlayerListResponses]()
    var midArrayList = [PlayerListResponses]()
    var fwdArrayList = [PlayerListResponses]()
    
    var goalKeeperArrayLeaderBoard = [LeaderBoardPlayerDetail]()
    var defenderArrayLeaderBoard = [LeaderBoardPlayerDetail]()
    var forwordArrayLeaderboard = [LeaderBoardPlayerDetail]()
    var midFielderArrayLeader = [LeaderBoardPlayerDetail]()
    
    var gkArray = [PlayerDetail]()
    var defenderArray = [PlayerDetail]()
    var midRFielderArray = [PlayerDetail]()
    var fwdArray = [PlayerDetail]()
    
    var contestData: Any?
    var teamID  = 0
    var challengeID = 0
    var isFromLeaderBoard = false
    var isFromCreateTEam = false
    var matchKey = ""
    var selectedIndex = -1
    var captainID:String?
    var viceCaptianID:String?
    var teamInfo: MyTeamResponses?
    
    
    
    var leaderBoardTeamArray :LeaderBoardFootballDetail? {
        didSet {
            getTeamInfo()
        }
    }
    var myTeamsData = [MyTeamResponses]() {
        didSet {
            getTeamInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
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
    
    
    /// UI Setup
    fileprivate func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        
        goalkeeperPlayingView.layer.cornerRadius = goalkeeperPlayingView.frame.size.width/2
        goalkeeperPlayingView.clipsToBounds = true
        goalkeeperPlayingView.layer.borderColor = UIColor.white.cgColor
        goalkeeperPlayingView.layer.borderWidth = 5.0
        
        
        def1PlayingView.layer.cornerRadius = def1PlayingView.frame.size.width/2
        def1PlayingView.clipsToBounds = true
        def1PlayingView.layer.borderColor = UIColor.white.cgColor
        def1PlayingView.layer.borderWidth = 5.0
        
        def2PlayingView.layer.cornerRadius = def2PlayingView.frame.size.width/2
        def2PlayingView.clipsToBounds = true
        def2PlayingView.layer.borderColor = UIColor.white.cgColor
        def2PlayingView.layer.borderWidth = 5.0
        
        def3PlayingView.layer.cornerRadius = def3PlayingView.frame.size.width/2
        def3PlayingView.clipsToBounds = true
        def3PlayingView.layer.borderColor = UIColor.white.cgColor
        def3PlayingView.layer.borderWidth = 5.0
        
        def4PlayingView.layer.cornerRadius = def4PlayingView.frame.size.width/2
        def4PlayingView.clipsToBounds = true
        def4PlayingView.layer.borderColor = UIColor.white.cgColor
        def4PlayingView.layer.borderWidth = 5.0
        
        def6PlayingView.layer.cornerRadius = def6PlayingView.frame.size.width/2
        def6PlayingView.clipsToBounds = true
        def6PlayingView.layer.borderColor = UIColor.white.cgColor
        def6PlayingView.layer.borderWidth = 5.0
        
        def5PlayingView.layer.cornerRadius = def5PlayingView.frame.size.width/2
        def5PlayingView.clipsToBounds = true
        def5PlayingView.layer.borderColor = UIColor.white.cgColor
        def5PlayingView.layer.borderWidth = 5.0
        
        
        mid1PlayingView.layer.cornerRadius = mid1PlayingView.frame.size.width/2
        mid1PlayingView.clipsToBounds = true
        mid1PlayingView.layer.borderColor = UIColor.white.cgColor
        mid1PlayingView.layer.borderWidth = 5.0
        
        mid2PlayingView.layer.cornerRadius = mid2PlayingView.frame.size.width/2
        mid2PlayingView.clipsToBounds = true
        mid2PlayingView.layer.borderColor = UIColor.white.cgColor
        mid2PlayingView.layer.borderWidth = 5.0
        
        mid3PlayingView.layer.cornerRadius = mid3PlayingView.frame.size.width/2
        mid3PlayingView.clipsToBounds = true
        mid3PlayingView.layer.borderColor = UIColor.white.cgColor
        mid3PlayingView.layer.borderWidth = 5.0
        
        mid4PlayingView.layer.cornerRadius = mid4PlayingView.frame.size.width/2
        mid4PlayingView.clipsToBounds = true
        mid4PlayingView.layer.borderColor = UIColor.white.cgColor
        mid4PlayingView.layer.borderWidth = 5.0
        
        mid5PlayingView.layer.cornerRadius = mid5PlayingView.frame.size.width/2
        mid5PlayingView.clipsToBounds = true
        mid5PlayingView.layer.borderColor = UIColor.white.cgColor
        mid5PlayingView.layer.borderWidth = 5.0
        
        mid6PlayingView.layer.cornerRadius = mid6PlayingView.frame.size.width/2
        mid6PlayingView.clipsToBounds = true
        mid6PlayingView.layer.borderColor = UIColor.white.cgColor
        mid6PlayingView.layer.borderWidth = 5.0
        
        
        fowrd1PlayingView.layer.cornerRadius = fowrd1PlayingView.frame.size.width/2
        fowrd1PlayingView.clipsToBounds = true
        fowrd1PlayingView.layer.borderColor = UIColor.white.cgColor
        fowrd1PlayingView.layer.borderWidth = 5.0
        
        forword2PlayingView.layer.cornerRadius = forword2PlayingView.frame.size.width/2
        forword2PlayingView.clipsToBounds = true
        forword2PlayingView.layer.borderColor = UIColor.white.cgColor
        forword2PlayingView.layer.borderWidth = 5.0
        
        forword3PlayingView.layer.cornerRadius = forword3PlayingView.frame.size.width/2
        forword3PlayingView.clipsToBounds = true
        forword3PlayingView.layer.borderColor = UIColor.white.cgColor
        forword3PlayingView.layer.borderWidth = 5.0
        
        forword4PlayingView.layer.cornerRadius = forword4PlayingView.frame.size.width/2
        forword4PlayingView.clipsToBounds = true
        forword4PlayingView.layer.borderColor = UIColor.white.cgColor
        forword4PlayingView.layer.borderWidth = 5.0
        
        
        aFwd1ContainerView.isHidden = true
        aFwd2ContainerView.isHidden = true
        aFwd3ContainerView.isHidden = true
        aFwd4ContainerView.isHidden = true
        aGKCaptainLabel.isHidden = true
        aGKContainerView.isHidden = true
        aGKNameLabel.isHidden = true
        aGKPointLabel.isHidden = true
        
        aDef1ContainerView.isHidden = true
        aDef2ContainerView.isHidden = true
        aDef3ContainerView.isHidden = true
        aDef4ContainerView.isHidden = true
        aDef5ContainerView.isHidden = true
        aDef6ContainerView.isHidden = true
        
        
        aMid1ContainerView.isHidden = true
        aMid2ContainerView.isHidden = true
        aMid3ContainerView.isHidden = true
        aMid4ContainerView.isHidden = true
        aMid5ContainerView.isHidden = true
        aMid6ContainerView.isHidden = true
        
        aFwd1CaptainLabel.isHidden = true
        aFwd2CaptainLabel.isHidden = true
        aFwd3CaptainLabel.isHidden = true
        aFwd4CaptainLabel.isHidden = true
        
        aDef1CaptainLabel.isHidden = true
        aDef2CaptainLabel.isHidden = true
        aDef3CaptainLabel.isHidden = true
        aDef4CaptainLabel.isHidden = true
        aDef5CaptainLabel.isHidden = true
        aDef6CaptainLabel.isHidden = true
        
        aMid1CaptainLabel.isHidden = true
        aMid2CaptainLabel.isHidden = true
        aMid3CaptainLabel.isHidden = true
        aMid4CaptainLabel.isHidden = true
        aMid5CaptainLabel.isHidden = true
        aMid6CaptainLabel.isHidden = true
        
        aFwd1CaptainLabel.setCornerRadius(value: 10)
        aFwd2CaptainLabel.setCornerRadius(value: 10)
        aFwd3CaptainLabel.setCornerRadius(value: 10)
        aFwd4CaptainLabel.setCornerRadius(value: 10)
        aGKCaptainLabel.setCornerRadius(value: 10)
        aDef1CaptainLabel.setCornerRadius(value: 10)
        aDef2CaptainLabel.setCornerRadius(value: 10)
        aDef3CaptainLabel.setCornerRadius(value: 10)
        aDef4CaptainLabel.setCornerRadius(value: 10)
        aDef5CaptainLabel.setCornerRadius(value: 10)
        aDef6CaptainLabel.setCornerRadius(value: 10)
        aMid1CaptainLabel.setCornerRadius(value: 10)
        aMid2CaptainLabel.setCornerRadius(value: 10)
        aMid3CaptainLabel.setCornerRadius(value: 10)
        aMid4CaptainLabel.setCornerRadius(value: 10)
        aMid5CaptainLabel.setCornerRadius(value: 10)
        aMid6CaptainLabel.setCornerRadius(value: 10)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewControllerB = segue.destination as? TeamViewController {
            viewControllerB.fromPreview = comingromFromPReview
            //Do what you want in here!
        }
        
    }
    
    @IBAction func crossBtnAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Team", bundle: nil).instantiateViewController(withIdentifier: "FootballTeamViewController") as! FootballTeamViewController
        vc.fromPreview = true
        delegate?.checkComingFromPReview(check: true)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        if isFromLeaderBoard {
            getLeaderBoardTeams()
        } else {
            getMyTeamsData()
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        openEditFootballVC(arryOfPlayer :arrayOFSelectedPlayer,viceCaptainID : vcID,captainID :cId,teamIDs:teamID)
    }
    
    
    fileprivate func setContestData() {
        if let contest = contestData as? GetMatchDetails {
            matchKey = contest.matchkey ?? ""
        }
        if let contest = contestData as? MyContestReponse {
            matchKey = contest.matchkey ?? ""
        }
    }
    
    
    /// Get Team Data  from Api
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
                    //
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
    
    
    func getLeaderBoardTeams() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization" : "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDY1ODE4MCwiZXhwIjoxNTY0NjYxNzgwLCJuYmYiOjE1NjQ2NTgxODAsImp0aSI6IkhGMlJqeG91ZzhiUXhwN1IiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.8WU1ibQPqfzrXDprmQP277lRw1LVuGTNdQBf8kdkmCY",
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id") ?? -1, "challenge": challengeID,"teamid": teamId,"sport_key": "FOOTBALL"] as [String : Any]
            NetworkManager.post_Request2(urlService: KShowTeamOnGround, param: parameters, head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let jsonData = try JSON(data:response as! Data)
                        let status = jsonData["status"].intValue
                        let message = jsonData["message"].stringValue
                        let result = jsonData["result"]
                        
                        if status == 1 {
                            self.leaderBoardTeamArray = LeaderBoardFootballDetail(json: result)
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
    
    
    /// Setup For Cream Team UI
    fileprivate func setupPreviewTeamFromCreate() {
        crossBtn.isHidden = false
        editLbl.isHidden = true
        editBtnAction.isHidden = true
        editImageView.isHidden = true
        for player in APP_DEL.footballChoosedTeamArray {
            if player.role == "Midfielder" {
                midArrayList.append(player)
            }
            if player.role == "Defender" {
                defArrayList.append(player)
            }
            if player.role == "Forward" {
                fwdArrayList.append(player)
            }
            if player.role == "Goalkeeper" {
                gkArrayList.append(player)
            }
            
        }
        
        setGKDataList()
        setDefDataList()
        setFwdDataList()
        setMidFielderDataList()
        
    }
    
    
    func getTeamInfo() {
        if isFromLeaderBoard {
            setupPreviewDataForLeaderBoardTeams()
            aTeamNameLabel.isHidden = true
            editBtnAction.isHidden = true
            editLbl.isHidden = true
            editImageView.isHidden = true
            crossBtn.isHidden = false
        } else {
            if myTeamsData.count != 0 {
                teamInfo = myTeamsData[selectedIndex]
                setupPreviewDataForTeams()
                
            }
        }
    }
    
    
    fileprivate func setupPreviewDataForTeams() {
        let teamNumber = teamInfo?.teamnumber
        aTeamNameLabel.text = "Team \(teamNumber ?? 0)"
        if let playerData = teamInfo?.players {
            setupPreviewTeam(players: playerData)
        }
    }
    
    fileprivate func setupPreviewTeam(players: [PlayerDetail]) {
        for player in players {
            if let playerType = player.role {
                switch playerType {
                case "Goalkeeper" :
                    gkArray.append(player)
                case "Defender" :
                    defenderArray.append(player)
                case "Forward" :
                    fwdArray.append(player)
                case "Midfielder" :
                    midRFielderArray.append(player)
                default:
                    break
                }
            }
        }
        setGKData()
        setDefData()
        setFwdData()
        setMidData()
    }
    
    func openEditFootballVC(arryOfPlayer :[Int],viceCaptainID : Int,captainID :Int,teamIDs:Int){
        openViewController(controller: FootballTeamViewController.self, storyBoard: .teamStoryBoard, handler: { (vc) in
            vc.arrayOFPlayer  = arryOfPlayer
            vc.contestData = self.contestData as? GetMatchDetails
            vc.viceCaptian = viceCaptainID
            vc.Captain = captainID
            vc.teamId = teamIDs
            vc.contestLiveData = self.contestLiveDatas
            
        })
    }
    
    fileprivate func setupPReviewForMyTeam(data:MyTeamResponses) {
        crossBtn.isHidden = true
        editLbl.isHidden = false
        editBtnAction.isHidden = false
        editImageView.isHidden = false
        aTeamNameLabel.text = teamName
        if let players = data.players {
            for player in players {
                self.arrayOFSelectedPlayer.append(player.id ?? 0)
                if player.captain == 1 {
                    self.cId = player.id ?? 0
                }
                if player.vicecaptain == 1 {
                    self.vcID = player.id ?? 0
                }
                if player.role == "Defender" {
                    
                    defenderArray.append(player)
                }
                if player.role == "Forward" {
                    fwdArray.append(player)
                }
                if player.role == "Midfielder" {
                    midRFielderArray.append(player)
                }
                if player.role == "Goalkeeper" {
                    gkArray.append(player)
                }
            }
        }
        setGKData()
        setMidData()
        setFwdData()
        setDefData()
        
        
    }
    
    
    fileprivate func setupPReviewForCreate(data:MyTeamResponses) {
        if let players = data.players {
            for player in players {
                
                if player.captain == 1 {
                    
                }
                if player.vicecaptain == 1 {
                    
                }
                if player.role == "Defender" {
                    
                    defenderArray.append(player)
                }
                if player.role == "Midfielder" {
                    midRFielderArray.append(player)
                }
                if player.role == "Forward" {
                    fwdArray.append(player)
                }
                if player.role == "Goalkeeper" {
                    gkArray.append(player)
                }
            }
        }
        setGKDataList()
        setMidFielderDataList()
        setFwdDataList()
        setDefDataList()
    }
    
    fileprivate func setupPreviewDataForLeaderBoardTeams() {
        let teamNumber = leaderBoardTeamArray?.teamnumber
        aTeamNameLabel.text = "Team \(teamNumber ?? 0)"
        if let wkData = leaderBoardTeamArray?.Goalkeeper {
            goalKeeperArrayLeaderBoard = wkData
        }
        if let allData = leaderBoardTeamArray?.Midfielder {
            midFielderArrayLeader = allData
        }
        if let wkData = leaderBoardTeamArray?.Forward {
            forwordArrayLeaderboard = wkData
        }
        if let wkData = leaderBoardTeamArray?.Defender {
            defenderArrayLeaderBoard = wkData
        }
        setWKDataLeaderBoard()
        setBatDataLeaderBoard()
        setBowlDataLeaderBoard()
        setAllDataLeaderBoard()
        
    }
    
    fileprivate func setWKDataLeaderBoard() {
        for player in goalKeeperArrayLeaderBoard {
            if player.team == "team1" {
                aGoalKeeperView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                aGKNameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
            } else {
                aGoalKeeperView1.backgroundColor = .black
                aGKNameLabel.backgroundColor = .black
            }
            
            goalkeeperPlayingView.isHidden = true
            gk1_Player_ID = player.id ?? 0
            let nameFormatter = PersonNameComponentsFormatter()
            if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                
                let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                aGKNameLabel.text = sortName
            }
            aGKNameLabel.isHidden = false
            aGKPointLabel.isHidden = false
            aGKImageView.isHidden = false
            aGKPointLabel.text = "\(player.credit ?? "") cr."
            aGKContainerView.isHidden = false
            
            if player.captain == 1 {
                
                aGKCaptainLabel.isHidden = false
                aGKCaptainLabel.text = "SK"
                aGKCaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
            }
            if player.vicecaptain == 1 {
                aGKCaptainLabel.isHidden = false
                aGKCaptainLabel.text = "K"
                aGKCaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                aGKCaptainLabel .backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                
            }
            if let imagePath = player.image {
                let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                let imageUrl = URL(string: urlString1 ?? "")
                aGKImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                }
            }
        }
    }
    
    fileprivate func setBowlDataLeaderBoard() {
        for (index,player) in midFielderArrayLeader.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aMidView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView1.backgroundColor = .black
                    aMid1NameLabel.backgroundColor = .black
                }
                mid1PlayingView.isHidden = true
                mid1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid1NameLabel.text = sortName
                }
                aMid1PointLabel.text = "\(player.credit ?? "") cr."
                aMid1ContainerView.isHidden = false
                
                if player.captain == 1{
                    
                    aMid1CaptainLabel.isHidden = false
                    aMid1CaptainLabel.text = "SK"
                    aMid1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                        aMid1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                    
                }
                if player.vicecaptain == 1 {
                    aMid1CaptainLabel.isHidden = false
                    aMid1CaptainLabel.text = "K"
                    aMid1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                midStackView.spacing = 100
                if player.team == "team1" {
                    aMidView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView2.backgroundColor = .black
                    aMid2NameLabel.backgroundColor = .black
                }
                mid2PlayingView.isHidden = true
                mid2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid2NameLabel.text = sortName
                }
                aMid2PointLabel.text = "\(player.credit ?? "") cr."
                aMid2ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aMid2CaptainLabel.isHidden = false
                    aMid2CaptainLabel.text = "v"
                     aMid2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aMid2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1{
                    aMid2CaptainLabel.isHidden = false
                    aMid2CaptainLabel.text = "K"
                    aMid2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 2:
                midStackView.spacing = 80
                if player.team == "team1" {
                    aMidView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView3.backgroundColor = .black
                    aMid3NameLabel.backgroundColor = .black
                }
                mid3PlayingView.isHidden = true
                mid3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid3NameLabel.text = sortName
                }
                
                aMid3PointLabel.text = "\(player.credit ?? "") cr."
                aMid3ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aMid3CaptainLabel.isHidden = false
                    aMid3CaptainLabel.text = "SK"
                      aMid3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                        aMid3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aMid3CaptainLabel.isHidden = false
                    aMid3CaptainLabel.text = "K"
                    aMid3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 3:
                midStackView.spacing = 50
                if player.team == "team1" {
                    aMidView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView4.backgroundColor = .black
                    aMid4NameLabel.backgroundColor = .black
                }
                mid4PlayingView.isHidden = true
                mid4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid4NameLabel.text = sortName
                }
                
                aMid4PointLabel.text = "\(player.credit ?? "") cr."
                aMid4ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aMid4CaptainLabel.isHidden = false
                    aMid4CaptainLabel.text = "SK"
                   aMid4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aMid4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aMid4CaptainLabel.isHidden = false
                    aMid4CaptainLabel.text = "K"
                    aMid4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    amid4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
                
            case 4:
                midStackView.spacing = 20
                if player.team == "team1" {
                    aMidView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView5.backgroundColor = .black
                    aMid5NameLabel.backgroundColor = .black
                }
                mid5PlayingView.isHidden = true
                mid5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid5NameLabel.text = sortName
                }
                
                aMid5PointLabel.text = "\(player.credit ?? "") cr."
                aMid5ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aMid5CaptainLabel.isHidden = false
                    aMid5CaptainLabel.text = "SK"
                      aMid5CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                      aMid5CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1{
                    aMid5CaptainLabel.isHidden = false
                    aMid5CaptainLabel.text = "K"
                    aMid5CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                midStackView.spacing = 10
                if player.team == "team1" {
                    aMidView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView6.backgroundColor = .black
                    aMid6NameLabel.backgroundColor = .black
                }
                mid6PlayingView.isHidden = true
                
                mid6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid6NameLabel.text = sortName
                }
                
                aMid6PointLabel.text = "\(player.credit ?? "") cr."
                aMid6ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aMid6CaptainLabel.isHidden = false
                    aMid6CaptainLabel.text = "SK"
                   aMid6CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aMid6CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1{
                    aMid6CaptainLabel.isHidden = false
                    aMid6CaptainLabel.text = "K"
                  aMid6CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid6CaptainLabel .backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            default:
                break
            }
        }
    }
    
    fileprivate func setAllDataLeaderBoard() {
        for (index,player) in forwordArrayLeaderboard.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aForwordView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView2.backgroundColor = .black
                    aFwd1NameLabel.backgroundColor = .black
                }
                fowrd1PlayingView.isHidden = true
                fwd1_Player_ID = player.id ?? 0
                aFwd1NameLabel.text = player.name ?? ""
                aFwd1PointLabel.text = "\(player.credit ?? "") cr."
                aFwd1ContainerView.isHidden = false
                
                if player.captain == 1{
                    aFwd1CaptainLabel.isHidden = false
                    aFwd1CaptainLabel.text = "SK"
                     aFwd1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aFwd1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aFwd1CaptainLabel.isHidden = false
                    aFwd1CaptainLabel.text = "K"
                     aFwd1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                        
                    }
                }
            case 1:
                fwdStackView.spacing = 100
                if player.team == "team1" {
                    aFwd2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aForwordView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView2.backgroundColor = .black
                    aFwd2NameLabel.backgroundColor = .black
                }
                forword2PlayingView.isHidden = true
                
                fwd2_Player_ID = player.id ?? 0
                aFwd2NameLabel.text = player.name ?? ""
                aFwd2PointLabel.text = "\(player.credit ?? "") cr."
                aFwd2ContainerView.isHidden = false
                
                if  player.captain == 1 {
                    aFwd2CaptainLabel.isHidden = false
                    aFwd2CaptainLabel.text = "SK"
                   aFwd2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aFwd2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aFwd2CaptainLabel.isHidden = false
                    aFwd2CaptainLabel.text = "K"
                    aFwd2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 2:
                fwdStackView.spacing = 80
                if player.team == "team1" {
                    aForwordView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView3.backgroundColor = .black
                    aFwd3NameLabel.backgroundColor = .black
                }
                forword3PlayingView.isHidden = true
                fwd3_Player_ID = player.id ?? 0
                aFwd3NameLabel.text = player.name ?? ""
                aFwd3PointLabel.text = "\(player.credit ?? "") cr."
                aFwd3ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aFwd3CaptainLabel.isHidden = false
                    aFwd3CaptainLabel.text = "SK"
                     aFwd3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aFwd3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aFwd3CaptainLabel.isHidden = false
                    aFwd3CaptainLabel.text = "K"
                   aFwd3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                
            case 3:
                fwdStackView.spacing = 50
                if player.team == "team1" {
                    aForwordView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView4.backgroundColor = .black
                    aFwd4NameLabel.backgroundColor = .black
                }
                forword4PlayingView.isHidden = true
                fwd4_Player_ID = player.id ?? 0
                aFwd4NameLabel.text = player.name ?? ""
                aFwd4PointLabel.text = "\(player.credit ?? "") cr."
                aFwd4ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aFwd4CaptainLabel.isHidden = false
                    aFwd4CaptainLabel.text = "SK"
                    aFwd4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aFwd4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aFwd4CaptainLabel.isHidden = false
                    aFwd4CaptainLabel.text = "K"
                    aFwd4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            default:
                break
            }
        }
    }
    fileprivate func setBatDataLeaderBoard() {
        for (index,player) in defenderArrayLeaderBoard.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aDefView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView1.backgroundColor = .black
                    aDef1NameLabel.backgroundColor = .black
                }
                self.def1PlayingView.isHidden = true
                def1_Player_ID = player.id ?? 0
                aDef1NameLabel.text = player.name ?? ""
                aDef1PointLabel.text = "\(player.credit ?? "") cr."
                aDef1ContainerView.isHidden = false
                
                
                if player.captain == 1 {
                    aDef1CaptainLabel.isHidden = false
                    aDef1CaptainLabel.text = "SK"
                    aDef1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aDef1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aDef1CaptainLabel.isHidden = false
                    aDef1CaptainLabel.text = "K"
                     aDef1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
                
            case 1:
                defStackView.spacing = 100
                if player.team == "team1" {
                    aDefView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView2.backgroundColor = .black
                    aDef2NameLabel.backgroundColor = .black
                }
                self.def2PlayingView.isHidden = true
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef2NameLabel.text = sortName
                }
                def2_Player_ID = player.id ?? 0
                //                aBat2NameLabel.text = player.name ?? ""
                aDef2PointLabel.text = "\(player.credit ?? "") cr."
                aDef2ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aDef2CaptainLabel.isHidden = false
                    aDef2CaptainLabel.text = "SK"
                    aDef2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aDef2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aDef2CaptainLabel.isHidden = false
                    aDef2CaptainLabel.text = "K"
                    aDef2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 2:
                defStackView.spacing = 80
                if player.team == "team1" {
                    aDefView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView3.backgroundColor = .black
                    aDef3NameLabel.backgroundColor = .black
                }
                def3PlayingView.isHidden = true
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef3NameLabel.text = sortName
                }
                def3_Player_ID = player.id ?? 0
                //                aBat3NameLabel.text = player.name ?? ""
                aDef3PointLabel.text = "\(player.credit ?? "") cr."
                aDef3ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aDef3CaptainLabel.isHidden = false
                    aDef3CaptainLabel.text = "SK"
                      aDef3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                        aDef3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aDef3CaptainLabel.isHidden = false
                    aDef3CaptainLabel.text = "K"
                      aDef3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 3:
                defStackView.spacing = 50
                if player.team == "team1" {
                    aDefView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView4.backgroundColor = .black
                    aDef4NameLabel.backgroundColor = .black
                }
                self.def4PlayingView.isHidden = true
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef4NameLabel.text = sortName
                }
                def4_Player_ID = player.id ?? 0
                //                aBat4NameLabel.text = player.name ?? ""
                aDef4PointLabel.text = "\(player.credit ?? "") cr."
                aDef4ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aDef4CaptainLabel.isHidden = false
                    aDef4CaptainLabel.text = "SK"
                     aDef4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aDef4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1{
                    aDef4CaptainLabel.isHidden = false
                    aDef4CaptainLabel.text = "K"
                    aDef3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                   aDef3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 4:
                defStackView.spacing = 20
                if player.team == "team1" {
                    aDefView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView5.backgroundColor = .black
                    aDef5NameLabel.backgroundColor = .black
                }
                self.def5PlayingView.isHidden = true
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef5NameLabel.text = sortName
                }
                def5_Player_ID = player.id ?? 0
                //                aBat5NameLabel.text = player.name ?? ""
                aDef5PointLabel.text = "\(player.credit ?? "") cr."
                aDef5ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aDef5CaptainLabel.isHidden = false
                    aDef5CaptainLabel.text = "SK"
                     aDef5CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                        aDef5CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aDef5CaptainLabel.isHidden = false
                    aDef5CaptainLabel.text = "K"
                   aDef5CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                //                if let imagePath = player.image {
            //
            default:
                break
            }
        }
    }
    @IBAction func editActin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setGKDataList() {
        for player in gkArrayList {
            if player.team == "team1" {
                aGoalKeeperView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                aGKNameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
            } else {
                aGoalKeeperView1.backgroundColor = .black
                aGKNameLabel.backgroundColor = .black
            }
            if player.is_playing_show == 1 {
                if player.is_playing == 1 {
                    goalkeeperPlayingView.isHidden = false
                    goalkeeperPlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                }
                else {
                    goalkeeperPlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                    goalkeeperPlayingView.isHidden = false
                }
                
            }
            else {
                goalkeeperPlayingView.isHidden = false
            }
            gk1_Player_ID = player.id ?? 0
            //                     aWKNameLabel.text = player.name
            let nameFormatter = PersonNameComponentsFormatter()
            if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                
                let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                aGKNameLabel.text = sortName
            }
            aGKNameLabel.isHidden = false
            aGKPointLabel.isHidden = false
            aGKImageView.isHidden = false
            aGKPointLabel.text = "\(player.credit ?? "") cr."
            aGKContainerView.isHidden = false
            let temp = "\(player.id ?? 0)"
            if temp == self.captainID {
                
                aGKCaptainLabel.isHidden = false
                aGKCaptainLabel.text = "SK"
                aGKCaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aGKCaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
            }
            if temp == self.viceCaptianID  {
                aGKCaptainLabel.isHidden = false
                aGKCaptainLabel.text = "K"
                aGKCaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                aGKCaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
            }
            if let imagePath = player.image {
                let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                let imageUrl = URL(string: urlString1 ?? "")
                aGKImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                }
            }
        }
    }
    fileprivate func setMidFielderDataList() {
        for (index,player) in midArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aMidView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView2.backgroundColor = .black
                    aMid1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid1PlayingView.isHidden = false
                        
                        mid1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid1PlayingView.isHidden = false
                }
                mid1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid1NameLabel.text = sortName
                }
                //                  aBall1NameLabel.text = player.name ?? ""
                aMid1PointLabel.text = "\(player.credit ?? "") cr."
                aMid1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    
                    aMid1CaptainLabel.isHidden = false
                    aMid1CaptainLabel.text = "SK"
                    aMid1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aMid1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aMid1CaptainLabel.isHidden = false
                    aMid1CaptainLabel.text = "K"
                    aMid1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
            case 1:
                midStackView.spacing = 100
                if player.team == "team1" {
                    aMidView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView2.backgroundColor = .black
                    aMid2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid2PlayingView.isHidden = false
                        
                        mid2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid2PlayingView.isHidden = false
                }
                mid2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid2NameLabel.text = sortName
                }
                //                  aBall2NameLabel.text = player.name ?? ""
                aMid2PointLabel.text = "\(player.credit ?? "") cr."
                aMid2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aMid2CaptainLabel.isHidden = false
                    aMid2CaptainLabel.text = "SK"
                    aMid2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aMid2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aMid2CaptainLabel.isHidden = false
                    aMid2CaptainLabel.text = "K"
                    aMid2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                  if aBall2ImageView == nil {
                    //                     aBall2ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                }
            //                }
            case 2:
                midStackView.spacing = 80
                if player.team == "team1" {
                    aMidView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView3.backgroundColor = .black
                    aMid3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid3PlayingView.isHidden = false
                        
                        mid3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid3PlayingView.isHidden = false
                }
                mid3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid3NameLabel.text = sortName
                }
                //                  aBall3NameLabel.text = player.name ?? ""
                aMid3PointLabel.text = "\(player.credit ?? "") cr."
                aMid3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aMid3CaptainLabel.isHidden = false
                    aMid3CaptainLabel.text = "SK"
                     aMid3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aMid3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aMid3CaptainLabel.isHidden = false
                    aMid3CaptainLabel.text = "K"
                    aMid3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid3ImageView?.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aBall3ImageView == nil {
                    //                                        aBall3ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                    //                                     }
                }
            case 3:
                midStackView.spacing = 50
                if player.team == "team1" {
                    aMidView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView4.backgroundColor = .black
                    aMid4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid4PlayingView.isHidden = false
                        
                        mid4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid4PlayingView.isHidden = false
                }
                mid4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid4NameLabel.text = sortName
                }
                aMid4PointLabel.text = "\(player.credit ?? "") cr."
                aMid4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aMid4CaptainLabel.isHidden = false
                    aMid4CaptainLabel.text = "SK"
                    aMid4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aMid4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aMid4CaptainLabel.isHidden = false
                    aMid4CaptainLabel.text = "K"
                    aMid4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    amid4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                  if aBall4ImageView == nil {
                    //                     aBall4ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                }
            //                }
            case 4:
                midStackView.spacing = 20
                if player.team == "team1" {
                    aMidView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView5.backgroundColor = .black
                    aMid5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid5PlayingView.isHidden = false
                        
                        mid5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid5PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid5PlayingView.isHidden = false
                }
                mid5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid5NameLabel.text = sortName
                }
                
                aMid5PointLabel.text = "\(player.credit ?? "") cr."
                aMid5ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aMid5CaptainLabel.isHidden = false
                    aMid5CaptainLabel.text = "SK"
                      aMid5CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                        aMid5CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aMid5CaptainLabel.isHidden = false
                    aMid5CaptainLabel.text = "K"
                    aMid5CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            case 5:
                midStackView.spacing = 10
                if player.team == "team1" {
                    aMidView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView6.backgroundColor = .black
                    aMid6NameLabel.backgroundColor = .black
                }
                mid6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid6NameLabel.text = sortName
                }
                
                aMid6PointLabel.text = "\(player.credit ?? "") cr."
                aMid6ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aMid6CaptainLabel.isHidden = false
                    aMid6CaptainLabel.text = "SK"
                    aMid6CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                           aMid6CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aMid6CaptainLabel.isHidden = false
                    aMid6CaptainLabel.text = "K"
                    aMid6CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            default:
                break
            }
        }
    }
    fileprivate func setFwdDataList() {
        for (index,player) in fwdArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aForwordView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView1.backgroundColor = .black
                    aFwd1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        fowrd1PlayingView.isHidden = false
                        
                        fowrd1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        fowrd1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        fowrd1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    fowrd1PlayingView.isHidden = false
                }
                fwd1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aFwd1NameLabel.text = sortName
                }
                //                  aAR1NameLabel.text = player.name ?? ""
                aFwd1PointLabel.text = "\(player.credit ?? "") cr."
                aFwd1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aFwd1CaptainLabel.isHidden = false
                    aFwd1CaptainLabel.text = "SK"
                    aFwd1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aFwd1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aFwd1CaptainLabel.isHidden = false
                    aFwd1CaptainLabel.text = "K"
                   aFwd1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd1ImageView?.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aAR1ImageView == nil {
                    //                        aAR1ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                    //                    }
                }
            case 1:
                fwdStackView.spacing = 100
                if player.team == "team1" {
                    aForwordView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView2.backgroundColor = .black
                    aFwd2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        forword2PlayingView.isHidden = false
                        
                        forword2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        forword2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        forword2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    forword2PlayingView.isHidden = false
                }
                fwd2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aFwd2NameLabel.text = sortName
                }
                
                aFwd2PointLabel.text = "\(player.credit ?? "") cr."
                aFwd2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if  temp == self.captainID {
                    aFwd2CaptainLabel.isHidden = false
                    aFwd2CaptainLabel.text = "SK"
                    aFwd2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aFwd2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aFwd2CaptainLabel.isHidden = false
                    aFwd2CaptainLabel.text = "K"
                    aFwd2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aAR2ImageView == nil {
                    //                        aAR2ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                    //                    }
                }
                
            case 2:
                
                fwdStackView.spacing = 80
                if player.team == "team1" {
                    aForwordView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView3.backgroundColor = .black
                    aFwd3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        forword3PlayingView.isHidden = false
                        
                        forword3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        forword3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        forword3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    forword3PlayingView.isHidden = false
                }
                fwd3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aFwd3NameLabel.text = sortName
                }
                //                  aAR3NameLabel.text = player.name ?? ""
                aFwd3PointLabel.text = "\(player.credit ?? "") cr."
                aFwd3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aFwd3CaptainLabel.isHidden = false
                    aFwd3CaptainLabel.text = "SK"
                                       aFwd3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aFwd3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)

                }
                if temp == viceCaptianID {
                    aFwd3CaptainLabel.isHidden = false
                    aFwd3CaptainLabel.text = "K"
                     aFwd3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
               aFwd3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aAR3ImageView == nil {
                    //                        aR4ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                }
                //                  }
                
            default:
                break
            }
        }
    }
    fileprivate func setDefDataList() {
        for (index,player) in defArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aDefView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView1.backgroundColor = .black
                    aDef1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def1PlayingView.isHidden = false
                        
                        def1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def1PlayingView.isHidden = false
                }
                def1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef1NameLabel.text = sortName
                }
                //                aBat1NameLabel.text = player.name ?? ""
                aDef1PointLabel.text = "\(player.credit ?? "") cr."
                aDef1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                
                if temp ==  self.captainID {
                    aDef1CaptainLabel.isHidden = false
                    aDef1CaptainLabel.text = "SK"
                     aDef1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                                         aDef1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp ==  self.viceCaptianID{
                    aDef1CaptainLabel.isHidden = false
                    aDef1CaptainLabel.text = "K"
                    aDef1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                //                if aBat1ImageView.image == nil {
                //                    aBat1ImageView.image = #imageLiteral(resourceName: "1_3")
                //                }
                
            case 1:
                defStackView.spacing = 100
                if player.team == "team1" {
                    aDefView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView2.backgroundColor = .black
                    aDef2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def2PlayingView.isHidden = false
                        
                        def2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def2PlayingView.isHidden = false
                }
                def2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef2NameLabel.text = sortName
                }
                //                aBat2NameLabel.text = player.name ?? ""
                aDef2PointLabel.text = "\(player.credit ?? "") cr."
                aDef2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aDef2CaptainLabel.isHidden = false
                    aDef2CaptainLabel.text = "v"
                   aDef2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aDef2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aDef2CaptainLabel.isHidden = false
                    aDef2CaptainLabel.text = "K"
                    aDef2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                //                if aBat2ImageView.image == nil {
                //                    aBat2ImageView.image = #imageLiteral(resourceName: "1_3")
            //                }
            case 2:
                defStackView.spacing = 80
                if player.team == "team1" {
                    aDefView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView3.backgroundColor = .black
                    aDef3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def3PlayingView.isHidden = false
                        
                        def3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def3PlayingView.isHidden = false
                }
                def3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef3NameLabel.text = sortName
                }
                
                aDef3PointLabel.text = "\(player.credit ?? "") cr."
                aDef3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aDef3CaptainLabel.isHidden = false
                    aDef3CaptainLabel.text = "SK"
                    aDef3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aDef3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aDef3CaptainLabel.isHidden = false
                    aDef3CaptainLabel.text = "K"
                    aDef3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 3:
                defStackView.spacing = 50
                if player.team == "team1" {
                    aDefView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView4.backgroundColor = .black
                    aDef4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def4PlayingView.isHidden = false
                        
                        def4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def4PlayingView.isHidden = false
                }
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef4NameLabel.text = sortName
                }
                def4_Player_ID = player.id ?? 0
                //                aBat4NameLabel.text = player.name ?? ""
                aDef4PointLabel.text = "\(player.credit ?? "") cr."
                aDef4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aDef4CaptainLabel.isHidden = false
                    aDef4CaptainLabel.text = "SK"
                     aDef4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                                          aDef4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aDef4CaptainLabel.isHidden = false
                    aDef4CaptainLabel.text = "K"
                  aDef4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 4:
                defStackView.spacing = 20
                if player.team == "team1" {
                    aDefView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView5.backgroundColor = .black
                    aDef5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def5PlayingView.isHidden = false
                        
                        def5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def5PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def5PlayingView.isHidden = false
                }
                def5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef5NameLabel.text = sortName
                }
                //                aBat5NameLabel.text = player.name ?? ""
                aDef5PointLabel.text = "\(player.credit ?? "") cr."
                aDef5ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aDef5CaptainLabel.isHidden = false
                    aDef5CaptainLabel.text = "SK"
                   aDef5CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aDef5CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aDef5CaptainLabel.isHidden = false
                    aDef5CaptainLabel.text = "K"
                    aDef5CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 5:
                defStackView.spacing = 10
                if player.team == "team1" {
                    aDefView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView6.backgroundColor = .black
                    aDef6NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def6PlayingView.isHidden = false
                        
                        def6PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def6PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def6PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def6PlayingView.isHidden = false
                }
                def6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef6NameLabel.text = sortName
                }
                //                aBat5NameLabel.text = player.name ?? ""
                aDef6PointLabel.text = "\(player.credit ?? "") cr."
                aDef6ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aDef6CaptainLabel.isHidden = false
                    aDef6CaptainLabel.text = "SK"
                      aDef6CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                      aDef6CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if temp == self.viceCaptianID {
                    aDef6CaptainLabel.isHidden = false
                    aDef6CaptainLabel.text = "K"
                    aDef6CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            default:
                break
            }
        }
    }
    fileprivate func setGKData() {
        for player in gkArray {
            if player.team == "team1" {
                aGoalKeeperView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                aGKNameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
            } else {
                aGoalKeeperView1.backgroundColor = .black
                aGKNameLabel.backgroundColor = .black
            }
            aGKNameLabel.isHidden = false
            aGKPointLabel.isHidden = false
            aGKImageView.isHidden = false
            gk1_Player_ID = player.id ?? 0
            let nameFormatter = PersonNameComponentsFormatter()
            if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                
                let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                aGKNameLabel.text = sortName
            }
            if player.is_playing_show == 1 {
                if player.is_playing == 1 {
                    goalkeeperPlayingView.isHidden = false
                    goalkeeperPlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                }
                else {
                    goalkeeperPlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                    goalkeeperPlayingView.isHidden = false
                }
                
            }
            else {
                goalkeeperPlayingView.isHidden = false
            }
            aGKPointLabel.text = "\(player.credit ?? "") cr."
            aGKContainerView.isHidden = false
            
            if player.captain == 1 {
                
                aGKCaptainLabel.isHidden = false
                aGKCaptainLabel.text = "SK"
                 aGKCaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                                     aGKCaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
            }
            if player.vicecaptain == 1 {
                aGKCaptainLabel.isHidden = false
                aGKCaptainLabel.text = "K"
                aGKCaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                aGKCaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
            }
            if let imagePath = player.image {
                let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                let imageUrl = URL(string: urlString1 ?? "")
                aGKImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                }
            }
        }
    }
    
    fileprivate func setDefData() {
        for (index,player) in defenderArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aDefView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView1.backgroundColor = .black
                    aDef1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def1PlayingView.isHidden = false
                        
                        def1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def1PlayingView.isHidden = false
                }
                def1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef1NameLabel.text = sortName
                }
                //                aBat1NameLabel.text = player.name ?? ""
                aDef1PointLabel.text = "\(player.credit ?? "") cr."
                aDef1ContainerView.isHidden = false
                if player.captain == 1 {
                    aDef1CaptainLabel.isHidden = false
                    aDef1CaptainLabel.text = "SK"
                    aDef1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aDef1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                    
                }
                if player.vicecaptain == 1 {
                    aDef1CaptainLabel.isHidden = false
                    aDef1CaptainLabel.text = "K"
                    aDef1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                defStackView.spacing = 100
                if player.team == "team1" {
                    aDefView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView2.backgroundColor = .black
                    aDef2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def1PlayingView.isHidden = false
                        
                        def2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def2PlayingView.isHidden = false
                }
                def2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef2NameLabel.text = sortName
                }
                
                aDef2PointLabel.text = "\(player.credit ?? "") cr."
                aDef2ContainerView.isHidden = false
                if player.captain == 1 {
                    aDef2CaptainLabel.isHidden = false
                    aDef2CaptainLabel.text = "SK"
                    aDef2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aDef2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aDef2CaptainLabel.isHidden = false
                    aDef2CaptainLabel.text = "K"
                     aDef2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                defStackView.spacing = 80
                if player.team == "team1" {
                    aDefView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView3.backgroundColor = .black
                    aDef3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def3PlayingView.isHidden = false
                        
                        def3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def3PlayingView.isHidden = false
                }
                def3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef3NameLabel.text = sortName
                }
                
                aDef3PointLabel.text = "\(player.credit ?? "") cr."
                aDef3ContainerView.isHidden = false
                if player.captain == 1 {
                    aDef3CaptainLabel.isHidden = false
                    aDef3CaptainLabel.text = "SK"
                     aDef3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                                          aDef3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aDef3CaptainLabel.isHidden = false
                    aDef3CaptainLabel.text = "K"
                    aDef3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                defStackView.spacing = 50
                if player.team == "team1" {
                    aDefView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView4.backgroundColor = .black
                    aDef4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def4PlayingView.isHidden = false
                        
                        def4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def4PlayingView.isHidden = false
                }
                def4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef4NameLabel.text = sortName
                }
                //                aBat4NameLabel.text = player.name ?? ""
                aDef4PointLabel.text = "\(player.credit ?? "") cr."
                aDef4ContainerView.isHidden = false
                if player.captain == 1 {
                    aDef4CaptainLabel.isHidden = false
                    aDef4CaptainLabel.text = "SK"
                   aDef4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aDef4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aDef4CaptainLabel.isHidden = false
                    aDef4CaptainLabel.text = "K"
                     aDef4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                        aDef4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                defStackView.spacing = 20
                if player.team == "team1" {
                    aDefView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView5.backgroundColor = .black
                    aDef5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def5PlayingView.isHidden = false
                        
                        def5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def5PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def5PlayingView.isHidden = false
                }
                def5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef5NameLabel.text = sortName
                }
                
                aDef5PointLabel.text = "\(player.credit ?? "") cr."
                aDef5ContainerView.isHidden = false
                if player.captain == 1 {
                    aDef5CaptainLabel.isHidden = false
                    aDef5CaptainLabel.text = "SK"
                     aDef5CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                      aDef5CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aDef5CaptainLabel.isHidden = false
                    aDef5CaptainLabel.text = "K"
                    aDef5CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                defStackView.spacing = 10
                if player.team == "team1" {
                    aDefView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aDef6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aDefView6.backgroundColor = .black
                    aDef6NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        def6PlayingView.isHidden = false
                        
                        def6PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        def6PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        def6PlayingView.isHidden = false
                    }
                    
                }
                else {
                    def6PlayingView.isHidden = false
                }
                def6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aDef6NameLabel.text = sortName
                }
                
                aDef6PointLabel.text = "\(player.credit ?? "") cr."
                aDef6ContainerView.isHidden = false
                if player.captain == 1 {
                    aDef6CaptainLabel.isHidden = false
                    aDef6CaptainLabel.text = "SK"
                    aDef6CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aDef6CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aDef6CaptainLabel.isHidden = false
                    aDef6CaptainLabel.text = "K"
                    aDef6CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aDef6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aDef5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            default:
                break
            }
        }
    }
    
    fileprivate func setFwdData() {
        for (index,player) in fwdArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aForwordView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView1.backgroundColor = .black
                    aFwd1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        fowrd1PlayingView.isHidden = false
                        
                        fowrd1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        fowrd1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        fowrd1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    fowrd1PlayingView.isHidden = false
                }
                fwd1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aFwd1NameLabel.text = sortName
                }
                
                //                aAR1NameLabel.text = player.name ?? ""
                aFwd1PointLabel.text = "\(player.credit ?? "") cr."
                aFwd1ContainerView.isHidden = false
                if player.captain == 1 {
                    aFwd1CaptainLabel.isHidden = false
                    aFwd1CaptainLabel.text = "SK"
                   aFwd1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aFwd1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aFwd1CaptainLabel.isHidden = false
                    aFwd1CaptainLabel.text = "K"
                    aFwd1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                fwdStackView.spacing = 100
                if player.team == "team1" {
                    aForwordView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView2.backgroundColor = .black
                    aFwd2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        forword2PlayingView.isHidden = false
                        
                        forword2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        forword2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        forword2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    forword2PlayingView.isHidden = false
                }
                fwd2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aFwd2NameLabel.text = sortName
                }
                //                aAR2NameLabel.text = player.name ?? ""
                aFwd2PointLabel.text = "\(player.credit ?? "") cr."
                aFwd2ContainerView.isHidden = false
                if player.captain == 1 {
                    aFwd2CaptainLabel.isHidden = false
                    aFwd2CaptainLabel.text = "SK"
                    aFwd2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aFwd2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aFwd2CaptainLabel.isHidden = false
                    aFwd2CaptainLabel.text = "K"
                    aFwd2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                fwdStackView.spacing = 80
                if player.team == "team1" {
                    aForwordView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView3.backgroundColor = .black
                    aFwd3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        forword3PlayingView.isHidden = false
                        
                        forword3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        forword3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        forword3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    forword3PlayingView.isHidden = false
                }
                fwd3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aFwd3NameLabel.text = sortName
                }
                
                aFwd3PointLabel.text = "\(player.credit ?? "") cr."
                aFwd3ContainerView.isHidden = false
                if player.captain == 1 {
                    aFwd3CaptainLabel.isHidden = false
                    aFwd3CaptainLabel.text = "SK"
                    aFwd3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                                          aFwd3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aFwd3CaptainLabel.isHidden = false
                    aFwd3CaptainLabel.text = "K"
                    aFwd3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 3:
                fwdStackView.spacing = 50
                if player.team == "team1" {
                    aForwordView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aFwd4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aForwordView4.backgroundColor = .black
                    aFwd4NameLabel.backgroundColor = .black
                }
                fwd4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aFwd4NameLabel.text = sortName
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        forword4PlayingView.isHidden = false
                        
                        forword4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        forword4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        forword4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    forword4PlayingView.isHidden = false
                }
                aFwd4PointLabel.text = "\(player.credit ?? "") cr."
                aFwd4ContainerView.isHidden = false
                if player.captain == 1 {
                    aFwd4CaptainLabel.isHidden = false
                    aFwd4CaptainLabel.text = "SK"
                    aFwd4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                                                             aFwd4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aFwd4CaptainLabel.isHidden = false
                    aFwd4CaptainLabel.text = "K"
                    aFwd4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aFwd4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aFwd4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            default:
                break
            }
        }
    }
    
    fileprivate func setMidData() {
        for (index,player) in midRFielderArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    aMidView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView1.backgroundColor = .black
                    aMid1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid1PlayingView.isHidden = false
                        
                        mid1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid1PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid1PlayingView.isHidden = false
                }
                mid1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid1NameLabel.text = sortName
                }
                //                aBall1NameLabel.text = player.name ?? ""
                aMid1PointLabel.text = "\(player.credit ?? "") cr."
                aMid1ContainerView.isHidden = false
                if player.captain == 1 {
                    aMid1CaptainLabel.isHidden = false
                    aMid1CaptainLabel.text = "SK"
                    aMid1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aMid1CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aMid1CaptainLabel.isHidden = false
                    aMid1CaptainLabel.text = "K"
                     aMid1CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                midStackView.spacing = 100
                if player.team == "team1" {
                    aMidView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView2.backgroundColor = .black
                    aMid2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid2PlayingView.isHidden = false
                        
                        mid2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid2PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid2PlayingView.isHidden = false
                }
                mid2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid2NameLabel.text = sortName
                }
                //                aBall2NameLabel.text = player.name ?? ""
                aMid2PointLabel.text = "\(player.credit ?? "") cr."
                aMid2ContainerView.isHidden = false
                if player.captain == 1 {
                    aMid2CaptainLabel.isHidden = false
                    aMid2CaptainLabel.text = "SK"
                   aMid2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aMid2CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aMid2CaptainLabel.isHidden = false
                    aMid2CaptainLabel.text = "K"
                     aMid2CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                midStackView.spacing = 80
                if player.team == "team1" {
                    aMidView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView3.backgroundColor = .black
                    aMid3NameLabel.backgroundColor = .black
                }
                mid3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid3NameLabel.text = sortName
                }
                //                aBall3NameLabel.text = player.name ?? ""
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid3PlayingView.isHidden = false
                        
                        mid3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid3PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid3PlayingView.isHidden = false
                }
                aMid3PointLabel.text = "\(player.credit ?? "") cr."
                aMid3ContainerView.isHidden = false
                if player.captain == 1 {
                    aMid3CaptainLabel.isHidden = false
                    aMid3CaptainLabel.text = "SK"
                    aMid3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aMid3CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aMid3CaptainLabel.isHidden = false
                    aMid3CaptainLabel.text = "K"
                   aMid3CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                midStackView.spacing = 50
                if player.team == "team1" {
                    aMidView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView4.backgroundColor = .black
                    aMid4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid4PlayingView.isHidden = false
                        
                        mid4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid4PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid4PlayingView.isHidden = false
                }
                mid4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid4NameLabel.text = sortName
                }
                
                aMid4PointLabel.text = "\(player.credit ?? "") cr."
                aMid4ContainerView.isHidden = false
                if player.captain == 1 {
                    aMid4CaptainLabel.isHidden = false
                    aMid4CaptainLabel.text = "SK"
                    aMid4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                                          aMid4CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aMid4CaptainLabel.isHidden = false
                    aMid4CaptainLabel.text = "K"
                    aMid4CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    amid4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                midStackView.spacing = 20
                if player.team == "team1" {
                    aMidView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView5.backgroundColor = .black
                    aMid5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        mid5PlayingView.isHidden = false
                        
                        mid5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        mid5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        mid5PlayingView.isHidden = false
                    }
                    
                }
                else {
                    mid5PlayingView.isHidden = false
                }
                mid5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid5NameLabel.text = sortName
                }
                
                aMid5PointLabel.text = "\(player.credit ?? "") cr."
                aMid5ContainerView.isHidden = false
                if player.captain == 1 {
                    aMid5CaptainLabel.isHidden = false
                    aMid5CaptainLabel.text = "SK"
                   aMid5CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    aMid5CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aMid5CaptainLabel.isHidden = false
                    aMid5CaptainLabel.text = "K"
                    aMid5CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                midStackView.spacing = 10
                if player.team == "team1" {
                    aMidView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aMid6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    aMidView6.backgroundColor = .black
                    aMid6NameLabel.backgroundColor = .black
                }
                mid6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aMid6NameLabel.text = sortName
                }
                
                aMid6PointLabel.text = "\(player.credit ?? "") cr."
                aMid6ContainerView.isHidden = false
                if player.captain == 1 {
                    aMid6CaptainLabel.isHidden = false
                    aMid6CaptainLabel.text = "SK"
                   aMid6CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                                       aMid6CaptainLabel.backgroundColor = UIColor(red: 194, green: 40, blue: 45)
                }
                if player.vicecaptain == 1 {
                    aMid6CaptainLabel.isHidden = false
                    aMid6CaptainLabel.text = "K"
                    aMid6CaptainLabel.borderColor = UIColor(red: 49, green: 139, blue: 22)
                    aMid6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aMid6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
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
        delegate?.checkComingFromPReview(check: true)
        self.navigationController?.popViewController(animated: true)
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
    
    
    func openPlayerInfoVC(id: Int) {
        //            openViewController(controller: PlayerStaticsViewController.self, storyBoard: .homeStoryBoard) { (vc) in
        //    //            vc.teamId = self.teamId
        //                vc.matchKey = self.matchKey
        //                vc.playerID = id
        //            }
        
    }
}
