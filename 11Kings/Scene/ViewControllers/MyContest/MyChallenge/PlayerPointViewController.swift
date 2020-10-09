//
//  PlayerPointViewController.swift
//  DreamTeam
//
//  Created by Test on 04/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON
class PlayerPointViewController: BaseClass {
    
    
    @IBOutlet weak var timeLbl: UILabel!
   
    
    
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    var matchKey = ""
    var cpntestData:Any?
    var hometype:HomeType = .live
    var playerpointData = [playerMatchPoint]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    
    var breakPoint = [PlayerPointBreakup]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setContestData()
//        addNavigationBar(navigationTitle: "Player Points", titleContentMode: .left, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
        self.navigationController?.isNavigationBarHidden = true
        getPlayerPointData()
        registerCell()
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
     fileprivate func setContestData() {
            if let contest = cpntestData as? MyContestLiveLeagues {
                    matchKey = contest.matchkey ?? ""
                team1Name.text = contest.team2display
                team2Name.text = contest.team1display
               
                
                
                if hometype == .live
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
           
            if let contest = cpntestData as? MyContestReponse {
                matchKey = contest.matchkey ?? ""
            }
        }
    fileprivate func registerCell() {
           aTableView.register(UINib(nibName: PlayerPointTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: PlayerPointTableViewCell.identifier())
       }
    func getPlayerPointData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDY2NTgyNywiZXhwIjoxNTY0NjY5NDI3LCJuYmYiOjE1NjQ2NjU4MjcsImp0aSI6IkswSnZlbnpDWlg3UVNTZk0iLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.pJlBD3x2VYb-aExN5kCMU4LWsl3Lgi1oG-WrccTuX04",
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id") ?? "","matchkey": matchKey,"showLeaderBoard": "false"] as [String : Any]
            NetworkManager.post_Request2(urlService: kMatchPoint, param: parameters, head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let jsonDaaata = try JSON(data:response as! Data)
                        self.playerpointData.removeAll()
                        let result = jsonDaaata["result"]
                        for arr in result .arrayValue {
                            self.playerpointData.append(playerMatchPoint(json:arr))
                            
                        }
                        
                    }
                }
                catch {
                    
                }
            }
            
        }
    }
}

extension PlayerPointViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerpointData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerPointTableViewCell.identifier(), for: indexPath) as! PlayerPointTableViewCell


        cell.backGroundImage.image = #imageLiteral(resourceName: "Rectangle 34000")
        cell.configureCell(response: playerpointData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        openLeaderboard(challenge: challengesArray[indexPath.row])
        openplayerDetail(playeer: playerpointData[indexPath.row])
        
    }
    
    func openplayerDetail(playeer:playerMatchPoint) {
        openViewController(controller: PlayerMatchPointDetail.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.matchKey = self.matchKey
            vc.playerInfoData = playeer
        }
    }
}
