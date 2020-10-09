//
//  ForgotPasswordViewController.swift
//  DreamTeam
//
//  Created by Test on 08/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON
class ForgotPasswordViewController: BaseClass {
    
   
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var weAreHeretoHelpYouLbl: UILabel!
   
    @IBOutlet weak var forgotPassword: UILabel!
    @IBOutlet weak var emailTextFeild: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        // Do any additional setup after loading the view.
         setupDefaultNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    /// Basic UI Setup
    func setup() {
        

        emailTextFeild.setLeftPaddingPoints(10.0)

        nextBtn.setTitle(StringConstant.next, for: .normal)
    }
   
    
    /// ForgotPassword Api
    fileprivate func forgotPasswordAction() {
        self.showActivityIndicator(sMessage: "Loading")
        let email = emailTextFeild.text ?? ""
        let parameters = ["email" : email]
        let head = ["Content-Type":"application/json",
                    "Accept" :"application/json"]
        NetworkManager.post_Request2(urlService: kForgotPassword, param: parameters as [String : Any], head: head) { (response) in
            self.hideActivityIndicator()
            do {
                let response = try JSON(data:  response as! Data)
                let jsonStatus = response["status"].intValue
                let jsonMessage = response["message"].stringValue
                if jsonStatus == 1 {
                    
                    self.navigationController?.popViewController(animated: true)
                    self.view.makeToast(message: "Reset Email Sent")
                }
                else {
                    self.view.makeToast(message: jsonMessage)
                }
            }
            catch {
                Loader.showAlert(message: "Internal Error")
            }
        }
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        forgotPasswordAction()
    }
    @IBAction func backToLoginPage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
}


extension ForgotPasswordViewController {
    //MARK: Validation
    private func validateEmailFields() -> String {
        var message = ""
        if let text = emailTextFeild.text, !text.trimmingCharacters(in: .whitespaces).isEmpty && Validation.isValid(email: text) {
            message = ""
        } else {
            message = "Please Enter Correct Email"
            return message
        }
        return message
    }
    
}

// MARK: - TextFiled Delegate Methods.
extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func setupUIForTextfield(resultString: String = "") {
        if emailTextFeild.text != "" || resultString != "" {
            emailTextFeild.isHidden = false
        } else {
            emailTextFeild.isHidden = true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailTextFeild:
            emailTextFeild.isHidden = false
        default:
            break
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextFeild:
            emailTextFeild.isHidden = true
            setupUIForTextfield()
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setupUIForTextfield()
        if emailTextFeild.isFirstResponder {
            self.view.endEditing(true)
        }
        return true
    }
}
