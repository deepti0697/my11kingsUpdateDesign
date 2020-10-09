//
//  PlayerStaticsViewController.swift
//  Club11
//
//  Created by Developer on 26/06/19.
//

import UIKit
import SDWebImage

class PlayerStaticsViewController: BaseViewController {

    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aCreditLabel: UILabel!
    @IBOutlet weak var aPointsLabel: UILabel!
    @IBOutlet weak var aSelectedByLabel: UILabel!
    @IBOutlet weak var aPlayerNameLabel: UILabel!
    @IBOutlet weak var aPlayerImageView: UIImageView!
    
    var refreshControl = UIRefreshControl()
    var teamId = 0
    var playerID = 0
    var matchKey = ""
    var playerInfoData: PlayerInforData? {
        didSet {
            setPlayerInfoData()
        }
    }
    var playerPointBreakupArray = [PlayerPointBreakup]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        aContainerView.setCornerRadius(value: 5)
        addPullToRefresh() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Player Info", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false)
        getPlayerInfo()
    }

    func registerCell() {
        aTableView.register(UINib(nibName: PlayerStaticsTVCell.identifier(), bundle: nil), forCellReuseIdentifier: PlayerStaticsTVCell.identifier())
    }
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(sender:AnyObject) {
        getPlayerInfo()
        aTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    fileprivate func getPlayerInfo() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1,"matchkey": matchKey, "player_id": playerID, "team_id": teamId] as [String : Any]
        
        NetworkManager.post_Request(urlService: kPlayerPointsURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode(PlayerInfoResponse.self, from: responseData)
                    if responseModel.status == "success" {
                        self.playerInfoData = responseModel.data
                    } else {
                        Loader.showToast(message: "No player info", onView: self.view, bottomMargin: 200)
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func setPlayerInfoData() {
        aPlayerNameLabel.text = playerInfoData?.player_name ?? ""
        aCreditLabel.text = playerInfoData?.credit ?? "0"
        aPointsLabel.text = playerInfoData?.points ?? "0"
        aSelectedByLabel.text = playerInfoData?.selected_by ?? "0%"
        if let imagePath = playerInfoData?.image {
            let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
            aPlayerImageView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "avatar"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
        if let pointArr = playerInfoData?.point_breakup {
            playerPointBreakupArray = pointArr
        }
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PlayerStaticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerPointBreakupArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerStaticsTVCell.identifier(), for: indexPath) as! PlayerStaticsTVCell
        cell.configureCell(data: playerPointBreakupArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
