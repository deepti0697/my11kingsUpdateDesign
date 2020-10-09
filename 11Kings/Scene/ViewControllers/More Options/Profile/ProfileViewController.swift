//
//  ProfileViewController.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import UIKit
import SwiftyJSON
class ProfileViewController: BaseClass {
    @IBOutlet weak var aPinCodeTextField: UITextField!
    
    @IBOutlet weak var femaleImageView: UIImageView!
    @IBOutlet weak var maleImageView: UIImageView!
    @IBOutlet weak var aChangePasswordTextfield: UITextField!
    @IBOutlet weak var aCityTextField: UITextField!
    @IBOutlet weak var aNameTextField: UITextField!
    @IBOutlet weak var aEmailTextField: UITextField!
    @IBOutlet weak var aPhoneTextField: UITextField!
    @IBOutlet weak var aDataOfBirthField: UITextField!
    @IBOutlet weak var aStateTextField: UITextField!
    @IBOutlet weak var aUpdateButton: UIButton!
    //@IBOutlet weak var aCameraButton: UIButton!
    @IBOutlet weak var aMaleCheckBoxButton: UIButton!
    @IBOutlet weak var aFemaleCheckBoxButton: UIButton!
    
   // var avatarView: AvtarView?
    var userDetailsArray: UserDetailsResponse?
       
          
        
    
//    var avatarDataArray: [AvatarDetails]?
    
    var isMaleButtonSelected: Bool = true {
        didSet {
            if isMaleButtonSelected {
                maleImageView.isHidden = false
               
                femaleImageView.isHidden = true
                maleImageView.backgroundColor =  UIColor(red: 255, green: 253, blue: 166)
                //aMaleCheckBoxButton.backgroundColor = .blue
                aMaleCheckBoxButton.borderColor = UIColor(red: 255, green: 253, blue: 166)
                aMaleCheckBoxButton.borderWidth = 3
//                aFemaleCheckBoxButton.backgroundColor = .white
            } else {
                maleImageView.isHidden = true
                 femaleImageView.isHidden = false
                maleImageView.backgroundColor = .clear
                aFemaleCheckBoxButton.borderColor =  UIColor(red: 255, green: 253, blue: 166)
                aFemaleCheckBoxButton.borderWidth = 3
                femaleImageView.backgroundColor = UIColor(red: 255, green: 253, blue: 166)
                //aFemaleCheckBoxButton.backgroundColor = .blue
               // aMaleCheckBoxButton.backgroundColor = .white
            }
        }
    }
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        femaleImageView.layer.cornerRadius = femaleImageView.frame.size.width/2
        femaleImageView.clipsToBounds = true
        maleImageView.layer.cornerRadius = femaleImageView.frame.size.width/2
        maleImageView.clipsToBounds = true
        fetchUserProfileData()
      //  getAllAvatars()
        setupDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        btnsetup()
               setupUI()
//        addNavigationBar(navigationTitle: "Profile", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func btnsetup() {
        let button = UIButton(type: .custom)
        button.setTitle("Change Password", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 8, green: 117, blue: 183), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        button.frame = CGRect(x: CGFloat(aChangePasswordTextfield.frame.size.width - 30), y: CGFloat(10), width: CGFloat(25), height: CGFloat(25))
        
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        aChangePasswordTextfield.rightView = button
        aChangePasswordTextfield.rightViewMode = .always
    }
    
    @IBAction func changePassword(_ sender: Any) {
        openChangePassword()
    }
    @IBAction func refresh(_ sender: Any) {
//        openChangePassword()
    }

    func setupUI() {
        aStateTextField.setLeftPaddingPoints(10.0)
        aEmailTextField.setLeftPaddingPoints(10.0)
        aCityTextField.setLeftPaddingPoints(10.0)
        aPinCodeTextField.setLeftPaddingPoints(10.0)
        aNameTextField.setLeftPaddingPoints(10.0)
        aPhoneTextField.setLeftPaddingPoints(10.0)
        aChangePasswordTextfield.setLeftPaddingPoints(10.0)
        aDataOfBirthField.setLeftPaddingPoints(10.0)
        aPinCodeTextField.isUserInteractionEnabled = true
        aPhoneTextField.isUserInteractionEnabled = true
        aDataOfBirthField.inputAccessoryView = toolbar
        aDataOfBirthField.inputView = datePicker
        aUpdateButton.setCornerRadiusButton(value: 5)
        aMaleCheckBoxButton.setCornerRadiusButton(value: 13)
        aFemaleCheckBoxButton.setCornerRadiusButton(value: 13)
           
     //   aFemaleCheckBoxButton.clipsToBounds = true
      //  aCameraButton.setCornerRadiusButton(value: 5)
        
        aMaleCheckBoxButton.setBorderButton(color: UIColor(red: 255, green: 253, blue: 166), size: 1.0)
        aFemaleCheckBoxButton.setBorderButton(color:  UIColor(red: 255, green: 253, blue: 166), size: 1.0)
        //aAvatarImageView.setCornerRadiusImageView(value: 35)
       // aAvatarImageView.setBorderImageView(color: .lightGray,size: 1)
        aMaleCheckBoxButton.borderWidth = 3
        aFemaleCheckBoxButton.borderWidth = 3
    }
    
    func configureUserData() {
        guard let userDetails = userDetailsArray else {
            return
        }
//        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                        
//                        let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
//            if let  checkEmail = (UserDic.value(forKey: "email_verify")) {
//                if checkEmail as? Int == -1 || checkEmail as? Int == 0 as Int {
                    aEmailTextField.isEnabled = false
//                }
//                else {
//                      aEmailTextField.isEnabled = false
//                }
//            }
//                if let checkMobile = (UserDic.value(forKey: "mobile_verify")) {
//                    if checkMobile as? Int == -1 || checkMobile as? Int == 0 as Int {
                        aPhoneTextField.isEnabled = false
//                }
//                    else {
//                          aPhoneTextField.isEnabled = false
//                    }
//            }

        if let name = userDetails.username {
            aNameTextField.text = name
        }
        if let dob = userDetails.dob {
            aDataOfBirthField.text = dob
        }
        if let state = userDetails.state {
            aStateTextField.text = state
        }
            
        if let email = userDetails.email {
            aEmailTextField.text = email
        }
        
        if let contact = userDetails.mobile {
            aPhoneTextField.text = "\(contact)"
        }
        if let city = userDetails.city {
            aCityTextField.text = city
        }
        if let pin = userDetails.pincode {
            aPinCodeTextField.text = pin
        }
//        if let imageURL = userDetails.image {
//            let urlStr = imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            let url = URL(string: urlStr ?? "")
//            self.aAvatarImageView.sd_setImage(with: url, completed: nil)
//        } else {
//            self.aAvatarImageView.image = UIImage(named: "avatar")
//        }
        if let gender = userDetails.gender {
            if gender == "male" {
                isMaleButtonSelected = true
            } else {
                isMaleButtonSelected = false
            }
        }
    }
//    }
      func openChangePassword() {
            openViewController(controller: ChangePasswordViewController.self, storyBoard: .signInUpStoryBoard) { (vc) in
    
            }
        }
    func fetchUserProfileData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYuZmFudGFzeXBvd2VyMTEuY29tXC9uZXdfYXBpXC9mcDExXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTg3NDY4MzcyLCJleHAiOjE1ODc0NzE5NzIsIm5iZiI6MTU4NzQ2ODM3MiwianRpIjoiVm9yNVhMOHZXd3hUSzFvdCIsInN1YiI6OTkxMTcsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.Ceh0HxBV_DIRFa_ePcw1YQlSkFfcjC8IXox0xR9gAwo",
            "Accept": "application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                  
                  let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id":UserDic.value(forKey: "user_id")]
        
            NetworkManager.post_Request(urlService: kUserDetailsURL, param: parameters as [String : Any], head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let jsonUser = try JSON(data:response as! Data)
                    let result = jsonUser["result"]
                    let value = result["value"]

                    self.userDetailsArray = UserDetailsResponse(userJson: value)
                    self.configureUserData()
//
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
            }
        }
    }
    func getAllAvatars() {
//        NetworkManager.get_Request(urlService: kAllProfileAvatarsUrl, param: nil, head: nil) { (response) in
//            do {
//                if response != nil {
//                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
//                    let responseModel = try JSONDecoder().decode(AvatarImageResponse.self, from: responseData)
//                    print("Avatar status \(responseModel.status ?? "")")
//                    if let status = responseModel.status {
//                        let statusResponse = status.lowercased()
//                        if statusResponse == "success" {
//                            self.avatarDataArray = responseModel.data
//                        }
//                    }
//                }
//            } catch {
//                Loader.showAlert(message: "Status code 500: server internal error")
//            }
//
//        }
    }
    func updateAvatar(avatarID: Int) {
//        showActivityIndicator(sMessage: "Loading...")
//        let headers = [
//            "content-type": "application/x-www-form-urlencoded",
//            "cache-control": "no-cache"
//        ]
//        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1,"avatar_id": avatarID]
//
//        NetworkManager.post_Request(urlService: kUpdateAvatar, param: parameters, head: headers) { (response) in
//            self.hideActivityIndicator()
//            do {
//                if response != nil {
//                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
//                    let responseModel = try JSONDecoder().decode(AvatarUpdateResponse.self, from: responseData)
//                    if let status = responseModel.status {
//                        if status == "success" {
//                            if let msg = responseModel.message {
//                                self.removeAvatarView()
//                                Loader.showToast(message: msg, onView: self.view, bottomMargin: 100)
//                                self.fetchUserProfileData()
//                            }
//                        } else {
//                            self.removeAvatarView()
//                            Loader.showToast(message: "Unable to update Avatar", onView: self.view, bottomMargin: 100)
//                        }
//                    }
//                }
//            } catch {
//                Loader.showAlert(message: "Status code 500: server internal error")
//            }
//        }
    }
    @IBAction func backTomainVc(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func openAvatarView() {
//        if avatarView == nil {
//            avatarView = Bundle.main.loadNibNamed("AvtarView", owner: self, options: nil)?.first as? AvtarView
//            avatarView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
//            if let data = self.avatarDataArray {
//                avatarView?.avatarDataSource = data
//            }
//            APP_DEL.window?.addSubview(avatarView!)
//            avatarView?.closeButtonClouser = { [weak self] in
//                if let strongSelf = self {
//                    strongSelf.removeAvatarView()
//                }
//            }
//            avatarView?.saveButtonClouser = { [weak self]  id in
//                if let strongSelf = self {
//                    // update Avatar
//                    strongSelf.updateAvatar(avatarID: id)
//                }
//            }
        //}
    }
    func UpdateProfileData() {
        guard let  userDetailsArray = userDetailsArray else {
            return
        }
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/json",
            "Accept":"application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
        
        let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let userName = aNameTextField.text ?? userDetailsArray.username ?? ""
            let dob = aDataOfBirthField.text ?? userDetailsArray.dob ?? ""
            let state = aStateTextField.text ?? userDetailsArray.state ?? ""
            let mobile = aPhoneTextField.text ?? "\(userDetailsArray.mobile ?? 0)"
            let team = userDetailsArray.team ?? "\(mobile)"
        let gender = isMaleButtonSelected ? "male" : "female"
            let pincode = aPinCodeTextField.text ?? "\(userDetailsArray.pincode ?? "0")"
            let city = aCityTextField.text ?? "\(userDetailsArray.city ?? "0")"
            let email = aEmailTextField.text ?? userDetailsArray.email
            let parameters = ["user_id": UserDic.value(forKeyPath: "user_id"),"username": userName,"dob": dob,"gender": gender,"address": "","city": city,"state":state,"pincode": pincode,"team": team,"mobile": mobile, "email": email]
        
            NetworkManager.post_Request2(urlService: kEditprofileURL, param: parameters as [String : Any], head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let json = try JSON(data:response as! Data)
                   let status = json["status"]
                    let message = json["message"].stringValue
                    if status == 1 {
                            self.popViewController()
                            Loader.showToast(message: message , onView: self.view, bottomMargin: 100, color: UIColor(red: 49, green: 139, blue: 22))
                        } else {
                            self.popViewController()
                            Loader.showToast(message: message ?? "Unable to update the details", onView: self.view, bottomMargin: 100, color: UIColor(red: 240, green: 75, blue: 80))
                        }
                    }
                }
             catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    }
    fileprivate func removeAvatarView() {
        fetchUserProfileData()
//        avatarView?.removeFromSuperview()
//        avatarView = nil
    }
    
    private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func maleBtnAction(_ sender: UIButton) {
        sender.provideVisualFeedback(sender)
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

            UIView.animate(withDuration: 2.0,
                                       delay: 0,
                                       usingSpringWithDamping: CGFloat(0.20),
                                       initialSpringVelocity: CGFloat(6.0),
                                       options: UIView.AnimationOptions.allowUserInteraction,
                                       animations: {
                                        sender.transform = CGAffineTransform.identity
                },
                                       completion: { Void in()  }
            )
        
        self.view.endEditing(true)
        isMaleButtonSelected = true
    }
    @IBAction func femaleBtnAction(_ sender: UIButton) {
        sender.provideVisualFeedback(sender)
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

                   UIView.animate(withDuration: 2.0,
                                              delay: 0,
                                              usingSpringWithDamping: CGFloat(0.20),
                                              initialSpringVelocity: CGFloat(6.0),
                                              options: UIView.AnimationOptions.allowUserInteraction,
                                              animations: {
                                               sender.transform = CGAffineTransform.identity
                       },
                                              completion: { Void in()  }
                   )
               
        self.view.endEditing(true)
        isMaleButtonSelected = false
    }
    @IBAction func updateBtnAction(_ sender: UIButton) {
        self.view.endEditing(true)
        UpdateProfileData()
    }
    
    @IBAction func avtarBtnAction(_ sender: UIButton) {
        self.view.endEditing(true)
        openAvatarView()
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupDatePicker() {
        datePicker.datePickerMode = .date
        toolbar.sizeToFit()
        let calendar = Calendar.current
        var components = DateComponents()
        components.calendar = calendar
        components.year = -18
        let maxDate = calendar.date(byAdding: components, to: Date())
        datePicker.maximumDate = maxDate
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        aDataOfBirthField.text = formatter.string(from: datePicker.date)
        aDataOfBirthField.resignFirstResponder()
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func stateButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        presentPopOverController(sender: sender)
    }
    
    fileprivate func presentPopOverController(sender: UIButton) {
        let storyBoard = UIStoryboard(name: "More", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PopoverViewController") as! PopoverViewController
        vc.preferredContentSize = CGSize(width: self.view.frame.width - 100, height: self.view.frame.height - 200)
        vc.modalPresentationStyle = .popover
        if let pres = vc.presentationController {
            pres.delegate = self
        }
        self.present(vc, animated: true)
        vc.stateSelectionClousure = { [weak self] state in
            self?.aStateTextField.text = state
            DispatchQueue.main.async {
                vc.dismiss(animated: false, completion: nil)
            }
        }
        if let pop = vc.popoverPresentationController {
            pop.sourceView = (sender as UIView)
            pop.sourceRect = (sender as UIView).bounds
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
// MARK: PopOver Delegate Method
extension ProfileViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
