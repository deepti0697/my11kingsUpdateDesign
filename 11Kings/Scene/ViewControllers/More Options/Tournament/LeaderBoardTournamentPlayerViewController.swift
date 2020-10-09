//
//  LeaderBoardTournamentPlayerViewController.swift
//  11Kings
//
//  Created by uu on 26/08/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON
class LeaderBoardTournamentPlayerViewController: BaseClass {
    
    var getMatchLeaderBoardArray = [GetMatchleaderBoard]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var leagueName:String?
    var userProfileSetup:LeaderBoardSeriesDetail?
    @IBOutlet weak var batValue: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aTableView: UITableView!
    var userID:Int?
    var seriesId:String?
    @IBOutlet weak var aPlayerNameLabel: UILabel!
    @IBOutlet weak var aPlayerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerCell()
        setup()
        aPlayerImageView.layer.borderWidth = 1.0
              aPlayerImageView.layer.masksToBounds = false
              aPlayerImageView.layer.borderColor = UIColor.clear.cgColor
              aPlayerImageView.layer.cornerRadius = aPlayerImageView.frame.size.width/2
              aPlayerImageView.clipsToBounds = true
        getTournamentit(id: seriesId ?? "")
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setup() {
        aPlayerImageView.contentMode = .scaleToFill
        batValue.text = leagueName ?? ""
        nationality.text = "\(userProfileSetup?.points ?? 0)"
        dob.text = "#\(userProfileSetup?.rank ?? 0)"
        aPlayerNameLabel.text = userProfileSetup?.team
        if let imageStr = userProfileSetup?.image{
                         print(imageStr)
                        
                         let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                         let imageUrl = URL(string: urlString ?? "")
                         aPlayerImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Profile"), options: .continueInBackground) { (img, err, cacheType, url) in
                         }
                     }
    }
    
    func registerCell() {
           aTableView.register(UINib(nibName: PlayerStaticsTVCell.identifier(), bundle: nil), forCellReuseIdentifier: PlayerStaticsTVCell.identifier())
       }
    fileprivate func getTournamentit(id:String) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Content-Type":"application/json"]
        let converIntString = "\(userID ?? 0)"
        let param = ["user_id":converIntString,"series_id":id]
        
        NetworkManager.post_Request2(urlService: getMatchLeaderBoard, param: param as [String : Any], head: headers)  { (response) in
            
            self.hideActivityIndicator()
            guard let data = response else { return }
            do{
                let json = try JSON(data:data as! Data)
                
                let results = json["result"]
                for i in results.arrayValue {
                    self.getMatchLeaderBoardArray.append(GetMatchleaderBoard(json: i))
                    
                }
            }
                
            catch{
                Loader.showAlert(message: "Inernal Error")
                print(error.localizedDescription)
            }
        }
        
    }
}
extension LeaderBoardTournamentPlayerViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMatchLeaderBoardArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerStaticsTVCell.identifier(), for: indexPath) as! PlayerStaticsTVCell
        cell.ConfigureMatchCell(data: getMatchLeaderBoardArray[indexPath.row])
        return cell
    }
    
    
}


