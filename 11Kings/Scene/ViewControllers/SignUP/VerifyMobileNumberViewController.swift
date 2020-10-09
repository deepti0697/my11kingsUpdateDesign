//
//  VerifyMobileNumberViewController.swift
//  DreamTeam
//
//  Created by Test on 08/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON
class VerifyMobileNumberViewController: BaseClass {
   
    
    
    @IBOutlet weak var otpContainerView: UIView!
    var mobileNumber = ""
    var isFromVerifyMobileVC = false
      var verificationType = ""
      var isFromForgotPassword = false
    let otpStackView = OTPStackView()
    @IBOutlet weak var wehavesendOtp: UILabel!
    @IBOutlet weak var verifyMblNoLbl: UILabel!
    @IBOutlet weak var mobileNolbl: UILabel!
    @IBOutlet weak var didntReciveOtpLbl: UILabel!
    
    @IBOutlet weak var resendOtp: UIButton!
    
    @IBOutlet weak var continueToNext: UIButton!
    var otpString:String?
    var storeMobileData:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavigationBar()
      
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        hidenavigationBackButton()
        setUp()
          navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    func  checkAllTextField() {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    func setUp(){
        
        otpContainerView.addSubview(otpStackView)
        otpStackView.delegate = self
        otpStackView.heightAnchor.constraint(equalTo:
            otpContainerView.heightAnchor).isActive = true
        otpStackView.centerXAnchor.constraint(equalTo: otpContainerView.centerXAnchor).isActive = true
        otpStackView.centerYAnchor.constraint(equalTo: otpContainerView.centerYAnchor).isActive = true
        if mobileNumber != "" {
            mobileNolbl.text = "91+" + mobileNumber
        }
        else {
            mobileNolbl.text =  "91+ \(storeMobileData ?? "")"
        }

        verifyMblNoLbl.text = StringConstant.verifyMblNo
        wehavesendOtp.text = StringConstant.weHavesentanOtponyouNumberr
        didntReciveOtpLbl.text = StringConstant.didntRecevetheOTP
        resendOtp.setTitle(StringConstant.resendOtp, for: .normal)
        continueToNext.setTitle(StringConstant.continuetoNext, for: .normal)
        mobileNolbl.addLine(position: .LINE_POSITION_BOTTOM, color:UIColor(red: 255, green: 253, blue: 166, alpha: 1), width: 1)
       
        
        
    }
    
    @IBAction func continueTOVerify(_ sender: Any) {
        if isFromVerifyMobileVC  {
            verifyOTPForMobile()
        }
        else {
           verifyOTPForForgotPassword()
        }
        
    }
    
    fileprivate func verifyOTPForMobile() {
           
           showActivityIndicator(sMessage: "Loading...")
           let headers = ["Content-Type":"application/json",
           "Accept" :"application/json"]
           
           if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
               
               let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
               let param = ["mobile": UserDic.value(forKey: "mobile") ?? "",
                            "user_id":UserDic.value(forKey: "user_id") ?? "",
                            "otp":otpString ?? "" ,
                            "custom_user_token": UserDic.value(forKey: "custom_user_token") ?? ""]
            NetworkManager.post_Request2(urlService: kVeriftyMobile, param: param, head: headers) {
                
                (response) in
                 self.hideActivityIndicator()
                do {
                    let jsonResponse = try JSON(data:response as! Data)
                    let status = jsonResponse["status"].intValue
                    let message = jsonResponse["message"].stringValue
                    if status == 1 {
                        self.view.makeToast(message: message)
                        self.navigationController?.popViewController(animated: true)
                    }
                    else {
                        self.view.makeToast(message: message)
                    }
                }
                catch {
                    self.view.makeToast(message: "Status code 500: server internal error")
                }
            }
              
           }
       }
       
    
    fileprivate func verifyOTPForForgotPassword() {
        
        showActivityIndicator(sMessage: "Loading...")
        let headers = ["Content-Type":"application/json",
        "Accept" :"application/json"]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginDataTemp") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["mobile": UserDic.value(forKey: "mobile") ?? "",
                         "user_id":UserDic.value(forKey: "user_id") ?? "",
                         "otp":otpString ?? "" ,
                         "custom_user_token": UserDic.value(forKey: "custom_user_token") ?? ""]
            guard let urlString = URL(string: kBASE_URL + kverifyMobileOnRegister) else {

                                        return
                                    }
            Alamofire.request(urlString, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
                self.hideActivityIndicator()
                let json = response.result.value as? NSDictionary
                
                if json != nil{
                    let json : NSDictionary = response.result.value as? NSDictionary ?? [:]
                    // print(json)
                    let status = json.value(forKey: "status") as? Int ?? 0
                    let message = json.value(forKey: "message") as? String ?? ""
                    if status == 1 { // for Success
                
                        UserDefaults.standard.set(true, forKey: kLoggedIn)
                        let UserDataDic = json.value(forKey: "result") as? NSDictionary ?? [:]
                        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: UserDataDic), forKey: "loginData")
                        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                                   
                                   let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                            let user = UserDic.value(forKey: "user_id")
                            UserDefaults.standard.set(user, forKey: kUserId)
                        APP_DEL.openInitialViewController()
                        }
                       // Loader.showToast(message: message , onView: self.view, bottomMargin: 200)
                       
                        
                        
                    }else{
                        self.view.makeToast(message: message)
                        
                    }
                }
                    
                else{
                     Loader.showAlert(message: "Status code 500: server internal error")
                    //Show SnackBar Alert
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
    @IBAction func resendOTp(_ sender: Any) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = ["Content-Type":"application/json",
               "Accept" :"application/json"]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
        let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["mobile": UserDic.value(forKey: "mobile") ?? "",
                         "user_id":UserDic.value(forKey: "user_id") ?? "",
                         "type":"2"]
            
           
            
            NetworkManager.post_Request2(urlService: kSendNewOtp, param: param as [String : Any], head: headers) { (response) in
            self.hideActivityIndicator()
                do {
                    let jsonResp = try JSON(data:response as! Data)
                                   let status = jsonResp["status"].intValue
                                   let jsonMesage = jsonResp["message"].stringValue
                    if status == 1 {
                        self.view.makeToast(message: jsonMesage)
                    }
                    else {
                        self.view.makeToast(message: jsonMesage)
                    }
                }
                catch {
                    self.view.makeToast(message: "Internal Error")
                }
               
                
            }
        }
    }
    
}
extension VerifyMobileNumberViewController: OTPDelegate {
    func getOtpText(text: String) {
        otpString = text
    }
    
    
    
    func didChangeValidity(isValid: Bool) {
        
    }
    
}

