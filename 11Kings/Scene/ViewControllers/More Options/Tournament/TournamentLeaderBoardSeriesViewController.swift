//
//  TournamentLeaderBoardSeriesViewController.swift
//  11Kings
//
//  Created by uu on 25/08/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON

class TournamentLeaderBoardSeriesViewController: BaseClass {
    
    @IBOutlet weak var rankImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPoints: UILabel!
    @IBOutlet weak var userRank: UILabel!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var aTableView: UITableView!
    
    var seriesId:String?
    var leaderBoardSingleArray:LeaderBoardSeriesDetail?
    var leaderTournamentName:String?
    var leaderBoardSerisArray = [LeaderBoardSeriesDetail]()  {
           didSet {
               setup()
               aTableView.reloadDataInMainQueue()
           }
       }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        registerCell()
        
        getTournamentit(id:seriesId ?? "")
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func registerCell() {
        aTableView.register(UINib(nibName: TournamentLeaderBoardSeriesTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: TournamentLeaderBoardSeriesTableViewCell.identifier())
        aTableView.register(UINib(nibName: LeaderboardTournamentFirstTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: LeaderboardTournamentFirstTableViewCell.identifier())
    }
    
    func setup() {
        profileImageView.contentMode = .scaleToFill
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.clear.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            for i in 0..<leaderBoardSerisArray.count {
                
                
                let myid = UserDic.value(forKey: "user_id") as? Int
                if leaderBoardSerisArray[i].user_id == myid {
                    leaderBoardSingleArray = leaderBoardSerisArray[i]
                    userName.text = leaderBoardSerisArray[i].team
                    userPoints.text = "\(leaderBoardSerisArray[i].points ?? 0)"
                    userRank.text = "#\(leaderBoardSerisArray[i].rank ?? 0)"
                    
                    if let imageStr = leaderBoardSerisArray[i].image{
                        print(imageStr)
                        
                        let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        let imageUrl = URL(string: urlString ?? "")
                        profileImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                        }
                    }
                    
                    if profileImageView.image == nil {
                        profileImageView.image = #imageLiteral(resourceName: "Profile")
                    }
                    if leaderBoardSerisArray[i].rank == 1 {
                        rankImageView.isHidden = false
                        rankImageView.image = #imageLiteral(resourceName: "Rank1")
                        userRank.isHidden = true
                    }
                    else if leaderBoardSerisArray[i].rank == 2 {
                        rankImageView.isHidden = false
                        rankImageView.image = #imageLiteral(resourceName: "Rank2")
                        userRank.isHidden = true
                    }
                    else if leaderBoardSerisArray[i].rank == 3 {
                        rankImageView.image = #imageLiteral(resourceName: "Rank3")
                        self.rankImageView.isHidden = false
                        userRank.isHidden = true
                    }
                    else {
                        self.rankImageView.isHidden = true
                        userRank.isHidden = false
                    }
                    leaderBoardSerisArray.remove(at: i)
                    
                    return
                }
            }
        }
        
    }
    fileprivate func getTournamentit(id:String) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Content-Type":"application/json"]
        
        
        
        let param = ["user_id":UserDefaults.standard.value(forKey: kUserId),"series_id":id]
        
        NetworkManager.post_Request2(urlService: getTournamentLederboard, param: param as [String : Any], head: headers)  { (response) in
            
            self.hideActivityIndicator()
            guard let data = response else { return }
            do{
                let json = try JSON(data:data as! Data)
                
                let results = json["result"]
                self.leaderBoardSerisArray.removeAll()
                for i in results.arrayValue {
                    self.leaderBoardSerisArray.append(LeaderBoardSeriesDetail(json: i))
                    
                }
            }
                
            catch{
                Loader.showAlert(message: "Inernal Error")
                print(error.localizedDescription)
            }
        }
        
    }
    
    @IBAction func userButton(_ sender: Any) {
        openViewController(controller: LeaderBoardTournamentPlayerViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.userID = self.leaderBoardSingleArray?.user_id
            vc.seriesId = self.seriesId
            vc.leagueName = self.leaderTournamentName
            vc.userProfileSetup = self.leaderBoardSingleArray
        }
    }
}




extension TournamentLeaderBoardSeriesViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leaderBoardSerisArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TournamentLeaderBoardSeriesTableViewCell.identifier(), for: indexPath) as! TournamentLeaderBoardSeriesTableViewCell
        
        cell.selectionStyle = .none
        
        cell.configureCell(seriesResponse: leaderBoardSerisArray[indexPath.row])
        if leaderBoardSerisArray[indexPath.row].rank == 1 {
            cell.rankImageView.isHidden = false
            cell.rankLbl.isHidden = true
        }
        else if leaderBoardSerisArray[indexPath.row].rank == 2 {
            cell.rankImageView.isHidden = false
            cell.rankLbl.isHidden = true
        }
        else if leaderBoardSerisArray[indexPath.row].rank == 3 {
            cell.rankImageView.isHidden = false
            cell.rankLbl.isHidden = true
        }
        else {
            cell.rankImageView.isHidden = true
            cell.rankLbl.isHidden = false
        }
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        openViewController(controller: LeaderBoardTournamentPlayerViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.userID = self.leaderBoardSerisArray[indexPath.row].user_id
            vc.seriesId = self.seriesId
            vc.leagueName = self.leaderTournamentName
            vc.userProfileSetup = self.leaderBoardSerisArray[indexPath.row]
        }
    }
}
