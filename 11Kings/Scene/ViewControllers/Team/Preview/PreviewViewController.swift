//
//  PreviewViewController.swift
//  Club11
//
//  Created by Developer on 08/06/19.
//

import UIKit
import SwiftyJSON

protocol sendPreviewDetail {
    func checkComingFromPReview (check :Bool)
}
class PreviewViewController: BaseClass {
    
    @IBOutlet weak var awicketkeeperStackView: UIStackView!
    @IBOutlet weak var ballStackView: UIStackView!
    @IBOutlet weak var allRounderStackview: UIStackView!
    @IBOutlet weak var batStackView: UIStackView!
    @IBOutlet weak var batView3: UIView!
    @IBOutlet weak var batView4: UIView!
    @IBOutlet weak var batView5: UIView!
    @IBOutlet weak var batView2: UIView!
    @IBOutlet weak var batView1: UIView!
    @IBOutlet weak var batView6: UIView!
    
    @IBOutlet weak var bat6PlayingView: UIView!
    @IBOutlet weak var bat5PlayingView: UIView!
    @IBOutlet weak var bat4PlayingView: UIView!
    @IBOutlet weak var bat3PlayingView: UIView!
    @IBOutlet weak var bat2PlayingView: UIView!
    @IBOutlet weak var bat1PlayingView: UIView!
    @IBOutlet weak var wkPlayingView: UIView!
    @IBOutlet weak var wkView1: UIView!
    
    @IBOutlet weak var wk2PlayingView: UIView!
    @IBOutlet weak var ball6PlayingView: UIView!
    @IBOutlet weak var ball1PlayingView: UIView!
    @IBOutlet weak var ball5PlayingView: UIView!
    @IBOutlet weak var ball4PlayingView: UIView!
    @IBOutlet weak var ball3PlayingView: UIView!
    @IBOutlet weak var ball2PlayingView: UIView!
    @IBOutlet weak var all6PlayingView: UIView!
    @IBOutlet weak var all5PlayingView: UIView!
    @IBOutlet weak var all4PlayingView: UIView!
    @IBOutlet weak var all3PlayingView: UIView!
    @IBOutlet weak var all2PlayingView: UIView!
    @IBOutlet weak var all1PlayingView: UIView!
    @IBOutlet weak var allView1: UIView!
    @IBOutlet weak var allView2: UIView!
    @IBOutlet weak var allView3: UIView!
    @IBOutlet weak var allView4: UIView!
    @IBOutlet weak var allView5: UIView!
    @IBOutlet weak var allView6: UIView!
    
    @IBOutlet weak var ballView2: UIView!
    @IBOutlet weak var ballView1: UIView!
    @IBOutlet weak var ballView3: UIView!
    @IBOutlet weak var ballView4: UIView!
    @IBOutlet weak var ballView5: UIView!
    @IBOutlet weak var ballView6: UIView!
    var getContestDetail:GetMatchDetails?
    var contestLiveDatas:MyContestLiveLeagues?
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var EditBtn: UIButton!
    @IBOutlet weak var EditImageVew: UIImageView!
    @IBOutlet weak var editLbl: UILabel!
    var teamName:String?
    @IBOutlet weak var teamLblName: UILabel!
    
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
    @IBOutlet weak var aBat6CaptainLabel: UILabel!
    @IBOutlet weak var aBat6ContainerView: UIView!
    @IBOutlet weak var aBat6ImageView: UIImageView!
    @IBOutlet weak var aBat6NameLabel: UILabel!
    @IBOutlet weak var aBat6PointLabel: UILabel!
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
    @IBOutlet weak var aR4NameLabel: UILabel!
    @IBOutlet weak var aR4ImageView: UIImageView!
    @IBOutlet weak var aR4CaptainLbl: UILabel!
    @IBOutlet weak var aR4PointLable: UILabel!
    @IBOutlet weak var aR4ContainerView: UIView!
    @IBOutlet weak var aR5NameLabel: UILabel!
    @IBOutlet weak var aR5ImageView: UIImageView!
    @IBOutlet weak var aR5CaptainLbl: UILabel!
    @IBOutlet weak var aR5PointLable: UILabel!
    @IBOutlet weak var aR5ContainerView: UIView!
    @IBOutlet weak var aR6NameLabel: UILabel!
    @IBOutlet weak var aR6ImageView: UIImageView!
    @IBOutlet weak var aR6CaptainLbl: UILabel!
    @IBOutlet weak var aR6PointLable: UILabel!
    @IBOutlet weak var aR6ContainerView: UIView!
    
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
    @IBOutlet weak var aBall6CaptainLabel: UILabel!
    @IBOutlet weak var aBall6ContainerView: UIView!
    @IBOutlet weak var aBall6ImageView: UIImageView!
    @IBOutlet weak var aBall6NameLabel: UILabel!
    @IBOutlet weak var aBall6PointLabel: UILabel!
    var delegate:sendPreviewDetail?
    var getTeamResponse:MyTeamResponses?
    var isComingFromMyteam = false
    var isFromEditClone = false
    var teamID  = 0
    //   @IBOutlet weak var aball6ImageView: UIImageView!
    //    @IBOutlet weak var aBall6NameLb: UILabel!
    //
    //    @IBOutlet weak var aBall6CaptainLbl: UILabel!
    //    @IBOutlet weak var aBat6PointLbl: UILabel!
    //    @IBOutlet weak var aBat6CaptianLbl: UILabel!
    //
    //    @IBOutlet weak var aBat6NameLbl: UILabel!
    //    @IBOutlet weak var aBat6ImageView: UIImageView!
    //    @IBOutlet weak var aBat6ContainerView: UIView!
    //    @IBOutlet weak var aBall6PointLbl: UILabel!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    //  @IBOutlet weak var aRefreshButton: UIButton!
    
    @IBOutlet weak var aWk2ImageView: UIImageView!
    @IBOutlet weak var awk2CaptainLbl: UILabel!
    @IBOutlet weak var awk1ContainerView: UIView!
    
    //    @IBOutlet weak var awk3CaptianLbl: UILabel!
    //    @IBOutlet weak var awk3PointLbl: UILabel!
    //    @IBOutlet weak var awk3NameLbl: UILabel!
    //    @IBOutlet weak var awk3ImageView: UIImageView!
    //    @IBOutlet weak var awk3ContainerView: UIView!
    @IBOutlet weak var awkCaptainLbl: UILabel!
    @IBOutlet weak var awk1PointLbl: UILabel!
    @IBOutlet weak var awk1NameLbl: UILabel!
    @IBOutlet weak var awk1ImageView: UIImageView!
    @IBOutlet weak var awk2ContainerView: UIView!
    @IBOutlet weak var awk2PointLabel: UILabel!
    @IBOutlet weak var awk2NameLBl: UILabel!
    
    @IBOutlet weak var awk1UIView: UIView!
    @IBOutlet weak var awk2Uiview: UIView!
    var arrayOFSelectedPlayer = [Int]()
    var comingromFromPReview = false
    
    var wk1_Player_ID = 0
    var wk2_Player_ID = 0
    var wk3_Player_ID = 0
    var wk4_Player_ID = 0
    
    
    var bat1_Player_ID = 0
    var bat2_Player_ID = 0
    var bat3_Player_ID = 0
    var bat4_Player_ID = 0
    var bat5_Player_ID = 0
    var bat6_Player_ID = 0
    
    var ar1_Player_ID = 0
    var ar2_Player_ID = 0
    var ar3_Player_ID = 0
    var ar4_Player_ID = 0
    var ar5_Player_ID = 0
    var ar6_Player_ID = 0
    
    var ball1_Player_ID = 0
    var ball2_Player_ID = 0
    var ball3_Player_ID = 0
    var ball4_Player_ID = 0
    var ball5_Player_ID = 0
    var ball6_Player_ID = 0
    
    var wkArrayList = [PlayerListResponses]()
    var batArrayList = [PlayerListResponses]()
    var bowlArrayList = [PlayerListResponses]()
    var allArrayList = [PlayerListResponses]()
    
    var checkEditVc =  false
    var teamInfo: MyTeamResponses?
    var wkArray = [PlayerDetail]()
    var batArray = [PlayerDetail]()
    var bowlArray = [PlayerDetail]()
    var allArray = [PlayerDetail]()
    var wkArrayLeaderboard = [LeaderBoardPlayerDetail]()
    var batArrayLeaderboard = [LeaderBoardPlayerDetail]()
    var bowlArrayLeaderboard = [LeaderBoardPlayerDetail]()
    var allArrayLeaderboard = [LeaderBoardPlayerDetail]()
    var contestData: Any?
    var teamId = 0
    var challengeID = 0
    var isFromLeaderBoard = false
    var isFromCreateTEam = false
    var matchKey = ""
    var selectedIndex = -1
    var captainID:String?
    var viceCaptianID:String?
    var vcID = 0
    var cId = 0
    var c = 0
    var v = 0
    var myTeamsData = [MyTeamResponses]() {
        didSet {
            getTeamInfo()
        }
    }
    var leaderBoardTeamArray :LeaderBoardDetail? {
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
        self.navigationController?.isNavigationBarHidden = true
        //        awk3ContainerView.isHidden = true
        //        awk2ContainerView.isHidden = true
        
        wkPlayingView.layer.cornerRadius = wkPlayingView.frame.size.width/2
        wkPlayingView.clipsToBounds = true
        
        wkPlayingView.layer.borderColor = UIColor.white.cgColor
        wkPlayingView.layer.borderWidth = 5.0
        wk2PlayingView.layer.cornerRadius = wkPlayingView.frame.size.width/2
              wk2PlayingView.clipsToBounds = true
              
              wk2PlayingView.layer.borderColor = UIColor.white.cgColor
              wk2PlayingView.layer.borderWidth = 5.0
        
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
        
        bat5PlayingView.layer.cornerRadius = bat5PlayingView.frame.size.width/2
        bat5PlayingView.clipsToBounds = true
        
        bat5PlayingView.layer.borderColor = UIColor.white.cgColor
        bat5PlayingView.layer.borderWidth = 5.0
        
        bat6PlayingView.layer.cornerRadius = bat6PlayingView.frame.size.width/2
        bat6PlayingView.clipsToBounds = true
        
        bat6PlayingView.layer.borderColor = UIColor.white.cgColor
        bat6PlayingView.layer.borderWidth = 5.0
        
        ball1PlayingView.layer.cornerRadius = ball1PlayingView.frame.size.width/2
        ball1PlayingView.clipsToBounds = true
        
        ball1PlayingView.layer.borderColor = UIColor.white.cgColor
        ball1PlayingView.layer.borderWidth = 5.0
        ball2PlayingView.layer.cornerRadius = ball2PlayingView.frame.size.width/2
        ball2PlayingView.clipsToBounds = true
        
        ball2PlayingView.layer.borderColor = UIColor.white.cgColor
        ball2PlayingView.layer.borderWidth = 5.0
        ball3PlayingView.layer.cornerRadius = ball3PlayingView.frame.size.width/2
        ball3PlayingView.clipsToBounds = true
        
        ball3PlayingView.layer.borderColor = UIColor.white.cgColor
        ball3PlayingView.layer.borderWidth = 5.0
        
        ball4PlayingView.layer.cornerRadius = ball4PlayingView.frame.size.width/2
        ball4PlayingView.clipsToBounds = true
        ball4PlayingView.layer.borderColor = UIColor.white.cgColor
        ball4PlayingView.layer.borderWidth = 5.0
        
        ball5PlayingView.layer.cornerRadius = ball5PlayingView.frame.size.width/2
        ball5PlayingView.clipsToBounds = true
        ball5PlayingView.layer.borderColor = UIColor.white.cgColor
        ball5PlayingView.layer.borderWidth = 5.0
        
        ball6PlayingView.layer.cornerRadius = ball6PlayingView.frame.size.width/2
        ball6PlayingView.clipsToBounds = true
        ball6PlayingView.layer.borderColor = UIColor.white.cgColor
        ball6PlayingView.layer.borderWidth = 5.0
        
        
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
        
        all5PlayingView.layer.cornerRadius = all5PlayingView.frame.size.width/2
        all5PlayingView.clipsToBounds = true
        all5PlayingView.layer.borderColor = UIColor.white.cgColor
        all5PlayingView.layer.borderWidth = 5.0
        
        all6PlayingView.layer.cornerRadius =  all6PlayingView.frame.size.width/2
        all6PlayingView.clipsToBounds = true
        all6PlayingView.layer.borderColor = UIColor.white.cgColor
        all6PlayingView.layer.borderWidth = 5.0
        
        awk1ContainerView.isHidden = true
        awk2ContainerView.isHidden = true
        aAR1ContainerView.isHidden = true
        aAR2ContainerView.isHidden = true
        aAR3ContainerView.isHidden = true
        aR4ContainerView.isHidden = true
        aR5ContainerView.isHidden = true
        aBall5ContainerView.isHidden = true
        aR6ContainerView.isHidden = true
        aBat6ContainerView.isHidden = true
        awk1ContainerView.isHidden = true
        aBat1ContainerView.isHidden = true
        aBat2ContainerView.isHidden = true
        aBat3ContainerView.isHidden = true
        aBat4ContainerView.isHidden = true
        aBat5ContainerView.isHidden = true
        aBall6ContainerView.isHidden = true
        aR6ContainerView.isHidden = true
        //    aBat6ContainerView.isHidden = true
        awk1ImageView.layer.borderWidth = 1.0
        awk1ImageView.layer.masksToBounds = false
        awk1ImageView.layer.borderColor = UIColor.clear.cgColor
        awk1ImageView.layer.cornerRadius = awk1ImageView.frame.size.width/2
        awk1ImageView.clipsToBounds = true
        
        aBall1ContainerView.isHidden = true
        aBall2ContainerView.isHidden = true
        aBall3ContainerView.isHidden = true
        aBall4ContainerView.isHidden = true
        aBall5ContainerView.isHidden = true
        
        awkCaptainLbl.isHidden = true
        awk2CaptainLbl.isHidden = true
        aAR1CaptainLabel.isHidden = true
        aAR2CaptainLabel.isHidden = true
        aAR3CaptainLabel.isHidden = true
        aR4CaptainLbl.isHidden = true
        aR5CaptainLbl.isHidden = true
        aR6CaptainLbl.isHidden = true
        
        aBat1CaptainLabel.isHidden = true
        aBat2CaptainLabel.isHidden = true
        aBat3CaptainLabel.isHidden = true
        aBat4CaptainLabel.isHidden = true
        aBat5CaptainLabel.isHidden = true
        aBall6CaptainLabel.isHidden = true
        //  aBat6CaptianLbl.isHidden = true
        
        aBall1CaptainLabel.isHidden = true
        aBall2CaptainLabel.isHidden = true
        aBall3CaptainLabel.isHidden = true
        aBall4CaptainLabel.isHidden = true
        aBall5CaptainLabel.isHidden = true
        aBat6CaptainLabel.isHidden = true
        //   aBall6CaptainLbl.isHidden = true
        // aWK4CaptainLabel.isHidden = true
        
        //        aWK4CaptainLabel.setCornerRadius(value: 10)
        //        awk3CaptianLbl.setCornerRadius(value: 10)
        //        awk2CaptainLbl.setCornerRadius(value: 10)
        awkCaptainLbl.setCornerRadius(value: 10)
        awk2CaptainLbl.setCornerRadius(value: 10)
        aAR1CaptainLabel.setCornerRadius(value: 10)
        aAR2CaptainLabel.setCornerRadius(value: 10)
        aAR3CaptainLabel.setCornerRadius(value: 10)
        aR4CaptainLbl.setCornerRadius(value: 10)
        aR5CaptainLbl.setCornerRadius(value: 10)
        aR6CaptainLbl.setCornerRadius(value: 10)
        aBat1CaptainLabel.setCornerRadius(value: 10)
        aBat2CaptainLabel.setCornerRadius(value: 10)
        aBat3CaptainLabel.setCornerRadius(value: 10)
        aBat4CaptainLabel.setCornerRadius(value: 10)
        aBat5CaptainLabel.setCornerRadius(value: 10)
        aBat6CaptainLabel.setCornerRadius(value: 10)
        aBall1CaptainLabel.setCornerRadius(value: 10)
        aBall2CaptainLabel.setCornerRadius(value: 10)
        aBall3CaptainLabel.setCornerRadius(value: 10)
        aBall4CaptainLabel.setCornerRadius(value: 10)
        aBall5CaptainLabel.setCornerRadius(value: 10)
        aBall6CaptainLabel.setCornerRadius(value: 10)
    }
    
    fileprivate func setContestData() {
        if let contest = contestData as? GetMatchDetails {
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
                    let teamRespons =  try JSON(data:response as! Data)
                    
                    //                 let list = MyCatagries(json: json)
                    
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
            let parameters = ["user_id": UserDic.value(forKey: "user_id") ?? -1, "challenge": challengeID,"teamid": teamId] as [String : Any]
            
            NetworkManager.post_Request2(urlService: KShowTeamOnGround, param: parameters, head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let jsonData = try JSON(data:response as! Data)
                        let status = jsonData["status"].intValue
                        let message = jsonData["message"].stringValue
                        let result = jsonData["result"]
                        
                        if status == 1 {
                            self.leaderBoardTeamArray = LeaderBoardDetail(json: result)
                            
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
    fileprivate func setupPreviewTeamFromCreate() {
        
        crossBtn.isHidden = false
        editLbl.isHidden = true
        EditBtn.isHidden = true
        EditImageVew.isHidden = true
        for player in APP_DEL.choosedTeamArray {
            if player.role == "bowler" {
                bowlArrayList.append(player)
            }
            if player.role == "batsman" {
                batArrayList.append(player)
            }
            if player.role == "allrounder" {
                allArrayList.append(player)
            }
            if player.role == "keeper" {
                wkArrayList.append(player)
            }
            
        }
        
        
        setWKDataList()
        setBatDataList()
        setAllDataList()
        setBowlDataList()
        
    }
    func getTeamInfo() {
        if isFromLeaderBoard {
            setupPreviewDataForLeaderBoardTeams()
            EditBtn.isHidden = true
            editLbl.isHidden = true
            EditImageVew.isHidden = true
            crossBtn.isHidden = false
            
            // aRefreshButton.isHidden = false
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
    
    
    fileprivate func setupPReviewForMyTeam(data:MyTeamResponses) {
        teamLblName.text = teamName
        crossBtn.isHidden = true
        editLbl.isHidden = false
        EditBtn.isHidden = false
        EditImageVew.isHidden = false
        if let players = data.players {
            for player in players {
                arrayOFSelectedPlayer.append(player.id ?? 0)
                if player.captain == 1 {
                    self.vcID = player.id ?? 0
                }
                if player.vicecaptain == 1 {
                    self.cId = player.id ?? 0
                }
                if player.role == "batsman" {
                    
                    batArray.append(player)
                }
                if player.role == "allrounder" {
                    allArray.append(player)
                }
                if player.role == "bowler" {
                    bowlArray.append(player)
                }
                if player.role == "keeper" {
                    wkArray.append(player)
                }
            }
        }
        setWKData()
        setBowlData()
        setAllData()
        setBatData()
        
        
    }
    fileprivate func setupPReviewForCreate(data:MyTeamResponses) {
        if let players = data.players {
            for player in players {
                
                if player.captain == 1 {
                    
                }
                if player.vicecaptain == 1 {
                    
                }
                if player.role == "batsman" {
                    
                    batArray.append(player)
                }
                if player.role == "allrounder" {
                    allArray.append(player)
                }
                if player.role == "bowler" {
                    bowlArray.append(player)
                }
                if player.role == "keeper" {
                    wkArray.append(player)
                }
            }
        }
        setWKDataList()
        setBowlDataList()
        setAllDataList()
        setBatDataList()
        
    }
    
    fileprivate func setupPreviewDataForLeaderBoardTeams() {
        
        let teamNumber = leaderBoardTeamArray?.teamnumber
        aTeamNameLabel.text = "Team \(teamNumber ?? 0)"
        if let wkData = leaderBoardTeamArray?.keeper {
            wkArrayLeaderboard = wkData
        }
        
        if let allData = leaderBoardTeamArray?.allrounder {
            allArrayLeaderboard = allData
        }
        if let wkData = leaderBoardTeamArray?.bowler {
            bowlArrayLeaderboard = wkData
        }
        if let wkData = leaderBoardTeamArray?.batsman {
            batArrayLeaderboard = wkData
        }
        setWKDataLdrboard()
        setBatDataLeaderBoard()
        setAllDataLeaderBoard()
        setBowlDataLeaderBoard()
    }
    
    fileprivate func setWKDataLdrboard() {
        for (index,player) in wkArrayLeaderboard.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    wkView1.backgroundColor  = UIColor(red: 240, green: 75, blue: 80)
                    
                    awk1NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wkView1.backgroundColor = .black
                    awk1NameLbl.backgroundColor = .black
                }
                self.wkPlayingView.isHidden = true
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
                    awkCaptainLbl.text = "C"
                    awkCaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awkCaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if player.vicecaptain == 1 {
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "K"
                    awkCaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    awkCaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                awicketkeeperStackView.spacing = 100
                if player.team == "team1" {
                    awk2Uiview.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk2NameLBl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    awk2Uiview.backgroundColor = .black
                    awk2NameLBl.backgroundColor = .black
                }
                self.wk2PlayingView.isHidden = true
                wk2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk2NameLBl.text = sortName
                }
                awk2PointLabel.text = "\(player.credit ?? "") cr."
                awk2ContainerView.isHidden = false
                
                if player.captain == 1 {
                    awk2CaptainLbl.isHidden = false
                    awk2CaptainLbl.text = "C"
                    awk2CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    awk2CaptainLbl.isHidden = false
                    awk2CaptainLbl.text = "VC"
                    awk2CaptainLbl.backgroundColor = .black
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aWk2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
                ////
                //
                //                            case 2:
                //                                if player.team == "team1" {
                //                                wkView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                                    awk3NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                                } else {
                //                                    wkView3.backgroundColor = .black
                //                                    awk3NameLbl.backgroundColor = .black
                //                                }
                //                                wk3_Player_ID = player.id ?? 0
                //                                let nameFormatter = PersonNameComponentsFormatter()
                //                                                               if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                //
                //                                                                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                //                                                               awk3NameLbl.text = sortName
                //                                                               }
                ////                                awk3NameLbl.text = player.name ?? ""
                //                                awk3PointLbl.text = "\(player.credit ?? "") cr."
                //                                awk3ContainerView.isHidden = false
                //
                //                                if player.captain == 1 {
                //
                //                                    awk3CaptianLbl.isHidden = false
                //                                    awk3CaptianLbl.text = "C"
                //                                    awk3CaptianLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                                }
                //                                if player.vicecaptain == 1 {
                //                                    awk3CaptianLbl.isHidden = false
                //                                    awk3CaptianLbl.text = "VC"
                //                                    awk3CaptianLbl.backgroundColor = .black
                //                                }
                //                                if let imagePath = player.image {
                //                                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                //
                //                                    let imageUrl = URL(string: urlString1 ?? "")
                //                                    awk3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                //                                    }
                //    //
                //                                    }
                //    //                            }
                //                            case 3:
                //                                if player.team == "team1" {
                //                                    wkView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                                    aWKName4Label.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                                } else {
                //                                    wkView4.backgroundColor = .black
                //                                    aWKName4Label.backgroundColor = .black
                //                                }
                //                                wk4_Player_ID = player.id ?? 0
                //                                let nameFormatter = PersonNameComponentsFormatter()
                //                                                                                              if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                //
                //                                                                                                   let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                //                                                                                              aWKName4Label.text = sortName
                //                                                                                              }
                ////                                aWKName4Label.text = player.name ?? ""
                //                                aWK4PointLabel.text = "\(player.credit ?? "") cr."
                //                                aWK4ContainerView.isHidden = false
                //
                //
                //                                if player.captain == 1 {
                //                                    aWK4CaptainLabel.isHidden = false
                //                                    aWK4CaptainLabel.text = "C"
                //                                    aWK4CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                                }
                //                                if player.vicecaptain == 1{
                //                                    aWK4CaptainLabel.isHidden = false
                //                                    aWK4CaptainLabel.text = "VC"
                //                                    aWK4CaptainLabel.backgroundColor = .black
                //                                }
                //                                if let imagePath = player.image {
                //                                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                //
                //                                    let imageUrl = URL(string: urlString1 ?? "")
                //                                    aWK4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                //                                    }
                //                                }
            //
            default:break
                
            }
        }
    }
    
    fileprivate func setBatDataLeaderBoard() {
        for (index,player) in batArrayLeaderboard.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    batView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView1.backgroundColor = .black
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
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "C"
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    
                }
                if player.vicecaptain == 1 {
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "K"
                    aBat1CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
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
                    batView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView2.backgroundColor = .black
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
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "C"
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                    
                }
                if player.vicecaptain == 1 {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "K"
                    aBat2CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                batStackView.spacing = 80
                if player.team == "team1" {
                    batView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView3.backgroundColor = .black
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
                    aBat3CaptainLabel.text = "C"
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat3CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if player.vicecaptain == 1 {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "K"
                    aBat3CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                batStackView.spacing = 50
                if player.team == "team1" {
                    batView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView4.backgroundColor = .black
                    aBat4NameLabel.backgroundColor = .black
                }
                
                self.bat4PlayingView.isHidden = true
                bat4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat4NameLabel.text = sortName
                }
                //                    aBat4NameLabel.text = player.name ?? ""
                aBat4PointLabel.text = "\(player.credit ?? "") cr."
                aBat4ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "C"
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat4CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if player.vicecaptain == 1 {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "K"
                    aBat4CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                batStackView.spacing = 20
                if player.team == "team1" {
                    batView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView5.backgroundColor = .black
                    aBat5NameLabel.backgroundColor = .black
                }
                self.bat5PlayingView.isHidden = true
                bat5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat5NameLabel.text = sortName
                }
                //                    aBat5NameLabel.text = player.name ?? ""
                aBat5PointLabel.text = "\(player.credit ?? "") cr."
                aBat5ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "C"
                    aBat5CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat5CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if player.vicecaptain == 1 {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "K"
                    aBat5CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                batStackView.spacing = 10
                if player.team == "team1" {
                    batView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView6.backgroundColor = .black
                    aBat6NameLabel.backgroundColor = .black
                }
                self.bat6PlayingView.isHidden = true
                bat6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat6NameLabel.text = sortName
                }
                //                    aBat5NameLabel.text = player.name ?? ""
                aBat6PointLabel.text = "\(player.credit ?? "") cr."
                aBat6ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat6CaptainLabel.isHidden = false
                    aBat6CaptainLabel.text = "C"
                    aBat6CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    //                    aBat6NameLabel.borderWidth = 2
                    aBat6CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if player.vicecaptain == 1 {
                    aBat6CaptainLabel.isHidden = false
                    aBat6CaptainLabel.text = "K"
                    aBat6CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            default:
                break
            }
        }
    }
    
    fileprivate func setAllDataLeaderBoard() {
        for (index,player) in allArrayLeaderboard.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    allView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView1.backgroundColor = .black
                    aAR1NameLabel.backgroundColor = .black
                }
                ar1_Player_ID = player.id ?? 0
                all1PlayingView.isHidden = true
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR1NameLabel.text = sortName
                }
                //                    aAR1NameLabel.text = player.name ?? ""
                aAR1PointLabel.text = "\(player.credit ?? "") cr."
                aAR1ContainerView.isHidden = false
                if player.captain == 1 {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "C"
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR1CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if player.vicecaptain == 1 {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "K"
                    aAR1CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                allRounderStackview.spacing = 100
                if player.team == "team1" {
                    allView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView2.backgroundColor = .black
                    aAR2NameLabel.backgroundColor = .black
                }
                all2PlayingView.isHidden = true
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
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "C"
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR2CaptainLabel.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if player.vicecaptain == 1 {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "K"
                    aAR2CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                allRounderStackview.spacing = 80
                if player.team == "team1" {
                    allView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView3.backgroundColor = .black
                    aAR3NameLabel.backgroundColor = .black
                }
                all3PlayingView.isHidden = true
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
                    aAR3CaptainLabel.text = "C"
                    aAR3CaptainLabel.borderColor =   UIColor(red: 115, green: 16, blue: 18)
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                
                if player.vicecaptain == 1 {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "K"
                    aAR3CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                    
                }
                
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                allRounderStackview.spacing = 50
                if player.team == "team1" {
                    allView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aR4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView4.backgroundColor = .black
                    aR4NameLabel.backgroundColor = .black
                }
                 all4PlayingView.isHidden = true
                ar4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aR4NameLabel.text = sortName
                }
                //                          aAR1NameLabel.text = player.name ?? ""
                aR4PointLable.text = "\(player.credit ?? "0") cr."
                aR4ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aR4CaptainLbl.isHidden = false
                    aR4CaptainLbl.text = "C"
                    aR4CaptainLbl.borderColor =   UIColor(red: 115, green: 16, blue: 18)
                    aR4CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if  player.vicecaptain == 1  {
                    aR4CaptainLbl.isHidden = false
                    aR4CaptainLbl.text = "K"
                    
                    aR4CaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aR4CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                    
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aR4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                allRounderStackview.spacing = 20
                if player.team == "team1" {
                    allView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aR5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView5.backgroundColor = .black
                    aR5NameLabel.backgroundColor = .black
                }
                 all5PlayingView.isHidden = true
                ar5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aR5NameLabel.text = sortName
                }
                
                //                          aAR1NameLabel.text = player.name ?? ""
                aR5PointLable.text = "\(player.credit ?? "") cr."
                aR5ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aR5CaptainLbl.isHidden = false
                    aR5CaptainLbl.text = "C"
                    aR5CaptainLbl.borderColor =   UIColor(red: 115, green: 16, blue: 18)
                    aR5CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if  player.vicecaptain == 1  {
                    aR5CaptainLbl.isHidden = false
                    aR5CaptainLbl.text = "K"
                    aR5CaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aR5CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                    
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aR5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                allRounderStackview.spacing = 10
                if player.team == "team1" {
                    allView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aR6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView6.backgroundColor = .black
                    aR6NameLabel.backgroundColor = .black
                }
                 all6PlayingView.isHidden = true
                ar6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aR6NameLabel.text = sortName
                }
                
                //                          aAR1NameLabel.text = player.name ?? ""
                aR6PointLable.text = "\(player.credit ?? "") cr."
                aR6ContainerView.isHidden = false
                
                if  player.captain == 1  {
                    aR6CaptainLbl.isHidden = false
                    aR6CaptainLbl.text = "C"
                    aR6CaptainLbl.borderColor =   UIColor(red: 115, green: 16, blue: 18)
                    aR6CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1  {
                    aR6CaptainLbl.isHidden = false
                    aR6CaptainLbl.text = "K"
                    aR6CaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aR6CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                    
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aR6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            default:
                break
            }
        }
    }
    
    fileprivate func setBowlDataLeaderBoard() {
        for (index,player) in bowlArrayLeaderboard.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    ballView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView1.backgroundColor = .black
                    aBall1NameLabel.backgroundColor = .black
                }
                
                ball1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall1NameLabel.text = sortName
                }
                
                //                    aBall1NameLabel.text = player.name ?? ""
                aBall1PointLabel.text = "\(player.credit ?? "") cr."
                aBall1ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "C"
                    aBall1CaptainLabel.borderColor =   UIColor(red: 115, green: 16, blue: 18)
                    aBall1CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "K"
                    
                    aBall1CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall1ImageView?.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                ballStackView.spacing = 100
                if player.team == "team1" {
                    ballView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView2.backgroundColor = .black
                    aBall2NameLabel.backgroundColor = .black
                }
                ball2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall2NameLabel.text = sortName
                }
                //                    aBall2NameLabel.text = player.name ?? ""
                aBall2PointLabel.text = "\(player.credit ?? "") cr."
                aBall2ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "C"
                    aBall2CaptainLabel.borderColor =   UIColor(red: 115, green: 16, blue: 18)
                    aBall2CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "K"
                    aBall2CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                ballStackView.spacing = 80
                if player.team == "team1" {
                    ballView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView3.backgroundColor = .black
                    aBall3NameLabel.backgroundColor = .black
                }
                ball3_Player_ID = player.id ?? 0
                
                //                    aBall3NameLabel.text = player.name ?? ""
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall3NameLabel.text = sortName
                }
                
                aBall3PointLabel.text = "\(player.credit ?? "") cr."
                aBall3ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "C"
                    aBall3CaptainLabel.borderColor =   UIColor(red: 115, green: 16, blue: 18)
                    aBall3CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "K"
                    
                    aBall3CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                ballStackView.spacing = 50
                if player.team == "team1" {
                    ballView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView4.backgroundColor = .black
                    aBall4NameLabel.backgroundColor = .black
                }
                ball4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall4NameLabel.text = sortName
                }
                
                //                    aBall4NameLabel.text = player.name ?? ""
                aBall4PointLabel.text = "\(player.credit ?? "") cr."
                aBall4ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "C"
                    aBall4CaptainLabel.borderColor =   UIColor(red: 115, green: 16, blue: 18)
                    aBall4CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "K"
                    aBall4CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                ballStackView.spacing = 20
                if player.team == "team1" {
                    ballView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall5NameLabel.backgroundColor = .black
                }
                ball5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall5NameLabel.text = sortName
                }
                //                    aBall5NameLabel.text = player.name ?? ""
                aBall5PointLabel.text = "\(player.credit ?? "") cr."
                aBall5ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "C"
                    aBall4CaptainLabel.borderColor =   UIColor(red: 115, green: 16, blue: 18)
                    aBall5CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "K"
                    aBall5CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                ballStackView.spacing = 10
                if player.team == "team1" {
                    ballView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView6.backgroundColor = .black
                    aBall6NameLabel.backgroundColor = .black
                }
                ball6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall6NameLabel.text = sortName
                }
                //                    aBall5NameLabel.text = player.name ?? ""
                aBall6PointLabel.text = "\(player.credit ?? "") cr."
                aBall6ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall6CaptainLabel.isHidden = false
                    aBall6CaptainLabel.text = "C"
                    aBall6CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall6CaptainLabel.isHidden = false
                    aBall6CaptainLabel.text = "K"
                    aBall6CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            default:
                break
            }
        }
    }
    
    
    @IBAction func crossBtnAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Team", bundle: nil).instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
        vc.fromPreview = true
        delegate?.checkComingFromPReview(check: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func EditButtonAction(_ sender: Any) {
        openEditVc(arryOfPlayer :arrayOFSelectedPlayer,viceCaptainID : vcID,captainID :cId,teamIDs:teamID)
    }
    func openEditVc(arryOfPlayer :[Int],viceCaptainID : Int,captainID :Int,teamIDs:Int){
        openViewController(controller: TeamViewController.self, storyBoard: .teamStoryBoard, handler: { (vc) in
            vc.arrayOfPlayer  = arryOfPlayer
            vc.contestData = self.getContestDetail
            vc.viceCaptainID = viceCaptainID
            vc.captainID = captainID
            vc.teamID = teamIDs
            vc.contestLiveData = self.contestLiveDatas
            
        })
    }
    fileprivate func setWKDataList() {
        for (index,player) in wkArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    wkView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk1NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wkView1.backgroundColor = .black
                    awk1NameLbl.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wkPlayingView.isHidden = false
                        
                        wkPlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wkPlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wkPlayingView.isHidden = false
                    }
                    
                }
                else {
                    wkPlayingView.isHidden = false
                }
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk1NameLbl.text = sortName
                }
                
                awk1PointLbl.text = "\(player.credit ?? "") cr."
                awk1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "C"
                    awkCaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awkCaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if temp == self.viceCaptianID {
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "K"
                    awkCaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    awkCaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
                                        case 1:
                                                 awicketkeeperStackView.spacing = 100
                                            if player.team == "team1" {
                                                awk2Uiview.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                                                awk2NameLBl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                                            } else {
                                                awk2Uiview.backgroundColor = .black
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
                                                awk2CaptainLbl.text = "C"
                                                awk2CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                                            }
                                            if temp == self.viceCaptianID {
                                                awk2CaptainLbl.isHidden = false
                                                awk2CaptainLbl.text = "VC"
                                                awk2CaptainLbl.backgroundColor = .black
                                            }
                                            if let imagePath = player.image {
                                                let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                                                let imageUrl = URL(string: urlString1 ?? "")
                                                aWk2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                                                }
                
                }
                //                        case 2:
                //                            if player.team == "team1" {
                //                                wkView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                                awk3NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                            } else {
                //                                wkView3.backgroundColor = .black
                //                                awk3NameLbl.backgroundColor = .black
                //                            }
                //                            wk3_Player_ID = player.id ?? 0
                //                            let nameFormatter = PersonNameComponentsFormatter()
                //                            if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                //
                //                                 let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                //                            awk3NameLbl.text = sortName
                //                            }
                ////                            awk3NameLbl.text = player.name ?? ""
                //                            awk3PointLbl.text = "\(player.credit ?? "") cr."
                //                            awk3ContainerView.isHidden = false
                //                            let temp = "\(player.id ?? 0)"
                //                            if temp == self.captainID {
                //
                //                                awk3CaptianLbl.isHidden = false
                //                                awk3CaptianLbl.text = "C"
                //                                awk3CaptianLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                            }
                //                            if temp == self.viceCaptianID {
                //                                awk3CaptianLbl.isHidden = false
                //                                awk3CaptianLbl.text = "VC"
                //                                awk3CaptianLbl.backgroundColor = .black
                //                            }
                //                            if let imagePath = player.image {
                //                                let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                //
                //                                let imageUrl = URL(string: urlString1 ?? "")
                //                                awk3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                //                                }
                //
                //                            }
                ////                            if awk3ImageView == nil {
                ////                                                              awk3ImageView.image = #imageLiteral(resourceName: "Mask Group 14")
                ////                                                           }
                //                        case 3:
                //                            if player.team == "team1" {
                //                                wkView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                                aWKName4Label.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                            } else {
                //                                wkView4.backgroundColor = .black
                //                                aWKName4Label.backgroundColor = .black
                //                            }
                //                            wk4_Player_ID = player.id ?? 0
                //
                //                            aWKName4Label.text = player.name ?? ""
                //                            let nameFormatter = PersonNameComponentsFormatter()
                //                            if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                //
                //                                 let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                //                            aWK4PointLabel.text = sortName
                //                            }
                ////                            aWK4PointLabel.text = "\(player.credit ?? "") cr."
                //                            aWK4ContainerView.isHidden = false
                //
                //                           let temp = "\(player.id ?? 0)"
                //                            if temp == self.captainID {
                //                                aWK4CaptainLabel.isHidden = false
                //                                aWK4CaptainLabel.text = "C"
                //                                aWK4CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                //                            }
                //                            if temp == self.viceCaptianID {
                //                                aWK4CaptainLabel.isHidden = false
                //                                aWK4CaptainLabel.text = "VC"
                //                                aWK4CaptainLabel.backgroundColor = .black
                //                            }
                //                            if let imagePath = player.image {
                //                                let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                //
                //                                let imageUrl = URL(string: urlString1 ?? "")
                //                                aWK4ImageView?.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                //                                }
                //
                //                            }
                ////                            if aWK4ImageView == nil {
                ////                                                              aWK4ImageView.image = #imageLiteral(resourceName: "Mask Group 14")
            ////                                                           }
            default:break
                
            }
        }
        
    }
    fileprivate func setBowlDataList() {
        for (index,player) in bowlArrayList.enumerated() {
            switch index {
            case 0:
                
                if player.team == "team1" {
                    ballView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView1.backgroundColor = .black
                    aBall1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball1PlayingView.isHidden = false
                    }
                    else {
                        ball1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball1PlayingView.isHidden = false
                    }
                }
                else {
                    ball1PlayingView.isHidden = true
                }
                ball1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall1NameLabel.text = sortName
                }
                
                aBall1PointLabel.text = "\(player.credit ?? "") cr."
                aBall1ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "C"
                    aBall1CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "K"
                    aBall1CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //
                }
            //                  }
            case 1:
                ballStackView.spacing = 100
                if player.team == "team1" {
                    ballView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView2.backgroundColor = .black
                    aBall2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball2PlayingView.isHidden = false
                    }
                    else {
                        ball2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball2PlayingView.isHidden = false
                    }
                }
                else {
                    ball2PlayingView.isHidden = true
                }
                ball2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall2NameLabel.text = sortName
                }
                //                  aBall2NameLabel.text = player.name ?? ""
                aBall2PointLabel.text = "\(player.credit ?? "") cr."
                aBall2ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "C"
                    aBall2CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "K"
                    aBall2CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                  if aBall2ImageView == nil {
                    //                     aBall2ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                }
            //                }
            case 2:
                ballStackView.spacing = 80
                if player.team == "team1" {
                    ballView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView3.backgroundColor = .black
                    aBall3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball3PlayingView.isHidden = false
                    }
                    else {
                        ball3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball3PlayingView.isHidden = false
                    }
                }
                else {
                    ball3PlayingView.isHidden = true
                }
                ball3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall3NameLabel.text = sortName
                }
                //                  aBall3NameLabel.text = player.name ?? ""
                aBall3PointLabel.text = "\(player.credit ?? "") cr."
                aBall3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "C"
                    aBall3CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "K"
                    aBall3CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall3ImageView?.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aBall3ImageView == nil {
                    //                                        aBall3ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                    //                                     }
                }
            case 3:
                ballStackView.spacing = 50
                if player.team == "team1" {
                    ballView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView4.backgroundColor = .black
                    aBall4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball4PlayingView.isHidden = false
                    }
                    else {
                        ball4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball4PlayingView.isHidden = false
                    }
                }
                else {
                    ball4PlayingView.isHidden = true
                }
                ball4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall4NameLabel.text = sortName
                }
                //                  aBall4NameLabel.text = player.name ?? ""
                aBall4PointLabel.text = "\(player.credit ?? "") cr."
                aBall4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "C"
                    aBall4CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "K"
                    aBall4CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                  if aBall4ImageView == nil {
                    //                     aBall4ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                }
            //                }
            case 4:
                ballStackView.spacing = 20
                if player.team == "team1" {
                    ballView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView5.backgroundColor = .black
                    aBall5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball5PlayingView.isHidden = false
                    }
                    else {
                        ball5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball5PlayingView.isHidden = false
                    }
                }
                else {
                    ball5PlayingView.isHidden = true
                }
                ball5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall5NameLabel.text = sortName
                }
                //                  aBall5NameLabel.text = player.name ?? ""
                aBall5PointLabel.text = "\(player.credit ?? "") cr."
                aBall5ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "C"
                    aBall5CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "K"
                    aBall5CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    //                    if aBall5ImageView == nil {
                    //                       aBall5ImageView.image = #imageLiteral(resourceName: "Group 7763_4")
                    //                    }
                }
            case 5:
                ballStackView.spacing = 10
                if player.team == "team1" {
                    ballView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView6.backgroundColor = .black
                    aBall6NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball6PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball6PlayingView.isHidden = false
                    }
                    else {
                        ball6PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball6PlayingView.isHidden = false
                    }
                }
                else {
                    ball6PlayingView.isHidden = true
                }
                ball6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall6NameLabel.text = sortName
                }
                //                  aBall5NameLabel.text = player.name ?? ""
                aBall6PointLabel.text = "\(player.credit ?? "") cr."
                aBall6ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBall6CaptainLabel.isHidden = false
                    aBall6CaptainLabel.text = "C"
                    aBall6CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBall6CaptainLabel.isHidden = false
                    aBall6CaptainLabel.text = "K"
                    aBall6CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                    
                }
            default:
                break
            }
        }
    }
    fileprivate func setAllDataList() {
        for (index,player) in allArrayList.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    allView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView1.backgroundColor = .black
                    aAR1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all1PlayingView.isHidden = false
                    }
                    else {
                        all1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all1PlayingView.isHidden = false
                    }
                }
                else {
                    all1PlayingView.isHidden = true
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
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "C"
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "K"
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 49, green: 139, blue: 22)
                    aAR1CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
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
                allRounderStackview.spacing = 100
                if player.team == "team1" {
                    
                    allView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    
                    aAR2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView2.backgroundColor = .black
                    aAR2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all2PlayingView.isHidden = false
                    }
                    else {
                        all2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all2PlayingView.isHidden = false
                    }
                }
                else {
                    all2PlayingView.isHidden = true
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
                    aAR2CaptainLabel.text = "C"
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "K"
                    aAR2CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
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
                allRounderStackview.spacing = 80
                if player.team == "team1" {
                    allView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView3.backgroundColor = .black
                    aAR3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all3PlayingView.isHidden = false
                    }
                    else {
                        all3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all3PlayingView.isHidden = false
                    }
                }
                else {
                    all3PlayingView.isHidden = true
                }
                ar3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR3NameLabel.text = sortName
                }
                
                aAR3PointLabel.text = "\(player.credit ?? "") cr."
                aAR3ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "C"
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == viceCaptianID {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "K"
                    aAR3CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
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
            //                  }
            case 3:
                allRounderStackview.spacing = 50
                if player.team == "team1" {
                    allView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aR4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView4.backgroundColor = .black
                    aR4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all4PlayingView.isHidden = false
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
                    aR4NameLabel.text = sortName
                }
                
                aR4PointLable.text = "\(player.credit ?? "") cr."
                aR4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aR4CaptainLbl.isHidden = false
                    aR4CaptainLbl.text = "C"
                    aR4CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aR4CaptainLbl.isHidden = false
                    aR4CaptainLbl.text = "K"
                    aR4CaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aR4CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aR4ImageView?.sd_setImage(with: imageUrl, placeholderImage:#imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                allRounderStackview.spacing = 20
                if player.team == "team1" {
                    allView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aR5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView5.backgroundColor = .black
                    aR5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all5PlayingView.isHidden = false
                    }
                    else {
                        all5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all5PlayingView.isHidden = false
                    }
                }
                else {
                    all5PlayingView.isHidden = true
                }
                ar5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aR5NameLabel.text = sortName
                }
                
                //                          aAR1NameLabel.text = player.name ?? ""
                aR5PointLable.text = "\(player.credit ?? "") cr."
                aR5ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aR5CaptainLbl.isHidden = false
                    aR5CaptainLbl.text = "C"
                    aR5CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aR5CaptainLbl.isHidden = false
                    aR5CaptainLbl.text = "K"
                    aR5CaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aR5CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aR5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                allRounderStackview.spacing = 10
                if player.team == "team1" {
                    allView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aR6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView6.backgroundColor = .black
                    aR6NameLabel.backgroundColor = .black
                }
                ar6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aR6NameLabel.text = sortName
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all6PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all6PlayingView.isHidden = false
                    }
                    else {
                        all6PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all6PlayingView.isHidden = false
                    }
                }
                else {
                    all6PlayingView.isHidden = true
                }
                
                //                          aAR1NameLabel.text = player.name ?? ""
                aR6PointLable.text = "\(player.credit ?? "") cr."
                aR6ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aR6CaptainLbl.isHidden = false
                    aR6CaptainLbl.text = "C"
                    aR6CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aR6CaptainLbl.isHidden = false
                    aR6CaptainLbl.text = "K"
                    aR6CaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aR6CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aR6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
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
                    batView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView1.backgroundColor = .black
                    aBat1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat1PlayingView.isHidden = false
                    }
                    else {
                        bat1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat1PlayingView.isHidden = false
                    }
                }
                else {
                    bat1PlayingView.isHidden = true
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
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "C"
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp ==  self.viceCaptianID{
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "K"
                    aBat1CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                //                if aBat1ImageView.image == nil {
                //                    aBat1ImageView.image = #imageLiteral(resourceName: "1_3")
                //                }
                
            case 1:
                batStackView.spacing = 100
                if player.team == "team1" {
                    batView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView2.backgroundColor = .black
                    aBat2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat1PlayingView.isHidden = false
                    }
                    else {
                        bat2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat2PlayingView.isHidden = false
                    }
                }
                else {
                    bat2PlayingView.isHidden = true
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
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "C"
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "K"
                    aBat2CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                //                if aBat2ImageView.image == nil {
                //                    aBat2ImageView.image = #imageLiteral(resourceName: "1_3")
            //                }
            case 2:
                batStackView.spacing = 80
                if player.team == "team1" {
                    batView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView3.backgroundColor = .black
                    aBat3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat3PlayingView.isHidden = false
                    }
                    else {
                        bat3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat3PlayingView.isHidden = false
                    }
                }
                else {
                    bat3PlayingView.isHidden = true
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
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "C"
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "K"
                    aBat3CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                //                if aBat3ImageView.image == nil {
                //                    aBat3ImageView.image = #imageLiteral(resourceName: "1_3")
            //                }
            case 3:
                batStackView.spacing = 50
                if player.team == "team1" {
                    batView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView4.backgroundColor = .black
                    aBat4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat4PlayingView.isHidden = false
                    }
                    else {
                        bat4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat4PlayingView.isHidden = false
                    }
                }
                else {
                    bat4PlayingView.isHidden = true
                }
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat4NameLabel.text = sortName
                }
                bat4_Player_ID = player.id ?? 0
                //                aBat4NameLabel.text = player.name ?? ""
                aBat4PointLabel.text = "\(player.credit ?? "") cr."
                aBat4ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "C"
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "K"
                    aBat4CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                //                if aBat4ImageView.image == nil {
                //                    aBat4ImageView.image = #imageLiteral(resourceName: "1_3")
            //                }
            case 4:
                batStackView.spacing = 20
                if player.team == "team1" {
                    batView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView5.backgroundColor = .black
                    aBat5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat5PlayingView.isHidden = false
                    }
                    else {
                        bat5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat5PlayingView.isHidden = false
                    }
                }
                else {
                    bat5PlayingView.isHidden = true
                }
                bat5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat5NameLabel.text = sortName
                }
                //                aBat5NameLabel.text = player.name ?? ""
                aBat5PointLabel.text = "\(player.credit ?? "") cr."
                aBat5ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "C"
                    aBat5CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "K"
                    aBat5CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                batStackView.spacing = 10
                if player.team == "team1" {
                    batView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView6.backgroundColor = .black
                    aBat6NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat6PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat6PlayingView.isHidden = false
                    }
                    else {
                        bat6PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat6PlayingView.isHidden = false
                    }
                }
                else {
                    bat6PlayingView.isHidden = true
                }
                bat6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat6NameLabel.text = sortName
                }
                //                    aBat5NameLabel.text = player.name ?? ""
                aBat6PointLabel.text = "\(player.credit ?? "") cr."
                aBat6ContainerView.isHidden = false
                let temp = "\(player.id ?? 0)"
                if temp == self.captainID {
                    
                    aBat6CaptainLabel.isHidden = false
                    aBat6CaptainLabel.text = "C"
                    aBat6CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if temp == self.viceCaptianID {
                    aBat6CaptainLabel.isHidden = false
                    aBat6CaptainLabel.text = "K"
                    aBat6CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            default:
                break
            }
        }
    }
    fileprivate func setWKData() {
        for (index,player) in wkArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    wkView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awk1NameLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    wkView1.backgroundColor = .black
                    awk1NameLbl.backgroundColor = .black
                }
                
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        wkPlayingView.isHidden = false
                        
                        wkPlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                    }
                    else {
                        wkPlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        wkPlayingView.isHidden = false
                    }
                    
                }
                else {
                    wkPlayingView.isHidden = false
                }
                wk1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    awk1NameLbl.text = sortName
                }
                //                            awk1NameLbl.text = player.name ?? ""
                awk1PointLbl.text = "\(player.credit ?? "") cr."
                awk1ContainerView.isHidden = false
                
                if player.captain == 1{
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "C"
                    awkCaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    awkCaptainLbl.borderColor = UIColor(red: 115, green: 16, blue: 18)
                }
                if player.vicecaptain == 1 {
                    awkCaptainLbl.isHidden = false
                    awkCaptainLbl.text = "K"
                    awkCaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    awkCaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    awk1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                case 1:
                         awicketkeeperStackView.spacing = 100
                                                           if player.team == "team1" {
                                                               awk2Uiview.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                                                               awk2NameLBl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                                                           } else {
                                                               awk2Uiview.backgroundColor = .black
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
                                                               awk2CaptainLbl.text = "C"
                                                               awk2CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                                                           }
                                                           if temp == self.viceCaptianID {
                                                               awk2CaptainLbl.isHidden = false
                                                               awk2CaptainLbl.text = "VC"
                                                               awk2CaptainLbl.backgroundColor = .black
                                                           }
                                                           if let imagePath = player.image {
                                                               let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                               
                                                               let imageUrl = URL(string: urlString1 ?? "")
                                                               aWk2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                                                               }
                               
                               }
                
            default:
                break
                
                
            }
        }
    }
    
    fileprivate func setBatData() {
        for (index,player) in batArray.enumerated() {
            switch index {
            case 0:
                if player.team == "team1" {
                    batView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView1.backgroundColor = .black
                    aBat1NameLabel.backgroundColor = .black
                }
                bat1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat1NameLabel.text = sortName
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat1PlayingView.isHidden = false
                    }
                    else {
                        bat1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat1PlayingView.isHidden = false
                    }
                }
                else {
                    bat1PlayingView.isHidden = true
                }
                //                aBat1NameLabel.text = player.name ?? ""
                aBat1PointLabel.text = "\(player.credit ?? "") cr."
                aBat1ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "C"
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    
                }
                if player.vicecaptain == 1 {
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "K"
                    aBat1CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
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
                    batView2.backgroundColor =  UIColor(red: 240, green: 75, blue: 80)
                    aBat2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView2.backgroundColor = .black
                    aBat2NameLabel.backgroundColor = .black
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
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat1PlayingView.isHidden = false
                    }
                    else {
                        bat2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat2PlayingView.isHidden = false
                    }
                }
                else {
                    bat2PlayingView.isHidden = true
                }
                if player.captain == 1 {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "C"
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "K"
                    aBat2CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                batStackView.spacing = 80
                if player.team == "team1" {
                    batView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView3.backgroundColor = .black
                    aBat3NameLabel.backgroundColor = .black
                }
                bat3_Player_ID = player.id ?? 0
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat3PlayingView.isHidden = false
                    }
                    else {
                        bat3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat3PlayingView.isHidden = false
                    }
                }
                else {
                    bat3PlayingView.isHidden = true
                }
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
                    aBat3CaptainLabel.text = "C"
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "K"
                    aBat3CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                batStackView.spacing = 50
                if player.team == "team1" {
                    batView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView4.backgroundColor = .black
                    aBat4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat4PlayingView.isHidden = false
                    }
                    else {
                        bat4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat4PlayingView.isHidden = false
                    }
                }
                else {
                    bat4PlayingView.isHidden = true
                }
                bat4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat4NameLabel.text = sortName
                }
                //                aBat4NameLabel.text = player.name ?? ""
                aBat4PointLabel.text = "\(player.credit ?? "") cr."
                aBat4ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "C"
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "K"
                    aBat4CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                batStackView.spacing = 20
                if player.team == "team1" {
                    batView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView5.backgroundColor = .black
                    aBat5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat5PlayingView.isHidden = false
                    }
                    else {
                        bat5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat5PlayingView.isHidden = false
                    }
                }
                else {
                    bat5PlayingView.isHidden = true
                }
                bat5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat5NameLabel.text = sortName
                }
                //                aBat5NameLabel.text = player.name ?? ""
                aBat5PointLabel.text = "\(player.credit ?? "") cr."
                aBat5ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "C"
                    aBat5CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "K"
                    aBat5CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                batStackView.spacing = 10
                if player.team == "team1" {
                    batView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBat6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    batView6.backgroundColor = .black
                    aBat6NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        bat6PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        bat6PlayingView.isHidden = false
                    }
                    else {
                        bat6PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        bat6PlayingView.isHidden = false
                    }
                }
                else {
                    bat6PlayingView.isHidden = true
                }
                bat6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBat6NameLabel.text = sortName
                }
                //                aBat5NameLabel.text = player.name ?? ""
                aBat6PointLabel.text = "\(player.credit ?? "") cr."
                aBat6ContainerView.isHidden = false
                if player.captain == 1 {
                    aBat6CaptainLabel.isHidden = false
                    aBat6CaptainLabel.text = "C"
                    aBat6CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBat6CaptainLabel.isHidden = false
                    aBat6CaptainLabel.text = "K"
                    aBat6CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBat6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBat6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
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
                    allView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView1.backgroundColor = .black
                    aAR1NameLabel.backgroundColor = .black
                }
                ar1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR1NameLabel.text = sortName
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all1PlayingView.isHidden = false
                    }
                    else {
                        all1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all1PlayingView.isHidden = false
                    }
                }
                else {
                    all1PlayingView.isHidden = true
                }
                aAR1PointLabel.text = "\(player.credit ?? "") cr."
                aAR1ContainerView.isHidden = false
                if player.captain == 1 {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "C"
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                
                if player.vicecaptain == 1 {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "K"
                    aAR1CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 1:
                allRounderStackview.spacing = 100
                if player.team == "team1" {
                    allView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView2.backgroundColor = .black
                    aAR2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all2PlayingView.isHidden = false
                    }
                    else {
                        all2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all2PlayingView.isHidden = false
                    }
                }
                else {
                    all2PlayingView.isHidden = true
                }
                ar2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aAR2NameLabel.text = sortName
                }
                
                aAR2PointLabel.text = "\(player.credit ?? "") cr."
                aAR2ContainerView.isHidden = false
                if player.captain == 1 {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "C"
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "K"
                    aAR2CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 2:
                allRounderStackview.spacing = 80
                if player.team == "team1" {
                    allView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aAR3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView3.backgroundColor = .black
                    aAR3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all3PlayingView.isHidden = false
                    }
                    else {
                        all3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all3PlayingView.isHidden = false
                    }
                }
                else {
                    all3PlayingView.isHidden = true
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
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "C"
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "K"
                    aAR3CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aAR3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                allRounderStackview.spacing = 50
                if player.team == "team1" {
                    allView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aR4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView4.backgroundColor = .black
                    aR4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all4PlayingView.isHidden = false
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
                    aR4NameLabel.text = sortName
                }
                aR4PointLable.text = "\(player.credit ?? "") cr."
                aR4ContainerView.isHidden = false
                
                if player.captain == 1 {
                    aR4CaptainLbl.isHidden = false
                    aR4CaptainLbl.text = "C"
                    aR4CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1  {
                    aR4CaptainLbl.isHidden = false
                    aR4CaptainLbl.text = "K"
                    aR4CaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aR4CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aR4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                allRounderStackview.spacing = 20
                if player.team == "team1" {
                    allView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aR4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView5.backgroundColor = .black
                    aR5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all5PlayingView.isHidden = false
                    }
                    else {
                        all5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all5PlayingView.isHidden = false
                    }
                }
                else {
                    all5PlayingView.isHidden = true
                }
                ar5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aR5NameLabel.text = sortName
                }
                aR5PointLable.text = "\(player.credit ?? "") cr."
                aR5ContainerView.isHidden = false
                
                if player.captain == 1  {
                    aR5CaptainLbl.isHidden = false
                    aR5CaptainLbl.text = "C"
                    aR5CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1  {
                    aR5CaptainLbl.isHidden = false
                    aR5CaptainLbl.text = "K"
                    aR5CaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aR5CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aR5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
                
            case 5:
                allRounderStackview.spacing = 10
                if player.team == "team1" {
                    allView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aR6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    allView6.backgroundColor = .black
                    aR6NameLabel.backgroundColor = .black
                }
                ar6_Player_ID = player.id ?? 0
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        all6PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        all6PlayingView.isHidden = false
                    }
                    else {
                        all6PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        all6PlayingView.isHidden = false
                    }
                }
                else {
                    all6PlayingView.isHidden = true
                }
                
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aR6NameLabel.text = sortName
                }
                aR6PointLable.text = "\(player.credit ?? "") cr."
                aR6ContainerView.isHidden = false
                
                if player.captain == 1  {
                    aR6CaptainLbl.isHidden = false
                    aR6CaptainLbl.text = "C"
                    aR6CaptainLbl.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aR6CaptainLbl.isHidden = false
                    aR6CaptainLbl.text = "K"
                    aR6CaptainLbl.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aR6CaptainLbl.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aR6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
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
                    ballView1.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall1NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView1.backgroundColor = .black
                    aBall1NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball1PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball1PlayingView.isHidden = false
                    }
                    else {
                        ball1PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball1PlayingView.isHidden = false
                    }
                }
                else {
                    ball1PlayingView.isHidden = true
                }
                ball1_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall1NameLabel.text = sortName
                }
                //                aBall1NameLabel.text = player.name ?? ""
                aBall1PointLabel.text = "\(player.credit ?? "") cr."
                aBall1ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "C"
                    aBall1CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "K"
                    aBall1CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall1CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall1ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 1:
                ballStackView.spacing = 100
                if player.team == "team1" {
                    ballView2.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall2NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView2.backgroundColor = .black
                    aBall2NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball2PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball2PlayingView.isHidden = false
                    }
                    else {
                        ball2PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball2PlayingView.isHidden = false
                    }
                }
                else {
                    ball2PlayingView.isHidden = true
                }
                ball2_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall2NameLabel.text = sortName
                }
                //                aBall2NameLabel.text = player.name ?? ""
                aBall2PointLabel.text = "\(player.credit ?? "") cr."
                aBall2ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "C"
                    aBall2CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "K"
                    aBall2CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall2CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall2ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 2:
                ballStackView.spacing = 80
                if player.team == "team1" {
                    ballView3.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall3NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView3.backgroundColor = .black
                    aBall3NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball3PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball3PlayingView.isHidden = false
                    }
                    else {
                        ball3PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball3PlayingView.isHidden = false
                    }
                }
                else {
                    ball3PlayingView.isHidden = true
                }
                ball3_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall3NameLabel.text = sortName
                }
                //                aBall3NameLabel.text = player.name ?? ""
                aBall3PointLabel.text = "\(player.credit ?? "") cr."
                aBall3ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "C"
                    aBall3CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "K"
                    aBall3CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall3CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall3ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 3:
                ballStackView.spacing = 50
                if player.team == "team1" {
                    ballView4.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall4NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView4.backgroundColor = .black
                    aBall4NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball4PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball4PlayingView.isHidden = false
                    }
                    else {
                        ball4PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball4PlayingView.isHidden = false
                    }
                }
                else {
                    ball4PlayingView.isHidden = true
                }
                ball4_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall4NameLabel.text = sortName
                }
                //                aBall4NameLabel.text = player.name ?? ""
                aBall4PointLabel.text = "\(player.credit ?? "") cr."
                aBall4ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "C"
                    aBall4CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "K"
                    aBall4CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall4CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall4ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 4:
                ballStackView.spacing = 20
                if player.team == "team1" {
                    ballView5.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall5NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView5.backgroundColor = .black
                    aBall5NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball5PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball5PlayingView.isHidden = false
                    }
                    else {
                        ball5PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball5PlayingView.isHidden = false
                    }
                }
                else {
                    ball5PlayingView.isHidden = true
                }
                ball5_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall5NameLabel.text = sortName
                }
                //                aBall5NameLabel.text = player.name ?? ""
                aBall5PointLabel.text = "\(player.credit ?? "") cr."
                aBall5ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "C"
                    aBall5CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "K"
                    aBall5CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall5CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall5ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
                    }
                }
            case 5:
                ballStackView.spacing = 10
                if player.team == "team1" {
                    ballView6.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                    aBall6NameLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                } else {
                    ballView6.backgroundColor = .black
                    aBall6NameLabel.backgroundColor = .black
                }
                if player.is_playing_show == 1 {
                    if player.is_playing == 1 {
                        ball6PlayingView.layer.borderColor = UIColor(red: 85, green: 174, blue: 58).cgColor
                        ball6PlayingView.isHidden = false
                    }
                    else {
                        ball6PlayingView.layer.borderColor = UIColor(red: 185, green: 33, blue: 36).cgColor
                        ball6PlayingView.isHidden = false
                    }
                }
                else {
                    ball6PlayingView.isHidden = true
                }
                ball6_Player_ID = player.id ?? 0
                let nameFormatter = PersonNameComponentsFormatter()
                if let nameComps  = nameFormatter.personNameComponents(from: player.name ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                    
                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                    aBall5NameLabel.text = sortName
                }
                //                aBall5NameLabel.text = player.name ?? ""
                aBall6PointLabel.text = "\(player.credit ?? "") cr."
                aBall6ContainerView.isHidden = false
                if player.captain == 1 {
                    aBall6CaptainLabel.isHidden = false
                    aBall6CaptainLabel.text = "C"
                    aBall6CaptainLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                }
                if player.vicecaptain == 1 {
                    aBall6CaptainLabel.isHidden = false
                    aBall6CaptainLabel.text = "K"
                    aBall6CaptainLabel.borderColor =   UIColor(red: 49, green: 139, blue: 22)
                    aBall6CaptainLabel.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                }
                if let imagePath = player.image {
                    let urlString1 = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    
                    let imageUrl = URL(string: urlString1 ?? "")
                    aBall6ImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 7421"), options: .continueInBackground) { (img, err, cacheType, url) in
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
    
    @IBAction func aWKButtonAction(_ sender: Any) {
        //  openPlayerInfoVC(id: wk_Player_ID)
    }
    
    @IBAction func aBat1ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: bat1_Player_ID)
    }
    
    @IBAction func aBat2ButtonAction(_ sender: Any) {
        //   openPlayerInfoVC(id: bat2_Player_ID)
    }
    
    @IBAction func aBat3ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: bat3_Player_ID)
    }
    
    @IBAction func aBat4ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: bat4_Player_ID)
    }
    
    @IBAction func aBat5ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: bat5_Player_ID)
    }
    
    @IBAction func aAL1ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: ar1_Player_ID)
    }
    
    @IBAction func aAL2ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: ar2_Player_ID)
    }
    
    @IBAction func aAL3ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: ar3_Player_ID)
    }
    
    @IBAction func aBall1ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: ball1_Player_ID)
    }
    
    @IBAction func aBall2ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: ball2_Player_ID)
    }
    
    @IBAction func aBall3ButtonAction(_ sender: Any) {
        //openPlayerInfoVC(id: ball3_Player_ID)
    }
    
    @IBAction func aBall4ButtonAction(_ sender: Any) {
        // openPlayerInfoVC(id: ball4_Player_ID)
    }
    
    @IBAction func aBall5ButtonAction(_ sender: Any) {
        //   openPlayerInfoVC(id: ball5_Player_ID)
        
    }
    
    func openPlayerInfoVC(id: Int) {
        //        openViewController(controller: PlayerStaticsViewController.self, storyBoard: .homeStoryBoard) { (vc) in
        ////            vc.teamId = self.teamId
        //            vc.matchKey = self.matchKey
        //            vc.playerID = id
        //        }
        
    }
}
