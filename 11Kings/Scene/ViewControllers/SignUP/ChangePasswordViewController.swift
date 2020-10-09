//
//  ChangePasswordViewController.swift
//  DreamTeam
//
//  Created by Test on 08/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import PasswordTextField
import SwiftyJSON
import SwiftToast
class ChangePasswordViewController: BaseClass {
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var oldPasswordtxtfield: PasswordTextField!
    @IBOutlet weak var cofirmPasswordTextField: PasswordTextField!
    @IBOutlet weak var newPasswordTextField: PasswordTextField!
    
      var messageResponse:MessageResponse?
      var checkFromupdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    
    func setUp() {
        oldPasswordtxtfield.customHideSecureTextImage = #imageLiteral(resourceName: "view_2")
        oldPasswordtxtfield.customShowSecureTextImage = #imageLiteral(resourceName: "view")
        cofirmPasswordTextField.customHideSecureTextImage = #imageLiteral(resourceName: "view_2")
        cofirmPasswordTextField.customShowSecureTextImage = #imageLiteral(resourceName: "view")
        newPasswordTextField.customShowSecureTextImage = #imageLiteral(resourceName: "view_2")
        newPasswordTextField.customHideSecureTextImage = #imageLiteral(resourceName: "view")
        cofirmPasswordTextField.borderStyle = .none
        newPasswordTextField.borderStyle = .none
        
        
    }
    
    @IBAction func backtoForgotPasswordScreen(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func savePasswordBtn(_ sender: Any) {
        let passwordValidationRes = validatePasswordFields()
        let confirmPasswordValidationRes = validateConfirmPassword()
        if passwordValidationRes != "" {
            Loader.showToast(message: passwordValidationRes, onView: view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
        } else if confirmPasswordValidationRes != "" {
            Loader.showToast(message: confirmPasswordValidationRes, onView: view, bottomMargin: 200, color: .red)
        }
        else {
            ChangePAssword()
        }
        
        
    }
    func ChangePAssword() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/json",
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYuZmFudGFzeXBvd2VyMTEuY29tXC9uZXdfYXBpXC9mcDExXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTg3NDY4MzcyLCJleHAiOjE1ODc0NzE5NzIsIm5iZiI6MTU4NzQ2ODM3MiwianRpIjoiVm9yNVhMOHZXd3hUSzFvdCIsInN1YiI6OTkxMTcsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.Ceh0HxBV_DIRFa_ePcw1YQlSkFfcjC8IXox0xR9gAwo",
            "Accept": "application/json",
            "cache-control": "no-cache"
        ]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let oldpassword = oldPasswordtxtfield.text
            let newpassword = newPasswordTextField.text
            let parameters = ["user_id":UserDic.value(forKey: "user_id"),"oldpassword":oldpassword,"newpassword":newpassword]
            
            NetworkManager.post_Request2(urlService: changePassword, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let jsonUser = try JSON(data:response as! Data)
                        let status = jsonUser["status"]
                        let message = jsonUser["message"].stringValue
                        if status == 1 {
                            self.popViewController()
                            Loader.showToast(message: message , onView: self.view, bottomMargin: 100, color: UIColor(red: 49, green: 139, blue: 22))
                        } else {
                            self.popViewController()
                            Loader.showToast(message: message, onView: self.view, bottomMargin: 100, color: UIColor(red: 240, green: 75, blue: 80))
                        }
                    }
                }   catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    
    private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func validatePasswordFields() -> String {
        var message = ""
        if let text = newPasswordTextField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty && Validation.isValid(password: text) {
            message = ""
        } else {
            message = "Please Enter Correct Password"
            return message
        }
        return message
    }
    
    private func validateConfirmPassword() -> String {
        var message = ""
        if newPasswordTextField.text == cofirmPasswordTextField.text {
            return message
        } else {
            message = "Password Field Mismatch"
            return message
        }
    }
}
