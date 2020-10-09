//
//  PlayerStaticsViewController.swift
//  Club11
//
//  Created by Developer on 26/06/19.
//

import UIKit
import SDWebImage
protocol BackToleaderBoard {
    func checkFromPlayer()
}
class PlayerMatchPointDetail: BaseClass {

    @IBOutlet weak var inyouTeamImgeView: UIImageView!
    @IBOutlet weak var pointValueLbl: UILabel!
    @IBOutlet weak var pointLbl: NSLayoutConstraint!
    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var aSelectedByLbl: UILabel!
    var delegate:BackToleaderBoard?
    @IBOutlet weak var selectedPercent: UILabel!
    @IBOutlet weak var topPlayerImageView: UIImageView!
    @IBOutlet weak var inYourTeamLbl: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    var refreshControl = UIRefreshControl()
    var teamId = 0
    var playerID = 0
    var matchKey = ""
    var playerInfoData: playerMatchPoint?
      
    
    var playerPointBreakupArray = [PlayerPointBreakup]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        addPullToRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        addNavigationBar(navigationTitle: "Player Info", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
       setUp()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.delegate?.checkFromPlayer()
        self.navigationController?.popViewController(animated: true)

    }
    func setUp() {
//        if playerInfoData.
        if playerInfoData?.isSelected == 1 {
            inYourTeamLbl.isHidden = false
            inyouTeamImgeView.isHidden = false
            
        }
        else {
            inyouTeamImgeView.isHidden = true
            inYourTeamLbl.isHidden = false
        }
        if playerInfoData?.is_topplayer == 1 {
            topPlayerImageView.isHidden = false
            
        }
        else {
            topPlayerImageView.isHidden = true
        }
        
        playerNameLbl.text = playerInfoData?.player_name ?? ""
        selectedPercent.text = "\(playerInfoData?.selected_by ?? "") %"
        pointValueLbl.text = "\(playerInfoData?.actual_total_points ?? 0)"
    }
     
       func registerCell() {
        aTableView.register(UINib(nibName: playerDetailMatchTVCell.identifier(), bundle: nil), forCellReuseIdentifier: playerDetailMatchTVCell.identifier())
    }
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(sender:AnyObject) {
       
        aTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
   
    func setPlayerInfoData() {
        print(playerInfoData?.player_name ?? "")
//        playerNameLbl.text = playerMatchPoint? ?? ""
//        playerNameLbl.text = playerInfoData?.player_name ?? ""
//       
//        pointLbl.text = playerInfoData?.total_points ?? "0"
//        aSelectedByLbl.text = playerInfoData?.selected_by ?? "0%"
//      
    }
    
   
}

extension PlayerMatchPointDetail: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  playerInfoData?.breakup_points.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: playerDetailMatchTVCell.identifier(), for: indexPath) as! playerDetailMatchTVCell
        cell.configureCell(data:  (playerInfoData?.breakup_points[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
