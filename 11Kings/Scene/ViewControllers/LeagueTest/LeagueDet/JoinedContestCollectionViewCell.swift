//
//  JoinedContestCollectionViewCell.swift
//  DreamTeam
//
//  Created by Test on 09/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol openContestDetailVc {
     func openContestDetail(challengeId: Int, league: myjoinedContest, entreFee: Int)
}
class JoinedContestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var aTableView: UITableView!
    
    @IBOutlet weak var hiddnImageView: UIImageView!

    @IBOutlet weak var HiddenButton: UIButton!
    @IBOutlet weak var upperLbl: UILabel!
    var refreshControl = UIRefreshControl()
    var winnerBreakUpView: WinnerBreakupView?
    var challengeid = 0
    var contestprice = 0.0
    var confirmationView: ConfirmationView?
    var indexItem = -1
      var hiddenButton: (() -> Void) = { }
    var createTeamButton: (() -> Void) = { }
//    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var aNoDataLabel: UILabel!
    var selectedContest: ((MyContestReponse, HomeType) -> Void) = { _, _ in }
    var joinButtonClouser: ((Int, Double) -> Void) = { _, _ in}
    var viceCapID = 0
    var CapId = 0
    var delgate:openContestDetailVc?
    var selectedTeamArray = [Int]()
    var storeLeague = [MyLeague]()
    var fromEditBtn = false
    var fromCloneBtn = false
    var storeDataforContestDetail:[MyLeague]?
    var itematIndex = -1 {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var contestDatas = [MyCatagries]() {
        didSet {
           
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
    
    func addPullToRefresh() {
           refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
           aTableView.refreshControl = refreshControl
       }
       
       @objc func refreshData(sender:AnyObject) {
         
//          getMyContest()
//           setNoDataLabel()
           aTableView.reloadData()
           self.refreshControl.endRefreshing()
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aTableView.delegate = self
        aTableView.dataSource = self
        
        registerCell()
        addPullToRefresh()
    }
    
    @IBAction func hiddenBtnAction(_ sender: Any) {
        hiddenButton()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        aTableView.reloadDataInMainQueue()
    }
    
    fileprivate func registerCell() {
        aTableView.register(UINib(nibName: "ContestCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ContestCategoryTableViewCell")
        aTableView.register(UINib(nibName: JoinedContestTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: JoinedContestTableViewCell.identifier())
        aTableView.register(UINib(nibName: MyTeamTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MyTeamTableViewCell.identifier())
        aTableView.register(UINib(nibName: viewMoreMatch.identifier(), bundle: nil), forCellReuseIdentifier: viewMoreMatch.identifier())
        aTableView.register(UINib(nibName: "viewMoreMatch", bundle: nil), forCellReuseIdentifier: "viewMoreMatch")
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
    
   
    
}
extension JoinedContestCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return joinLeague.count
       
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "JoinedContestTableViewCell") as! JoinedContestTableViewCell
        
            
            if joinLeague.count > 0 {
                cell2.configureCell(data: joinLeague[indexPath.row])
              
                return cell2
            }
           return cell2
        }
        
        
        
        
        
     
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return kBannerTVCellIHeight
       
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
     
            
            if let cID = joinLeague[indexPath.row].id,let fees = joinLeague[indexPath.row].entryfee {
                self.delgate?.openContestDetail(challengeId: cID, league: joinLeague[indexPath.row], entreFee: fees)
            }
        
    }
    
    
    
    
    
}


extension JoinedContestCollectionViewCell {
    
    
}
extension LeagueContestCollectionViewCell {
    
    
    
    
    
}

