//
//  CompareTeamViewController.swift
//  11Kings
//
//  Created by uu on 08/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
class CompareTeamViewController: BaseClass {
    
    @IBOutlet weak var diffPoint: UILabel!
    @IBOutlet weak var diffText: UILabel!
    @IBOutlet weak var team2Point: UILabel!
    @IBOutlet weak var team1Point: UILabel!
    @IBOutlet weak var totalPoints: UILabel!
    @IBOutlet weak var team2Rank: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team1Rank: UILabel!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var aTableView: UITableView!
    var team1ID:Int?
    var team2ID:Int?
    var challenge:Int?
    var userID:Int?
    var matchKey:String?
    var matchType:String?
    var contestData:GetMatchDetails?
    var getComparedata: CompareDataModel?
    
    var contestLiveData:MyContestLiveLeagues?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPlayerList()
        registerCell()
    }
    
    func setup() {
//        team1Image.layer.borderWidth = 1.0
//        team1Image.layer.masksToBounds = false
       team1Image?.layer.cornerRadius = (team1Image?.frame.size.width ?? 0.0) / 2
        team1Image.contentMode = .scaleToFill
        team1Image?.clipsToBounds = true
        team1Image?.layer.borderWidth = 3.0
        team1Image?.layer.borderColor = UIColor.clear.cgColor
//        team1Image.layer.borderColor = UIColor.clear.cgColor
//        team1Image.layer.cornerRadius = team1Image.frame.size.width/2
        team2Image.clipsToBounds = true
        team2Image.layer.borderWidth = 1.0
        team2Image.layer.masksToBounds = false
         team2Image.contentMode = .scaleToFill
        team2Image.layer.borderColor = UIColor.clear.cgColor
        team2Image.layer.cornerRadius = team2Image.frame.size.width/2
        team2Image.clipsToBounds = true
        diffText.text = getComparedata?.diff_text
        diffPoint.text = getComparedata?.diff_points
        team1Name.text = getComparedata?.team1_name
        team2Name.text = getComparedata?.team2_name
        team1Rank.text = getComparedata?.team1_rank
        team2Rank.text = getComparedata?.team2_rank
        team1Point.text = "\(getComparedata?.team1_points ?? 0)"
        team2Point.text = "\(getComparedata?.team2_points ?? 0)"
        if let imagePath = getComparedata?.team1_image {
                               let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                               let imageUrl = URL(string: urlString ?? "")
                               team1Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                               }
                           }
        if let imagePath = getComparedata?.team2_image {
                                      let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                                      let imageUrl = URL(string: urlString ?? "")
                                      team2Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                                      }
                                  }
    }
    
    func registerCell() {
        aTableView.register(UINib(nibName: "CompareTableViewCell", bundle: nil), forCellReuseIdentifier: "CompareTableViewCell")
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func getPlayerList() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/json",
            "Accept" : "application/json"
        ]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["challenge_id":challenge,"matchkey":matchKey,"sport_key":matchType,"team1_id":team1ID,"team2_id":team2ID,"user_id":UserDefaults.standard.object(forKey: kUserId)
            ]
            NetworkManager.post_Request2(urlService: kCompare, param: param as [String : Any], head: headers) {
                (response) in
                
                self.hideActivityIndicator()
                
                
                do{
                    let json = try JSON(data:response as? Data ?? Data())
                    let getResult = json["result"]
                    
                    self.getComparedata = CompareDataModel(json: getResult)
//                                        print(self.getComparedata!)
//                                        print(self.getComparedata?.other_players.count)
//                                        print(self.getComparedata?.common_players.count)
                    
                    self.aTableView.reloadDataInMainQueue()
                    DispatchQueue.main.async {
                        self.setup()
                    }
                }
                catch{
                    self.view.makeToast(message: "Internal Error")
                    print(error.localizedDescription)
                }
            }
            
            
        }
        
    }
    
}




extension CompareTeamViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if getComparedata?.other_players.count ?? 0 > 0 && getComparedata?.common_players.count ?? 0 > 0 {
            return 3
        }
        else {
        return 2
    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
             return 2
        case 1 :
            if getComparedata?.other_players.count ?? 0 > 0 {
               
                return getComparedata?.other_players.count ?? 0
                
                
            }
            else if  getComparedata?.common_players.count ?? 0 > 0 {
                 return getComparedata?.common_players.count ?? 0
            }
        case 2:
            print(getComparedata?.common_players.count ?? 0)
                      return getComparedata?.common_players.count ?? 0
        default:
            return 0
        }
          return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView ()
        guard let customView = Bundle.main.loadNibNamed("CompareHeaderView", owner: self, options: nil)?.first as? CompareHeaderView else  {
            return headerView
        }
        customView.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 70)
        headerView.addSubview(customView)
       
        if section == 0 {
            customView.textLbl.text = getComparedata?.cvc_diff_text
            customView.pointLbl.text = getComparedata?.cvc_diff_points
        }
       
        if section == 1 {
             if getComparedata?.other_players.count ?? 0 > 0 {
            customView.textLbl.text = getComparedata?.others_diff_text
            customView.pointLbl.text = getComparedata?.others_diff_points
        }
        
        else {
            customView.textLbl.text = getComparedata?.common_diff_text
            customView.pointLbl.text = getComparedata?.cvc_diff_points
            }
        }
        if getComparedata?.common_players.count ?? 0 > 0 {
        if section == 2 {
            customView.textLbl.text = getComparedata?.common_diff_text
            customView.pointLbl.text = getComparedata?.cvc_diff_points
        }
        }
        return headerView
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompareTableViewCell") as! CompareTableViewCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {

                for i in 0...1 {
                    print(i)
                   
                    if getComparedata?.compare_c_vc?.captain.count ?? 0 > 0 {
                         print(getComparedata?.compare_c_vc?.captain[i] as Any)
                    print(getComparedata?.compare_c_vc?.captain[i].team_id ?? "0")
                    if team1ID == Int(getComparedata?.compare_c_vc?.captain[i].team_id ?? "0") {
                    cell.team1Detail.text = getComparedata?.compare_c_vc?.captain[i].role
                    cell.team1Point.text = getComparedata?.compare_c_vc?.captain[i].playerpoints
                       cell.team1Captain.text = "C"
                                           cell.team1Captain.isHidden = false
                                           cell.team1Captain.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                    let nameFormatter = PersonNameComponentsFormatter()
                    if let nameComps  = nameFormatter.personNameComponents(from:getComparedata?.compare_c_vc?.captain[i].playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                        
                        let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                        cell.team1Name.text = sortName
                    }
                        if let imagePath = getComparedata?.compare_c_vc?.captain[i].image {
                        let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        let imageUrl = URL(string: urlString ?? "")
                        cell.team1Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                        }
                    }
                        }
                
                else {
                        print(getComparedata?.compare_c_vc?.captain[i] as Any)
                         if getComparedata?.compare_c_vc?.captain.count ?? 0 > 0 {
                    cell.team2Captain.text = "C"
                    cell.team2Captain.isHidden = false
                    cell.team2Captain.backgroundColor = UIColor(red: 85, green: 174, blue: 58)
                            cell.team2Point.text = getComparedata?.compare_c_vc?.captain[i].playerpoints ?? ""
                    cell.team2detail.text = getComparedata?.compare_c_vc?.captain[i].role
                    let nameFormatter = PersonNameComponentsFormatter()
                    if let nameComps  = nameFormatter.personNameComponents(from:getComparedata?.compare_c_vc?.captain[i].playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                        
                        let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                        cell.team2Name.text = sortName
                    }
                    
                    if let imagePath = getComparedata?.compare_c_vc?.captain[i].image {
                        let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        let imageUrl = URL(string: urlString ?? "")
                        cell.team2Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                        }
                    }
                }
                        }
                    }
                   
            }
            }
            if indexPath.row == 1 {
               
                 if getComparedata?.compare_c_vc?.vice_captain.count ?? 0 > 0 {
                for i in 0...1 {
                    cell.team1Captain.text = "V"
                    cell.team1Captain.isHidden = false
                    cell.team1Captain.backgroundColor = UIColor(red: 195, green: 44, blue: 55)
                     print(getComparedata?.compare_c_vc?.vice_captain[i] as Any)
                    print(getComparedata?.compare_c_vc?.vice_captain[i].team_id ?? "0")
                    if team1ID == Int(getComparedata?.compare_c_vc?.vice_captain[i].team_id ?? "0") {
                    cell.team1Point.text = getComparedata?.compare_c_vc?.vice_captain[i].playerpoints
                    cell.team1Detail.text = getComparedata?.compare_c_vc?.vice_captain[i].role
                    let nameFormatter = PersonNameComponentsFormatter()
                    if let nameComps  = nameFormatter.personNameComponents(from:getComparedata?.compare_c_vc?.vice_captain[i].playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                        
                        let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                        cell.team1Name.text = sortName
                    }
                    
                    if let imagePath = getComparedata?.compare_c_vc?.vice_captain[i].image {
                        let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        let imageUrl = URL(string: urlString ?? "")
                        cell.team1Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                        }
                    }
                }
                    
                else {
                        print(getComparedata?.compare_c_vc?.vice_captain[i] as Any)
                        cell.team2Captain.text = "V"
                        cell.team2Captain.isHidden = false
                        cell.team2Captain.backgroundColor = UIColor(red: 195, green: 44, blue: 55)
                    cell.team2Point.text = getComparedata?.compare_c_vc?.vice_captain[i].playerpoints
                    cell.team2detail.text = getComparedata?.compare_c_vc?.vice_captain[i].role
                    let nameFormatter = PersonNameComponentsFormatter()
                    if let nameComps  = nameFormatter.personNameComponents(from:getComparedata?.compare_c_vc?.vice_captain[i].playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                        
                        let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                        cell.team2Name.text = sortName
                    }
                    
                    if let imagePath = getComparedata?.compare_c_vc?.vice_captain[i].image {
                        let urlString = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        let imageUrl = URL(string: urlString ?? "")
                        cell.team2Image?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                        }
                    }
                    
                }
                }
            }
        }
        
        }
        
        if indexPath.section == 1 {
            if getComparedata?.other_players.count ?? 0 > 0 {
            print(getComparedata?.other_players[indexPath.row] ?? "0")
                if let get = getComparedata?.other_players[indexPath.row].arrayOfInnerPlayer {
                    cell.team2Captain.isHidden = true
                    cell.team1Captain.isHidden = true
                    
                    for i in get {
                        let datas:Int = Int(i.team_id ?? "0") ?? 0
                            if team1ID == datas {
                                cell.team1Detail.text = i.role
                                cell.team1Point.text = i.playerpoints
                                let nameFormatter = PersonNameComponentsFormatter()
                                if let nameComps  = nameFormatter.personNameComponents(from:i.playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {

                                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                                    cell.team1Name.text = sortName
                                }
                                
                                
                            }else {
                                cell.team2detail.text = i.role
                                cell.team1Captain.isHidden = true
                    
                                 cell.team2Captain.isHidden = true
                                 cell.team2Captain.backgroundColor = .red
                                cell.team2Point.text = i.playerpoints
                                let nameFormatter = PersonNameComponentsFormatter()
                                if let nameComps  = nameFormatter.personNameComponents(from:i.playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {

                                    let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                                    cell.team2Name.text = sortName
                                }
                            }
                        }
                    }
                }
                
            
        
        else {
                 print(getComparedata?.common_players[indexPath.row].playerpoints as Any
                       )
                 cell.team2Captain.isHidden = true
                    cell.team1Captain.isHidden = true
                       cell.team1Point.text = getComparedata?.common_players[indexPath.row].playerpoints
                       cell.team1Detail.text = getComparedata?.common_players[indexPath.row].role
                       let nameFormatter = PersonNameComponentsFormatter()
                       if let nameComps  = nameFormatter.personNameComponents(from:getComparedata?.common_players[indexPath.row].playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                           
                           let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                           cell.team1Name.text = sortName
                       }
                       
                       cell.team2Point.text = getComparedata?.common_players[indexPath.row].playerpoints
                       cell.team2detail.text = getComparedata?.common_players[indexPath.row].role
                       if let nameComps  = nameFormatter.personNameComponents(from:getComparedata?.common_players[indexPath.row].playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                           
                           let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                           cell.team2Name.text = sortName
                       }
                   }
        }
        if indexPath.section == 2 {
            print(getComparedata?.common_players[indexPath.row].playerpoints as Any
            )
            cell.team2Captain.isHidden = true
            cell.team1Captain.isHidden = true
            cell.team1Point.text = getComparedata?.common_players[indexPath.row].playerpoints
            cell.team1Detail.text = getComparedata?.common_players[indexPath.row].role
            let nameFormatter = PersonNameComponentsFormatter()
            if let nameComps  = nameFormatter.personNameComponents(from:getComparedata?.common_players[indexPath.row].playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                
                let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                cell.team1Name.text = sortName
            }
            
            cell.team2Point.text = getComparedata?.common_players[indexPath.row].playerpoints
            cell.team2detail.text = getComparedata?.common_players[indexPath.row].role
            if let nameComps  = nameFormatter.personNameComponents(from:getComparedata?.common_players[indexPath.row].playername ?? ""), let firstLetter = nameComps.givenName?.first, let lastName = nameComps.familyName {
                
                let sortName = "\(firstLetter). \(lastName)"  // J. Singh
                cell.team2Name.text = sortName
            }
        }
//        }
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        return 50
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //           if indexPath.row == indexItem {
        //               return 50
        //           }
        //           else {
        return  100
        //           }
        
        
        
    }
}
