//
//  LoginViewController.swift
//  DreamTeam
//
//  Created by Test on 07/05/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import SwiftyJSON
import UIKit
import AuthenticationServices
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import PasswordTextField
import MBProgressHUD
import Alamofire

class LoginViewController: BaseClass {
    
    @IBOutlet weak var AppleLoginBtn: UIButton!
    @IBOutlet weak var nothaveAccountLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var orLblSidelineview: UIView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var orLblRightSideView: UIView!
    @IBOutlet weak var regiterNowBtn: UIButton!
    @IBOutlet weak var forgotPasswordbtn: UIButton!
    @IBOutlet weak var passwordPlaceHolderText: UILabel!
    @IBOutlet weak var userNamePlaceHolderText: UILabel!
    @IBOutlet weak var welcomeBackLbl: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    var userName = "";
    var SocialEmail = "";
    let viewModel = LoginViewModel()
    var appleId = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        storeConstantData()
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setup()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupApple()
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func appleAction(_ sender: Any) {
        self.setupApple()
    }
    
    func setup() {
        stackView.spacing = 5
//        pass
        passwordTextField.customHideSecureTextImage = #imageLiteral(resourceName: "ic_Password_view")
        passwordTextField.customShowSecureTextImage = #imageLiteral(resourceName: "view")
        userNameTextField.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor.FlatColor.Grey.lightGrey, width: 0.5)
        passwordTextField.addLine(position: .LINE_POSITION_BOTTOM, color: UIColor.FlatColor.Grey.lightGrey, width: 0.5)
        bottomline(btn: regiterNowBtn, color: UIColor(red:255,green:195,blue:145), height: 0.5)
        bottomline(btn: forgotPasswordbtn, color: UIColor(red:255,green:195,blue:145), height: 0.5)
        
    }
    
    
    func storeConstantData() {
        welcomeBackLbl.text = StringConstant.welcomeBack
        userNamePlaceHolderText.text = StringConstant.userName
        passwordPlaceHolderText.text = StringConstant.password
        forgotPasswordbtn.setTitle(StringConstant.forgotpassword, for: .normal)
        regiterNowBtn.setTitle(StringConstant.registerNow, for: .normal)
        nothaveAccountLabel.text = StringConstant.nothaveAccount
    }
    // MARK: - IBAction
       @IBAction func didTapSignInButton(_ sender: Any) {
           self.view.endEditing(true)
           let emailValidationRes = validateEmailFields()
           if emailValidationRes == "" {
               loginAction()
           }
           else {
               
               self.view.makeToast(message: emailValidationRes)
           }
       }
  
       @IBAction func didTapFacebookButton(_ sender: Any) {
           handleFacebookAuthentication()
           //  getFBUserData()
       }
       
       @IBAction func didTapGoogleButton(_ sender: Any) {
           handleGoogleAuthentication()
       }
       
       
       @IBAction func forgotPasswordAction(_ sender: Any) {
           let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
           
           self.navigationController?.pushViewController(secondViewController, animated: true)
       }
       
    @IBAction func registerNowBtn(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
 
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    

     // MARK: - This Method will perform LoginAction UserWill Redirect to HomeSCreen
    fileprivate func loginAction() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = ["Content-Type":"application/json",
                       "Accept" :"application/json"]
        var loginParams: [String : Any]? = [:]
        loginParams?["email"] = userNameTextField.text
        loginParams?["password"] = passwordTextField.text
        loginParams?["appid"] = ""
        loginParams?["device_id"] = ""
        if Connectivity.isConnectedToInternet {
            guard let urlString = URL(string: kBASE_URL + kLoggedIn) else {
                
                return
            }
            Alamofire.request(urlString, method: .post, parameters: loginParams, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
                self.hideActivityIndicator()
                let json = response.result.value as? NSDictionary
                
                if json != nil{
                    let json : NSDictionary = response.result.value as? NSDictionary ?? [:]
                    // print(json)
                    let status = json.value(forKey: "status") as? Int ?? 0
                    let message = json.value(forKey: "message") as? String ?? ""
                    if status == 1 { // for Success
                    
                        // Saved Registered User Data
                        let UserDataDic = json.value(forKey: "result") as? NSDictionary ?? [:]
                        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: UserDataDic), forKey: "loginData")
                        
                        // Get Login User Data
                        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                            
                            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                            
                            //                        UserDefaults.standard.set(UserDefaults.value(forKey: "user_id", forKey: kUserId)
                            let kuser = UserDic.value(forKey: kUserId)
                            UserDefaults.standard.set(kuser, forKey: kUserId)
                            UserDefaults.standard.set(true, forKey: kLoggedIn)
                            APP_DEL.openInitialViewController()
                            
                        }
                        
                    }else{
                        
                        self.view.makeToast(message: message)
                        //Show SnackBar Alert
                        
                    }
                }
                    
                else{
                    self.view.makeToast(message: "Server Error")
                }
            }
            
        }
        else {
            self.view.makeToast(message: "Check your internet Connectivity")
        }
    }

}

// MARK: - Login with facebook
extension LoginViewController {
    
    /// Our custom functions
    private func handleFacebookAuthentication() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email"], from: self) { (result, error) in
            if error != nil {
                self.showPopup(isSuccess: false, type: .facebook)
                return
            }
            guard let token = AccessToken.current else {
                print("Failed to get access token")
                self.showPopup(isSuccess: false, type: .facebook)
                return
            }
            self.viewModel.token = token.appID
            
            GraphRequest(graphPath: "me", parameters: ["fields" : "first_name, last_name, gender, id, name, email,picture"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil), let result = result as? [String: Any]
                    
                {
                    if let fields = result as? NSDictionary {
                        print("\(fields.description)")
                        
                       
                        let imageURL = ((fields["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String
                        let dict = ["email": fields.value(forKey: "email") ?? "",
                                    "name": fields.value(forKey: "name") ?? "",
                                    "provider":"Facebook",
                                    "image": imageURL ?? "" ,
                                    "dob":"",
                                    "appid": "",
                                    "fcmToken":self.viewModel.token ?? "",
                                    "device_id": ""]
                        self.socialLoginAction(parm: dict as NSDictionary)
                    }
                }
            })
        }
    }
  
    /// This Method will help to login Using Facebook and Google
    /// - Parameter parm: parameters is Dictionary which passes to the parameters to SocialLogin API
    fileprivate func socialLoginAction(parm: NSDictionary) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        
        guard let urlString = URL(string: kBASE_URL + kSocialLoginURL) else {
            
            return
        }
        Alamofire.request(urlString, method: .post, parameters: parm as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            self.hideActivityIndicator()
            let json = response.result.value as? NSDictionary
            
            if json != nil{
                let json : NSDictionary = response.result.value as? NSDictionary ?? [:]
                // print(json)
                let status = json.value(forKey: "status") as? Int ?? 0
                let message = json.value(forKey: "message") as? String ?? ""
                if status == 1 { // for Success
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    // Saved Registered User Data
                    let UserDataDic = json.value(forKey: "result") as? NSDictionary ?? [:]
                    UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: UserDataDic), forKey: "loginData")
                    
                    // Get Login User Data
                    if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                        
                        let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                        
                        
                        let kuser = UserDic.value(forKey: kUserId)
                        UserDefaults.standard.set(kuser, forKey: kUserId)
                        
                        UserDefaults.standard.set(true, forKey: kLoggedIn)
                        APP_DEL.openInitialViewController()
                        
                    }
                }else{
                    self.view.makeToast(message:message)
                    MBProgressHUD.hide(for: self.view, animated: true)
                    //Show SnackBar Alert
                    
                }
            }
                
            else{
                MBProgressHUD.hide(for: self.view, animated: true)
                //Show SnackBar Alert
            }
        }
        
    }
    
}

// MARK: - Login with google
extension LoginViewController: GIDSignInDelegate {
    
    /// Our custom functions
    private func handleGoogleAuthentication() {
        GIDSignIn.sharedInstance()?.clientID = "501796976425-v2dhjhhtmevpap6ela07crih5t40am7j.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    /// Required functions from protocols
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            let fullName = user.profile.name
            let email = user.profile.email
            
            //  let image = user.profile.imageURL(withDimension: 100)
            let dict = ["email": email ?? "",
                        "name": fullName ?? "",
                        "provider":"Google",
                        "image":  "",
                        "dob":"",
                        "appid": "",
                        "code":"",
                        "device_id": ""] as [String : Any]
            self.socialLoginAction(parm: dict as NSDictionary)
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
}
// MARK: - Show result
extension LoginViewController: LoginResultProtocol {
    
    func showPopup(isSuccess: Bool, user: User? = nil, type: LoginType) {
        let successMessage = "Congratulation! \(user?.username ?? ""). You logged in successully with \(type.name). "
        let errorMessage = "Something went wrong. Please try again"
        let alert = UIAlertController(title: isSuccess ? "Success": "Error", message: isSuccess ? successMessage: errorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func success(user: User?, type: LoginType) {
        showPopup(isSuccess: true, user: viewModel.user, type: type)
    }
    
    func error(error: Error, type: LoginType) {
        showPopup(isSuccess: false, type: type)
    }
}

extension LoginViewController {
    //MARK: Validation
    private func validateEmailFields() -> String {
        var message = ""
        if let text = userNameTextField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty && Validation.isValid(email: text) {
            message = ""
        } else {
            message = "Please Enter Correct Email"
            return message
        }
        return message
    }
    
    
}
extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if userNameTextField.isFirstResponder {
            userNameTextField.resignFirstResponder()
            
        }
        return true
    }
}
extension LoginViewController : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    
    func setupApple(){
        let countryLocale = NSLocale.current
        var countryCode = "";
        if(countryLocale.regionCode != nil)
        {
            countryCode = countryLocale.regionCode!
        }
        print("Co: \(countryCode)")
        
      
        
        if(countryCode != "IN")
        {
        if #available(iOS 13.0, *)
        {
            self.AppleLoginBtn.isHidden = false;
            let authorizationButton = ASAuthorizationAppleIDButton(type: .default, style: .white)
            
            authorizationButton.translatesAutoresizingMaskIntoConstraints = false
            authorizationButton.addTarget(self, action:     #selector(handleLogInWithAppleIDButtonPress), for: .touchUpInside)
            
            AppleLoginBtn.addSubview(authorizationButton)
            NSLayoutConstraint.activate([
                authorizationButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1),
                authorizationButton.heightAnchor.constraint(equalToConstant: 40),
                authorizationButton.widthAnchor.constraint(equalToConstant: self.AppleLoginBtn.frame.size.width - 20)
                   ])
    }
            
        }
    }
    @objc private func handleLogInWithAppleIDButtonPress() {
        if #available(iOS 13.0, *) {
            
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
                
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    private func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        if #available(iOS 13.0, *) {
            let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest()]
            // Create an authorization controller with the given requests.
            let authorizationController = ASAuthorizationController(authorizationRequests: requests)
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print(error)
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        print("Cred 1: \(authorization)")
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            self.appleId = "";
            self.userName = "";
            self.SocialEmail = "";
            
            //Apple ID
            let userIdentifier = appleIDCredential.user
            self.appleId = userIdentifier
            
            //User Name
            var userFirstName = "";
            if(appleIDCredential.fullName?.givenName != nil)
            {
                userFirstName = "\(appleIDCredential.fullName!.givenName!)"
            }
            
            var userLastName = "";
            if(appleIDCredential.fullName?.familyName != nil)
            {
                userLastName = "\(appleIDCredential.fullName!.familyName!)"
            }
            
            var UserFullName = "\(userFirstName) \(userLastName)"
            UserFullName = UserFullName.trim()
            if(UserFullName.count == 0)
            {
                self.userName = "\(self.appleId)"
            }
            else
            {
                self.userName = UserFullName
            }
            
        
            
            print("Cred: \(appleIDCredential)")
            print("Add ID:\(self.appleId)")
            print("User Name: \(self.userName)")
            
            let userEmail = appleIDCredential.email
            if(userEmail != nil)
            {
                self.SocialEmail = userEmail!
            }
            
            
            
            print("Email: \(self.SocialEmail)")
            if(self.SocialEmail.count == 0)
            {
                self.SocialEmail = "\(userFirstName)"
            }
         
            let dict = ["email": SocialEmail ,
                        "name": userName ,
                        "provider":"Apple",
                        "image":  "",
                        "dob":"",
                        "appid": appleId,
                        "code":"",
                        "device_id": ""] as [String : Any]
            
            self.socialLoginAction(parm: dict as NSDictionary)
            
            //Navigate to other view controller
        } else {
            
        }
    }
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines);
    }
}
