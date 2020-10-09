//
//  PlayerCollectionViewCell.swift
//  11Kings
//
//  Created by uu on 07/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol playerData {
    func sendPlayerInfo(player:playerMatchPoint)
}
class PlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var aTableView: UITableView!
    var delegate:playerData?
    var matchKey = ""
       var cpntestData:Any?
       var hometype:HomeType = .live
       var playerpointData = [playerMatchPoint]() {
           didSet {
               aTableView.reloadDataInMainQueue()
           }
       }
       var refreshControl = UIRefreshControl()
       var breakPoint = [PlayerPointBreakup]()
    override func awakeFromNib() {
        super.awakeFromNib()
        aTableView.delegate = self
        aTableView.dataSource = self
        registerCell()
         addPullToRefresh()
    }
    fileprivate func registerCell() {
              aTableView.register(UINib(nibName: LeaderBoardPointTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: LeaderBoardPointTableViewCell.identifier())
   
    }
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
}

extension PlayerCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerpointData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaderBoardPointTableViewCell.identifier(), for: indexPath) as! LeaderBoardPointTableViewCell
//        cell.backGroundImage.image = nil
       let bgColorView = UIView()
       bgColorView.backgroundColor = UIColor.clear
       cell.selectedBackgroundView = bgColorView
//        cell.selectionStyle = UIColor.clear
            cell.configureCell(response: playerpointData[indexPath.row])
               
       
         return cell
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sendPlayerInfo(player: playerpointData[indexPath.row])
//        openLeaderboard(challenge: challengesArray[indexPath.row])
//        openplayerDetail(playeer: playerpointData[indexPath.row])
        
    }
    
    func openplayerDetail(playeer:playerMatchPoint) {
//        openViewController(controller: PlayerMatchPointDetail.self, storyBoard: .homeStoryBoard) { (vc) in
//            vc.matchKey = self.matchKey
//            vc.playerInfoData = playeer
//        }
    }
}
