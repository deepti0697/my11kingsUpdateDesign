//
//  ContestInviteCodeViewController.swift
//  DreamTeam
//
//  Created by Test on 18/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class ContestInviteCodeViewController: BaseClass {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var aContainerView: UIView!
        @IBOutlet weak var aTextField: UITextField!
        @IBOutlet weak var aJoinButton: UIButton!
        
        var closeButtonClouser: (() -> Void) = { }
        var joinContestButtonClouser: ((String) -> Void) = { _ in }
        var containerYposition: CGFloat = 0
        
    override func viewDidLoad() {
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor(red: 255, green: 253, blue: 166).cgColor,UIColor(red: 172, green: 135, blue: 54).cgColor]
        newLayer.frame = upperView.frame
        upperView.layer.addSublayer(newLayer)
        super.viewDidLoad()
        setupDefaultNavigationBar()
        UIBarButtonItem.appearance().tintColor = UIColor.black
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
        @IBAction func joinContestButtonAction(_ sender: UIButton) {
            if aTextField.text != "" {
                getopenCode(code: aTextField.text ?? "")
            } else {
                Loader.showToast(message: "Enter Contest Code", onView: self.view, bottomMargin: 200, color: UIColor.black.withAlphaComponent(0.6)
    )
            }
        }
        
        @IBAction func closeButtonAction(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }

        
        fileprivate func getopenCode(code:String) {
                showActivityIndicator(sMessage: "Loading...")
                let headers = [
                    "content-type": "application/json",
                    "Accept": "application/json"]
                
                
                
             //   let parameters = ["user_id": , "getcode": code] as [String : Any]
                
                if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                    
                    let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                    let param = ["user_id":UserDic.value(forKey: "user_id"),
                                 "getcode":code]
                     NetworkManager.post_Request2(urlService: kJoinedByCode, param: param as [String : Any], head: headers)  { (response) in
                  
                        self.hideActivityIndicator()
                        guard let data = response else { return }
                        do{
                            let json = try JSON(data:data as! Data)
                            //                 let list = MyCatagries(json: json)
                            let status = json["status"].intValue
                            let results = json["message"].stringValue
                            
                            
        //                    let messageStr =   MessageResponses(json:results)
                            
                            if status == 1 {
                                
                                Loader.showToast(message:  results, onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 22)
                                                   )
                                self.navigationController?.popViewController(animated: true)
                                                 
                            }
                            else {
                                Loader.showToast(message: results , onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80)
                                                                         )
                                self.navigationController?.popViewController(animated: true)
                                                                                
                           
                            }
                            
                        }
                            
                            
                            
                        catch{
                            self.view.makeToast(message: "Internal Error")
                        }
                    }
                    
                    
                }
            }
        
        
       
    }
