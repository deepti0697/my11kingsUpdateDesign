//
//  VerifyAccountViewController.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import UIKit
import Alamofire
import SwiftyJSON
class VerifyAccountViewController: BaseClass, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var panOutlt: UIButton!
    @IBOutlet weak var bankOutlt: UIButton!
    @IBOutlet weak var mobileAndEmailOutlt: UIButton!
    @IBOutlet weak var aSelectionView: UIView!
    @IBOutlet weak var aCollectionView: UICollectionView!
     
    var uploadData = [uploadImage]()
    var didSelectClousure: ((Int) -> Void) = { _ in }
    
    var visibleCellIndex = 0 {
        didSet {
            moveSelectionView(index: visibleCellIndex)
        }
    }
    var msgRspnse:MessageResponses?
    var allVerifyRes:AllVerifyResponses?
    var isMobileVerified = false
    var isPanVerified = false
    var isBankVerified = false
    var isEmailVerified = false
    var isPanImageAdded = false
    var isBankImageAdded = false
    var bankImage: UIImage?
    var panImage: UIImage?
    var imageUploadStatus:UploadImageUIView?
    var tempCellType: AccountCellType = .pancardCellType
    var imagePicker = UIImagePickerController()
    var bankUploadedImageURL = ""
    var panUploadedImageURL = ""
    var isPanUnderReview = false
    var isBankUnderReview = false
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        addNavigationBar(navigationTitle: "Verify Account", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
//        callAllVerifyAPI()
        APP_DEL.accountName = ""
        APP_DEL.acocuntNumber = ""
        APP_DEL.ifscAccount = ""
        APP_DEL.amountBank = ""
         APP_DEL.panName = ""
        APP_DEL.panNumber = ""
         APP_DEL.panDob = ""
        self.navigationController?.isNavigationBarHidden = true
    callAllVerifybyJSon()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    fileprivate func openChangePasswordView() {
        if imageUploadStatus == nil {
            imageUploadStatus = Bundle.main.loadNibNamed("UploadImageUIView", owner: self, options: nil)?.first as? UploadImageUIView
            imageUploadStatus?.center = self.view.center
//            imageUploadStatus?.closeButtonClouser = { [weak self] in
//                if let strongSelf = self {
//                    strongSelf.removeChangePassView()
//                }
//            }
            APP_DEL.window?.addSubview(imageUploadStatus!)
        }
    }
    fileprivate func removeChangePassView() {
        imageUploadStatus?.removeFromSuperview()
        imageUploadStatus = nil
        
    }
    func callAllVerifybyJSon() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTU5MTM3MywiZXhwIjoxNTY1NTk0OTczLCJuYmYiOjE1NjU1OTEzNzMsImp0aSI6InEwNFJpdFc5dXBua080bU8iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.eSHL2YHOeqthUpUnJ1F8Pk5kkUpH4nUHhZ_DBGOJRus",
            "Accept": "application/json",
            "cache-control": "no-cache"
        ]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id":UserDic.value(forKey: "user_id") ]
            NetworkManager.post_Request(urlService: kAllVerify, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let json =  try JSON(data: response as! Data)
                        let result = json["result"]
                        self.allVerifyRes = AllVerifyResponses(json: result)
                        self.isMobileVerified = self.allVerifyRes?.mobile_verify == 1 ? true : false
                        if self.allVerifyRes?.pan_verify == -1 || self.allVerifyRes?.pan_verify == 2  {
                            self.isPanVerified = false
                            self.isPanUnderReview = false
                        }
                        else {
                            
                              self.isPanVerified = self.allVerifyRes?.pan_verify == 1 ? true : false
                              self.isPanUnderReview = self.allVerifyRes?.pan_verify == 0 ? true : false
                        }
                        if self.allVerifyRes?.bank_verify == -1 || self.allVerifyRes?.bank_verify == 2 {
                                                   self.isBankVerified = false
                                                   self.isBankUnderReview = false
                                               }
                                               else {
                                                   
                                                     self.isBankVerified = self.allVerifyRes?.pan_verify == 1 ? true : false
                                                     self.isBankUnderReview = self.allVerifyRes?.pan_verify == 0 ? true : false
                                               }
//                        self.isPanVerified = self.allVerifyRes?.pan_verify == 1 ? true : false
//                        self.isBankVerified = self.allVerifyRes?.bank_verify == 1 ? true : false
                        self.isEmailVerified = self.allVerifyRes?.email_verify == 1 ? true : false
                        self.aCollectionView.reloadDataInMainQueue()
                    }
                    
                }
                catch {
                    Loader.showAlert(message: "Error")
                }
                
            }
        }
    }
    
    func callAllVerifyAPI()  {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTU5MTM3MywiZXhwIjoxNTY1NTk0OTczLCJuYmYiOjE1NjU1OTEzNzMsImp0aSI6InEwNFJpdFc5dXBua080bU8iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.eSHL2YHOeqthUpUnJ1F8Pk5kkUpH4nUHhZ_DBGOJRus",
            "Accept": "application/json",
            "cache-control": "no-cache"
        ]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id":UserDic.value(forKey: "user_id") ]
            
            NetworkManager.post_Request3(urlService: kAllVerify, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                        let responseModel = try JSONDecoder().decode(AllVerifyResponse.self, from: responseData)
                        
                        self.isMobileVerified = responseModel.mobile_verify == 1 ? true : false
                        self.isPanVerified = responseModel.pan_verify == 1 ? true : false
                        self.isBankVerified = responseModel.bank_verify == 1 ? true : false
                        self.isEmailVerified = responseModel.email_verify == 1 ? true : false
                        self.aCollectionView.reloadDataInMainQueue()
                        
                    }
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    
   
    
    fileprivate func postBankDetails(accNo: String,accName: String,ifsc: String,state: String,bankBranch: String) {
        if bankUploadedImageURL == "" {
            Loader.showToast(message: "Please upload bank passbook/cheque image", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
            return
        }
        
        if isPanVerified {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTU5MTM3MywiZXhwIjoxNTY1NTk0OTczLCJuYmYiOjE1NjU1OTEzNzMsImp0aSI6InEwNFJpdFc5dXBua080bU8iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.eSHL2YHOeqthUpUnJ1F8Pk5kkUpH4nUHhZ_DBGOJRus",
            "Content-Type": "application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            
            let parameters = ["image": bankUploadedImageURL, "accno": accNo,"user_id": UserDic.value(forKey: "user_id"),"ifsc": ifsc,"bankname": accName,"bankbranch":bankBranch]
            
            NetworkManager.post_Request2(urlService: kBankVerify, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                                  if response != nil {
                                      let jsonresponse = try  JSON(data:response as! Data)
                                      let status = jsonresponse["status"]
                                      let message  = jsonresponse["message"].stringValue
//                                    let result = jsonresponse["result"]
                                    
                                      if status == 1 {
                                         self.navigationController?.popViewController(animated: true)
                                          Loader.showToast(message: message, onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 22))
                                       
                                             
                                      }
                                      else {
                                         self.navigationController?.popViewController(animated: true)
                                          Loader.showToast(message: message , onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                                      }
                                  }
                              } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
        }
        else {
            Loader.showToast(message: "Please wait Till your Pan Card Verified", onView: self.view, bottomMargin: 0, color: UIColor(red: 240, green: 75, blue: 80))
        }
    }
    
    fileprivate func postPanDetails(panNo: String,panName: String,dob: String) {
        if panUploadedImageURL == "" {
            Loader.showToast(message: "Please upload pan image", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
            return
        }
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTI0NjYwMCwiZXhwIjoxNTY1MjUwMjAwLCJuYmYiOjE1NjUyNDY2MDAsImp0aSI6ImFNSGdQaXVLS1AwUUlmMEoiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.bdK7W2e0fjea2YoHhh6_MmHzfx6cq6VqfrP2giLJdVM",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            
            let parameters = ["image": panUploadedImageURL,"pan_name": panName,"user_id": UserDic.value(forKey: "user_id"),"pan_number": panNo]
            
            NetworkManager.post_Request2(urlService: kPanVerify, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let jsonresponse = try  JSON(data:response as! Data)
                        let status = jsonresponse["status"]
                        let message  = jsonresponse["message"].stringValue
                        if status == 1 {
                             self.navigationController?.popViewController(animated: true)
                            Loader.showToast(message: message, onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 22))
                            
                               
                        }
                        else {
                               self.navigationController?.popViewController(animated: true)
                            Loader.showToast(message: message , onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                          
                        }
                    }
                }catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    
    func sendNewLinkOnmail(value:String) {
        showActivityIndicator(sMessage: "Loading...")
               let headers = [
                   "Content-Type": "application/json",
                   
                   "Accept":"application/json",
                   "cache-control": "no-cache"
               ]
               if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                          
                          let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                   let parameters = ["email": value,"user_id": UserDic.value(forKey: "user_id") ?? -1]
                NetworkManager.post_Request2(urlService: kVerifyMail, param: parameters, head: headers) { (response) in
                        self.hideActivityIndicator()
                        do {
                            if response != nil {
                                let jsonresponse = try  JSON(data:response as! Data)
                                let status = jsonresponse["status"]
                                let message  = jsonresponse["message"].stringValue
                                if status == 1 {
                                    Loader.showToast(message: message, onView: self.view, bottomMargin: 200, color:  UIColor(red: 49, green: 139, blue: 22))
                                       self.navigationController?.popViewController(animated: true)
                                }
                                else {
                                     self.navigationController?.popViewController(animated: true)
                                    Loader.showToast(message: message , onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                                }
                                   
                                    
                                }
                            }
                        catch {
                            Loader.showAlert(message: "Status code 500: server internal error")
                        }
                        }
                    }
                }
        
    
    fileprivate func verifyEmailOrMobile(value: String, type: String) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Content-Type": "application/json",
            
            "Accept":"application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                   
                   let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["mobile": value,"user_id": UserDic.value(forKey: "user_id") ?? -1,"type": "2"]
        NetworkManager.post_Request2(urlService: kSendNewOtp, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let jsonresponse = try  JSON(data:response as! Data)
                    let status = jsonresponse["status"]
                    let message  = jsonresponse["message"].stringValue
                    if status == 1 {
                        Loader.showToast(message: message, onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 22))
                            self.openOtpVC(number: value,type: type)
                    }
                    else {
                        Loader.showToast(message: message , onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                    }
                       
                        
                    }
                }
            catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
            }
        }
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func openOtpVC(number: String, type: String) {
        openViewController(controller: VerifyMobileNumberViewController.self, storyBoard: .signInUpStoryBoard) { (vc) in
            vc.isFromVerifyMobileVC = true
            vc.mobileNumber = number
            vc.verificationType = type
        }
    }
    func registerCell() {
        aCollectionView.register(UINib(nibName: FCAccountsCVCell.identifier(), bundle: nil), forCellWithReuseIdentifier: FCAccountsCVCell.identifier())
    }
    
    @IBAction func MobileEmailButtonAction(_ sender: Any) {
        aCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 0)
    }
    
    @IBAction func PanCardButtonAction(_ sender: Any) {
        aCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 1)
    }
    
    @IBAction func BankButtonAction(_ sender: Any) {
        aCollectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 2)
    }
    
    fileprivate func moveSelectionView(index: Int) {
        let selectionViewWidth = Int(ScreenSize.SCREEN_WIDTH / 3)
        switch index {
        case 0:
            self.bankOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            self.panOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: 0, y: 36, width: selectionViewWidth, height: 3)
                self.mobileAndEmailOutlt.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            }
        case 1:
            self.mobileAndEmailOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            self.bankOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: selectionViewWidth, y: 36, width: selectionViewWidth, height: 3)
                self.panOutlt.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            }
        case 2:
            self.mobileAndEmailOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            self.panOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.bankOutlt.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
                self.aSelectionView.frame = CGRect(x: selectionViewWidth * index, y: 36, width: selectionViewWidth, height: 3)
            }
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        visibleCellIndex = Utility.findCenterCellIndex(collectionView: aCollectionView)
    }
    
    func setImageForBankPan(cellType: AccountCellType) {
        tempCellType = cellType
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
       
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    fileprivate func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if tempCellType == .pancardCellType {
                panImage = pickedImage
            } else if tempCellType == .bankCellType {
                bankImage = pickedImage
            }
            let imageData = pickedImage.jpegData(compressionQuality: 0.1)! as Data
//            uploadImageAPI(imageData: imageData as NSData)
            UPLOD(imgData: imageData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func UPLOD(imgData:Data)
    {
        showActivityIndicator(sMessage: "Loading...")
        //Parameter HERE
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                                
              let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let dict = ["user_id" :"\(UserDic.value(forKey: "user_id") ?? "")" ] as [String : Any]
            
        //Header HERE
        let headers = [
            "Authorization" : "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDIxMjI3NywiZXhwIjoxNTY0MjE1ODc3LCJuYmYiOjE1NjQyMTIyNzcsImp0aSI6IjgyQXk1MDlYd1JPb0Vrb1IiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.QAIl3-xxKFQY76OAv241eVyVummgC_zuxXZNlGPtE2Q",
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept" : "application/json"
        ]
        
            self.showActivityIndicator(sMessage: "..Loading")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            //Parameter for Upload files
            multipartFormData.append(imgData, withName: "file",fileName: "furkan.png" , mimeType: "image/png")
            
            for (key, value) in dict
            {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, usingThreshold:UInt64.init(),
           to: kLiveURL + uploadPanBankImage, //URL Here
            method: .post,
            headers: headers, //pass header dictionary here
            encodingCompletion: { (result) in
                self.hideActivityIndicator()
                switch result {
                case .success(let upload, _, _):
                    print("the status code is :")
                    
                      self.showActivityIndicator(sMessage: "..Loading")
                    upload.uploadProgress(closure: { (progress) in
                        print("something")
                     
                    })
                    
                    upload.responseJSON { response in
                       self.hideActivityIndicator()
                        print("the resopnse code is : \(response.response?.statusCode ?? 0)")
                        print("the response is : \(response)")
                        do {
                        let json = try JSON(data:response.data ?? Data())
                            let json2 = json["result"]
                            for aarr in json2.arrayValue {
                                self.uploadData.append(uploadImage(json:aarr))
                            }
                            
//                            let image = json2["image"].string
//                            let status = json["status"].intValue
                            if self.uploadData.count > 0 {
                                
                            
                            if self.uploadData[0].status == 1 {
                            
                                                               if self.tempCellType == .pancardCellType {
                                                                   self.isPanImageAdded = true
                                                                self.panUploadedImageURL = self.uploadData[0].image ?? ""
                                                                   Loader.showToast(message: "Pan image upload successfully", onView: self.view, bottomMargin: 200, color:  UIColor(red: 49, green: 139, blue: 22))
                                                               } else if self.tempCellType == .bankCellType {
                                                                   self.isBankImageAdded = true
                                                                self.bankUploadedImageURL = self.uploadData[0].image ?? ""
                                                                   Loader.showToast(message: "Bank image upload successfully", onView: self.view, bottomMargin: 200, color:  UIColor(red: 49, green: 139, blue: 22))
                                                                   
                                                               }
                                                               self.aCollectionView.reloadDataInMainQueue()
                                                           
                        }
                            }
                            else {
                                Loader.showToast(message: "Unable to upload image", onView: self.view, bottomMargin: 200, color:  UIColor(red: 49, green: 139, blue: 22))
                            }
                        
                    }
                        catch {
                            self.view.makeToast(message: "Failure")
                        }
                    }
                    break
                case .failure(let encodingError):
                    print("the error is  : \(encodingError.localizedDescription)")
                    break
                }
        })
    }
    }
    func uploadImageAPI(imageData: NSData) {
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                          
        let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let dict = ["user_id" :UserDic.value(forKey: "user_id") ?? -1] as [String : Any]
        let boundary = Utility().generateBoundaryString()
        
        let API_Path = kBASE_URL
        let API_Method = kUploadAndoirdPan
        
        let Parameter = String(format: "%@%@", API_Path,API_Method)
        
        var request = URLRequest(url: URL(string: Parameter)!)
        request.httpMethod = "POST"
            request.allHTTPHeaderFields = ["Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTU5MTM3MywiZXhwIjoxNTY1NTk0OTczLCJuYmYiOjE1NjU1OTEzNzMsImp0aSI6InEwNFJpdFc5dXBua080bU8iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.eSHL2YHOeqthUpUnJ1F8Pk5kkUpH4nUHhZ_DBGOJRus"]
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = Utility().createBodyWithParameters(parameters: dict, filePathKey: "file", imageData: imageData, imageName: "", boundary: boundary) as Data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.hideActivityIndicator()
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                Loader.showToast(message: "Unable to upload image", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                DispatchQueue.main.async {
                     Loader.showToast(message: "Unable to upload image", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                    //Do UI Code here.
                    //Call Google maps methods.
                }
               
            } else {
                let responseString =  NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print("responseString = \(String(describing: responseString))")
//                let json =  try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
//
//                                   print("json value \(json)")
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary else {
                    DispatchQueue.main.async() {
                        Loader.showToast(message: "Unable to upload image", onView: self.view, bottomMargin: 200, color: .red)
                    }
                    return
                }
                if let dataArr = json.object(forKey: "getstatus") as? NSArray {
                    if let dataDict = dataArr[0] as? NSDictionary {
                        if let status = dataDict.value(forKey: "status") as? Int  {
                            if status == 1 {
                                if let imageURL = dataDict.value(forKey: "image") as? String {
                                    if self.tempCellType == .pancardCellType {
                                        self.isPanImageAdded = true
                                        self.panUploadedImageURL = imageURL
                                        Loader.showToast(message: "Pan image upload successfully", onView: self.view, bottomMargin: 200, color: .red)
                                    } else if self.tempCellType == .bankCellType {
                                        self.isBankImageAdded = true
                                        self.bankUploadedImageURL = imageURL
                                        Loader.showToast(message: "Bank image upload successfully", onView: self.view, bottomMargin: 200, color: .red)
                                        
                                    }
                                    self.aCollectionView.reloadDataInMainQueue()
                                }
                            } else {
                                Loader.showToast(message: "Unable to upload image", onView: self.view, bottomMargin: 200, color: .red)
                            }
                        } else {
                            Loader.showToast(message: "Unable to upload image", onView: self.view, bottomMargin: 200, color: .red)
                        }
                    }
                } else {
                    Loader.showToast(message: "Unable to upload image", onView: self.view, bottomMargin: 200, color: .red)
                }
            }
        }
        task.resume()
    }
    }
}

extension VerifyAccountViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FCAccountsCVCell.identifier(), for: indexPath) as! FCAccountsCVCell
        cell.isBankImageAdded = isBankImageAdded
        cell.isPanImageAdded = isPanImageAdded
        cell.selectedBankImage = bankImage
        cell.selectedPanImage = panImage
        switch indexPath.row {
        case 0:
            cell.cellType = .mobileCellType
            cell.isMobileVerified = isMobileVerified
            cell.isEmailVerified = isEmailVerified
        case 1:
            cell.cellType = .pancardCellType
            cell.isPanVerified = isPanVerified
            cell.isPanunderReview = isPanUnderReview
        default:
            cell.cellType = .bankCellType
            cell.isBankVerified = isBankVerified
            cell.isBankunderReview = self.isBankUnderReview
        }
        cell.didSelectClousure = { [weak self] index in
            self?.didSelectClousure(index)
        }
        cell.uploadImageClouser = {[weak self] cellType in
            if let strongSelf = self {
                strongSelf.setImageForBankPan(cellType: cellType)
            }
        }
        cell.submitButtonClousure = { [weak self] accountName,accountNo,ifscCode,bankName in
            if let strongSelf = self {
                strongSelf.postBankDetails(accNo: accountNo, accName: accountName, ifsc: ifscCode, state: "", bankBranch: bankName)
                
            }
        }
        cell.submitButtonForPanClousure = { [weak self] panName,panNo,dob in
            if let strongSelf = self {
                strongSelf.postPanDetails(panNo: panNo, panName: panName, dob: dob)
            }
        }
        cell.verifyEmailMobileClousure = { [weak self] numberOrEmail,type in
            if let strongSelf = self {
                if type == "mobile" {
                strongSelf.verifyEmailOrMobile(value: numberOrEmail, type: type)
                }else {
                    strongSelf.sendNewLinkOnmail(value: numberOrEmail)
                }
            }
        }
        cell.itematIndex = indexPath.item

        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: aCollectionView.frame.width, height: aCollectionView.frame.height)
    }
}

