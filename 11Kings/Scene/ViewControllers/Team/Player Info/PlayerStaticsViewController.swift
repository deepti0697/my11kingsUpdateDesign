//
//  PlayerStaticsViewController.swift
//  Club11
//
//  Created by Developer on 26/06/19.
//

import UIKit
import SDWebImage
import SwiftyJSON
import Alamofire
protocol fromPlayerProfile {
    func backToTeam(check:Bool)
    func sendPlayaerInfo(playerid : PlayerListResponses)
    func sendPlayerInfotoRemove(playerid :PlayerListResponses)
}

class PlayerStaticsViewController: BaseClass {

    var checkFromCaptain = false
    var isPlayerAdeed = false
    @IBOutlet weak var addandRemoveButton: UIButton!
    @IBOutlet weak var batValue: UILabel!
    @IBOutlet weak var bowlValue: UILabel!
    @IBOutlet weak var bowl: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var nationality: UILabel!
    
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aCreditLabel: UILabel!
    @IBOutlet weak var aPointsLabel: UILabel!
    @IBOutlet weak var aSelectedByLabel: UILabel!
    @IBOutlet weak var aPlayerNameLabel: UILabel!
    @IBOutlet weak var aPlayerImageView: UIImageView!
    
    var playerDetailTable = [PlayerDetailInfoTable]() {
        didSet {
                    aTableView.reloadDataInMainQueue()
                }
    }
    var refreshControl = UIRefreshControl()
    var teamId = 0
    var playerID = 0
    var matchKey = ""
    var contestData : Any?
    var delegate:fromPlayerProfile?
    var playerData:PlayerListResponses?
//    var playerInfoData: playerDetailinfo? {
//        didSet {
//            setPlayerInfoData()
//        }
//    }
//    var playerPointBreakupArray = [PlayerPointBreakup]() {
//        didSet {
//            aTableView.reloadDataInMainQueue()
//        }
//    }
//
    var playerInfo: playerDetailinfo?
        {
                didSet {
                    setPlayerInfoData()
                }
            }
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
    aPlayerImageView.layer.borderWidth = 1
        aPlayerImageView.layer.masksToBounds = false
        aPlayerImageView.layer.borderColor = UIColor.white.cgColor
        aPlayerImageView.layer.cornerRadius = aPlayerImageView.frame.height/2
        aPlayerImageView.clipsToBounds = true
        registerCell()
        aContainerView.setCornerRadius(value: 5)
        addPullToRefresh() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = true
        if checkFromCaptain {
            checkFromCaptain = false
            addandRemoveButton.isHidden = true
        }
        else {
        if isPlayerAdeed {
            addandRemoveButton.setTitle("Add Player", for: .normal)
            addandRemoveButton.backgroundColor = UIColor(red: 23, green: 170, blue: 219)
        }
        else {
               addandRemoveButton.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
             addandRemoveButton.setTitle("Remove Player", for: .normal)
        }
        
        }
        playerID = playerData?.id ?? 0
         getPlayerInfo()
 
    }
    override func viewWillDisappear(_ animated: Bool) {
            self.navigationController?.isNavigationBarHidden = false
    }
    func registerCell() {
        aTableView.register(UINib(nibName: PlayerStaticsTVCell.identifier(), bundle: nil), forCellReuseIdentifier: PlayerStaticsTVCell.identifier())
    }
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    @IBAction func closePlayerProfile(_ sender: Any) {
        let vc = UIStoryboard(name: "Team", bundle: nil).instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
                    vc.fromPreview = true
              self.delegate?.backToTeam(check: true)
              self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshData(sender:AnyObject) {
   // getPlayerInfo()
      //  aTableView.reloadData()
//        ftechplayerInfo()
        getPlayerInfo()
        self.refreshControl.endRefreshing()
    }
    func ftechplayerInfo() {
        showActivityIndicator(sMessage: "Loading...")
               let headers = [
                   "Content-Type": "application/json",
                   "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDIyMTE0NiwiZXhwIjoxNTY0MjI0NzQ2LCJuYmYiOjE1NjQyMjExNDYsImp0aSI6IkFKYm5tdVpkb0VaVko3U2IiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.KSMUhnvzM2OmfgvhY_rOrt-cut2yW1IksR0PAZ3rgcY",
                   "Accept": "application/json"
               ]
        let parameters = ["matchkey": matchKey , "player_id": playerID] as [String : Any]
        
        NetworkManager.post_Request2(urlService:kPlayerInfo , param: parameters, head: headers) {
            (response) in
                              self.hideActivityIndicator()
            
                             
                              do{
                                  let json = try JSON(data:response as! Data)
                                  //                 let list = MyCatagries(json: json)
                                let results = json["result"]
                                  
                                self.playerInfo = playerDetailinfo(json: results)
                                      
                                  }
            catch{
                self.view.makeToast(message: "Internal Server Error")
                print(error.localizedDescription)
            }
        }

        }
                      
    
        fileprivate func getPlayerInfo() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
           "Content-Type": "application/json",
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDIyMTE0NiwiZXhwIjoxNTY0MjI0NzQ2LCJuYmYiOjE1NjQyMjExNDYsImp0aSI6IkFKYm5tdVpkb0VaVko3U2IiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.KSMUhnvzM2OmfgvhY_rOrt-cut2yW1IksR0PAZ3rgcY",
            "Accept": "application/json"
        ]
        let parameters = ["matchkey": matchKey, "playerid": playerID] as [String : Any]
        
        NetworkManager.post_Request2(urlService: getPlayerinfoDetail, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let jsonResponse = try JSON(data:response as! Data)
                  let status = jsonResponse["result"]
                
                
                    let list = playerDetailinfo(json: status)
                    self.playerInfo = list
                    self.playerDetailTable.removeAll()
                    let match = status["matches"]
                    for i in match.arrayValue {
                        self.playerDetailTable.append(PlayerDetailInfoTable(playerJson: i))
                    }
                    self.aTableView.reloadDataInMainQueue()
                     self.setPlayerInfoData()
                   
                  
                    
                   
                    } else {
                        Loader.showToast(message: "No player info", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                    }
                }
             catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func setPlayerInfoData() {
        aPlayerNameLabel.text = playerInfo?.playername ?? ""
        aSelectedByLabel.text = playerInfo?.playercredit ?? "0"
        aPointsLabel.text = playerInfo?.playerpoints ?? "0"
      
        dob.text = playerInfo?.dob ?? "nil"
        nationality.text = playerInfo?.country
        batValue.text = playerInfo?.battingstyle
        bowlValue.text = playerInfo?.bowlingstyle
        if let imagePath = playerInfo?.playerimage {
            let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
            aPlayerImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "avatar"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
        
        if aPlayerImageView.image == nil {
            aPlayerImageView.image = #imageLiteral(resourceName: "1_3")
        }
        
    }
    
    override func handleBackButtonAction() {
        let vc = UIStoryboard(name: "Team", bundle: nil).instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
              vc.fromPreview = true
        self.delegate?.backToTeam(check: true)
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func AddPlayerinTeam(_ sender: Any) {
        self.delegate?.backToTeam(check: true)
        if isPlayerAdeed {
        self.delegate?.sendPlayaerInfo(playerid: playerData!)
        }
        else {
            self.delegate?.sendPlayerInfotoRemove(playerid: playerData!)
        }
    self.navigationController?.popViewController(animated: true)

    }
    
}
extension PlayerStaticsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerDetailTable.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerStaticsTVCell.identifier(), for: indexPath) as! PlayerStaticsTVCell
        cell.configureCell(data: playerDetailTable[indexPath.row])
        return cell
    }
    
    
}


