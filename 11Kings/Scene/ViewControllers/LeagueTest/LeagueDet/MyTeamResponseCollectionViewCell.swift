//
//  MyTeamResponseCollectionViewCell.swift
//  DreamTeam
//
//  Created by Test on 09/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol openMyTeamVc {
     func openpreview(getTeamRespons:MyTeamResponses,teamName:String,teamIDs:Int)
      func openEditTeam(arrayOfInt:[Int], vc:Int,cap:Int,teamID:Int,checktype:Bool)
}
class MyTeamResponseCollectionViewCell: UICollectionViewCell {
     @IBOutlet weak var hiddnImageView: UIImageView!
var refreshControl = UIRefreshControl()
        @IBOutlet weak var aNoDataLabel: UILabel!
        @IBOutlet weak var HiddenButton: UIButton!
        @IBOutlet weak var upperLbl: UILabel!
        var winnerBreakUpView: WinnerBreakupView?
        var challengeid = 0
    @IBOutlet weak var createTeamButtonHeightConstraint: NSLayoutConstraint!
    var contestprice = 0.0
        var confirmationView: ConfirmationView?
        var indexItem = -1
    var  matchType  = ""
    @IBOutlet weak var createBtn: UIButton!
    var createTeamButton: (() -> Void) = { }
        @IBOutlet weak var aTableView: UITableView!
//        @IBOutlet weak var aNoDataLabel: UILabel!
        var selectedContest: ((MyContestReponse, HomeType) -> Void) = { _, _ in }
        var joinButtonClouser: ((Int, Double) -> Void) = { _, _ in}
        var viceCapID = 0
        var CapId = 0
        var delgate:openMyTeamVc?
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
                if teamResponse.count  == 0 {
                    createBtn.isHidden = true
                    createTeamButtonHeightConstraint.constant = 0
                }
                else if teamResponse.count == 15 {
                    createBtn.isHidden = true
                     createTeamButtonHeightConstraint.constant = 0
                }
                else {
                   createBtn.isHidden = false
                    createBtn.setTitle("Create Team \(teamResponse.count + 1)", for: .normal)
                     createTeamButtonHeightConstraint.constant = 40
                }
             
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
        override func awakeFromNib() {
            super.awakeFromNib()
            if teamResponse.count  == 0 {
                createBtn.isHidden = true
                createTeamButtonHeightConstraint.constant = 0
            }
            else if teamResponse.count == 15 {
                createBtn.isHidden = true
                 createTeamButtonHeightConstraint.constant = 0
            }
            else {
                createBtn.isHidden = false
                 createTeamButtonHeightConstraint.constant = 40
            }
            addPullToRefresh()
            
            registerCell()
        }
        
    @IBAction func createTeamButnAction(_ sender: Any) {
        createTeamButton()
    }
    
    @IBAction func createTEam(_ sender: Any) {
     createTeamButton()
    }
    
        @objc private func refreshWeatherData(_ sender: Any) {
            aTableView.reloadDataInMainQueue()
        }
        
        fileprivate func registerCell() {

            aTableView.register(UINib(nibName: MyTeamTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: MyTeamTableViewCell.identifier())
//
        }
        
        
       
        @IBAction func createTeam(_ sender: Any) {
            createTeamButton()
        }
        
        
        
    }
    extension MyTeamResponseCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
        func numberOfSections(in tableView: UITableView) -> Int {
          
         
                return  1
          
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
            
                return teamResponse.count
           
            
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
          
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "MyTeamTableViewCell") as! MyTeamTableViewCell
          
           
              
            cell3.delegate = self
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.red
            cell3.selectedBackgroundView = bgColorView
//            cell3.delegate = self
                if teamResponse.count > 0 {
                    if teamResponse.count == 15 {
                                               cell3.cloneView.isHidden = true
                                           }
                    else {
                           cell3.cloneView.isHidden = false
                    }
                    if matchType == "CRICKET" {
                        if teamResponse.count == 15 {
                            cell3.cloneView.isHidden = true
                        }
                         cell3.configureCell(data: teamResponse[indexPath.row])
                    }
                    else if matchType == "FOOTBALL"{
                        cell3.configureCellFootball(data: teamResponse[indexPath.row])
                    }
                    
                    else {
                        cell3.configureCellKabbaddi(data: teamResponse[indexPath.row])
                    }
                }
           
            cell3.editButtonClouser = { [weak self] id in
                if let strongSelf = self {
                    strongSelf.fromEditBtn = id
                    //
//                    self?.delgate?.openCaptainVc(check: self?.fromEditBtn ?? false)
                }
            }
            
            
            
            return cell3
            
           
            //                }
        }
       
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
                return 200
           
            
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            if itematIndex == 0 {
//                let leagues = contestDatas[indexPath.section].leagues
//                if let cID = leagues[indexPath.row].id, let fees = leagues[indexPath.row].entryfee {
//                    self.delgate?.openLederboard(challengeId: cID, league: leagues[indexPath.row], entreFee: fees)
//                }
//            }
//            if itematIndex == 1 {
//
//                if let cID = joinLeague[indexPath.row].id,let fees = joinLeague[indexPath.row].entryfee {
//                    self.delgate?.openContestDetail(challengeId: cID, league: joinLeague[indexPath.row], entreFee: fees)
//                }
//            }
        }
        
       
        
        
        
    }

extension MyTeamResponseCollectionViewCell:openEditVc {
func openEditViewController(arrayOfPlayerID: [Int], vcID: Int, captainId: Int, teamID: Int, check: Bool) {
   
    selectedTeamArray = arrayOfPlayerID
           viceCapID = vcID
           CapId = captainId
    self.delgate?.openEditTeam(arrayOfInt: selectedTeamArray,vc:viceCapID,cap:CapId, teamID: teamID, checktype: check)

}

func openPreviewData(teamResponse: MyTeamResponses, teamName: String, teamID: Int) {
      self.delgate?.openpreview(getTeamRespons: teamResponse, teamName: teamName, teamIDs: teamID)
}
}
    
    
