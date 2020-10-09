//
//  NotificationViewController.swift
//  
//
//  Created by Test on 11/06/20.
//

import UIKit
import  SwiftyJSON
class NotificationViewController: BaseClass {

    @IBOutlet weak var aTableView: UITableView!
    var notificationArray = [NotificationArray]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aTableView.delegate = self
        self.aTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        hitNotification()
    }
    override func handleBackButtonAction() {
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    @IBAction func backButton(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    
    func hitNotification() {
        self.showActivityIndicator(sMessage: "Loading")
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                      
                      let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let headers = ["Content-Type":"application/x-www-form-urlencoded","Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTYxMzU0MSwiZXhwIjoxNTY1NjE3MTQxLCJuYmYiOjE1NjU2MTM1NDEsImp0aSI6IkNhRHlnUDZSY3JncEZPWEgiLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.WPidN5P8VVDgFzLGBHxj5rXKeEPLvW0Fz2nDph8pg1A","Accept":"application/json"]
            let param = [  "user_id": UserDic.value(forKey: "user_id")]
            NetworkManager.post_Request(urlService: kNotification, param: param, head: headers) { (response) in
            self.hideActivityIndicator()
                do {
                    let jsonRespnse = try JSON(data:response as? Data ?? Data())
                    let resultData = jsonRespnse["result"]
                    let status = jsonRespnse["status"].intValue
                    if status == 1 {
                    self.notificationArray.removeAll()
                    for arr in resultData.arrayValue {
                        self.notificationArray.append(NotificationArray(json: arr))
                    }
                        if self.notificationArray.count  == 0 {
                            self.aTableView.separatorStyle = .none
                        self.view.makeToast(message: "No Notification you got yet")
                        }
                    self.aTableView.reloadDataInMainQueue()
                    }
                }
                catch {
                    self.view.makeToast(message: "Inter Error ")
                }
                
            
        }
    }
  

}
}
extension NotificationViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = aTableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        cell.eventName.text = notificationArray[indexPath.row].title
        cell.dateLbl.text = notificationArray[indexPath.row].created_at
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
