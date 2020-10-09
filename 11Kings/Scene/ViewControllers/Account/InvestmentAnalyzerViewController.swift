//
//  InvestmentAnalyzerViewController.swift
//  11Kings
//
//  Created by uu on 08/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON
class InvestmentAnalyzerViewController: BaseClass {

    @IBOutlet weak var losswalltLbl: UILabel!
    @IBOutlet weak var profitLbl: UILabel!
    @IBOutlet weak var withdrawLbl: UILabel!
    @IBOutlet weak var depositLbl: UILabel!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var lossLbl: UILabel!
    @IBOutlet weak var receivedLbl: UILabel!
    @IBOutlet weak var investmentLbl: UILabel!
    var investment:InvestMentAnalysis? {
        didSet {
           setup()
        }
    }
    func setup() {
        self.investmentLbl.text = "\(kRupeeIcon)\(investment?.investment?.total_invest ?? "0")"
        self.lossLbl.text = "\(kRupeeIcon)\(investment?.investment?.loss ?? "0")"
        self.receivedLbl.text = "\(kRupeeIcon)\(investment?.investment?.total_recieve ?? "0")"
        self.profileLbl.text = "\(kRupeeIcon)\(investment?.investment?.profit ?? "0")"
        
        self.losswalltLbl.text = "\(kRupeeIcon)\(investment?.wallet?.loss ?? "0")"
        self.profitLbl.text = "\(kRupeeIcon)\(investment?.wallet?.profit ?? "0")"
        self.withdrawLbl.text =  "\(kRupeeIcon)\(investment?.wallet?.total_withdrawal ?? "0")"
        self.depositLbl.text = "\(kRupeeIcon)\(investment?.wallet?.total_deposit ?? "0")"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
      
        self.navigationController?.isNavigationBarHidden = true
        fetchAccountData()
         
    }
    func fetchAccountData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NzA3MjE0NywiZXhwIjoxNTY3MDc1NzQ3LCJuYmYiOjE1NjcwNzIxNDcsImp0aSI6InVIZWIyNmhSZG5sWWZheU0iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.-Saz_1BZR3kqfNWHU4-gN5ccmM3_gvOO6G14jjY_ho0",
            "Content-Type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id")]
            NetworkManager.post_Request(urlService: kMYInvestment, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let json = try JSON(data:response as! Data)
                        let result = json["result"]
                        
                            self.investment = InvestMentAnalysis(ijson: result)
//
                        
                        DispatchQueue.main.async{
                            self.setup()
                        }
                    } else {
                        Loader.showAlert(message: "Unable to get Account Data")
                    }
                    
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    

    

}
