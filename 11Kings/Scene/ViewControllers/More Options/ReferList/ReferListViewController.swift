//
//  ReferListViewController.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import UIKit
import  SwiftyJSON
class ReferListViewController: BaseClass {
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var totalReferPeople: UILabel!
    @IBOutlet weak var aTotalLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    var totalRefers:Int?
    var totalAmount:Int?
    var referredList = [ReferListResponse]() {
        didSet {
            noDataLabel.text = ""
            aTotalLabel.text = "\(totalAmount ?? 0)"
            self.aTableView.reloadDataInMainQueue()
            totalReferPeople.text = "\(referredList.count)"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aTableView.estimatedRowHeight = 60
        aTableView.rowHeight = UITableView.automaticDimension
        aTableView.register(UINib(nibName: ReferListTVCell.identifier(), bundle: nil), forCellReuseIdentifier: ReferListTVCell.identifier())
        totalReferPeople.text = "\(referredList.count)"
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          noDataLabel.text = "You have not earned yet from your refered friends"
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          self.navigationController?.isNavigationBarHidden = false
    }
    
    override func handleBackButtonAction() {
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
        
        let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id")]

            NetworkManager.post_Request(urlService: referBonusList, param: parameters as [String : Any], head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                   let json = try JSON(data:response as! Data)
                   //                 let list = MyCatagries(json: json)
                    self.totalAmount = json["total_amount"].intValue
                    self.totalRefers = json["total_user"].intValue
                   let results = json["result"]
                   
                   for arr in results.arrayValue{
                       self.referredList.append(ReferListResponse(json:arr))
                       
                       
                   }
                    
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
        }
    }
    
}

extension ReferListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return referredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReferListTVCell.identifier(), for: indexPath) as! ReferListTVCell
        
        cell.configureCell(data: referredList[indexPath.item])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
