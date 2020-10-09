//
//  AccountCollectinViewController.swift
//  DreamTeam
//
//  Created by Test on 31/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Kingfisher
import Alamofire
class AccountCollectinViewController: BaseClass,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var leftAccountLbl: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var BalanceOutlt: UIButton!
    @IBOutlet weak var PayingHistoryOutlt: UIButton!
    @IBOutlet weak var transactionOutlt: UIButton!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var mailLBl: UILabel!
    @IBOutlet weak var aCollection: UICollectionView!
    @IBOutlet var aCollectionView: UIView!
    @IBOutlet weak var miidleAccountLbl: UILabel!
    var isMobileVerified = false
    var isPanVerified = false
    var isBankVerified = false
    var isEmailVerified = false
    var imagePicker = UIImagePickerController()
    private var unutilizedAmount = ""
    private var winningsAmount = ""
    var myBalanceDataArray = [BalanceModel]() {
        didSet {
            aCollection.reloadDataInMainQueue()
        }
    }
    var allverifyResp:AllVerifyResponses?
    var playingHisotryData:playingHistory?
    var uploadData = [uploadImage]()
    var visibleCellIndex = 0 {
        didSet {
            moveSelectionView(index: visibleCellIndex)
        }
    }
    @IBOutlet weak var selectionView: UIView!
    var transactionData = [myTransaction]() {
        didSet {
            aCollection.reloadDataInMainQueue()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileImageView.layer.borderWidth = 1.0
        userProfileImageView.layer.masksToBounds = false
        userProfileImageView.layer.borderColor = UIColor.white.cgColor
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.width / 2
        userProfileImageView.clipsToBounds = true
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if hidesBottomBarWhenPushed {
            miidleAccountLbl.isHidden = true
            backButton.isHidden = false
            leftAccountLbl.isHidden = false
        }
        else {
            backButton.isHidden = true
            leftAccountLbl.isHidden = true
            miidleAccountLbl.isHidden = false
        }
        fetchAccountData()
        callAllVerifybyJSon()
        registerCell()
        getUserProfileData()
        setup()
        playingData()
        transactionDAta()
    }
    
    @IBAction func handleBackCustom(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func playingData() {
        let headers = ["Content-Type":"application/x-www-form-urlencoded"]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["user_id":UserDic.value(forKey: "user_id")]
            NetworkManager.post_Request(urlService: kMyPlayingHistory, param: param as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let json = try JSON(data:response as! Data)
                        let status = json["status"].intValue
                        let message = json["message"].stringValue
                        let result = json["result"]
                        if status == 1 {
                            self.playingHisotryData = playingHistory(json: result)
                            
                            self.aCollection.reloadDataInMainQueue()
                        }
                        else {
                           print(message)
                        }
                    }
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    func transactionDAta() {
        
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2Njk5NjgwMywiZXhwIjoxNTY3MDAwNDAzLCJuYmYiOjE1NjY5OTY4MDMsImp0aSI6ImJua1lSUEdUVG9ZMmZkWGgiLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.Ryu2pYtdnUKuVrOHOo_wToyjJxiQErm4WIFphId4ycw",
            "content-type": "application/json",
            "Accept":"application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["user_id":UserDic.value(forKey:"user_id" )]
            
            NetworkManager.post_Request2(urlService: kMyTransaction, param: param as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let json = try JSON(data:response as! Data)
                        let status = json["status"]
                        let result = json["result"]
                        let data = result["data"]
                        let message = json["message"].stringValue
                        if status == 1 {
                            self.transactionData.removeAll()
                            for arr in data.arrayValue
                            {
                                self.transactionData.append(myTransaction(json:arr))
                            }
                            
                        } else {
                            print(message)
                        }
                    }
                }
                catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
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
                        self.allverifyResp = AllVerifyResponses(json: result)
                        if self.allverifyResp?.pan_verify == -1 || self.allverifyResp?.pan_verify == 2 {
                            self.isPanVerified = false
                           
                        }
                        else {
                            
                            self.isPanVerified = true
                            
                        }
                        if self.allverifyResp?.bank_verify == -1 || self.allverifyResp?.bank_verify == 2 {
                            self.isBankVerified = false
                          
                        }
                        else {
                            
                            self.isBankVerified = true
                          
                        }
                         self.isMobileVerified = self.allverifyResp?.mobile_verify == 1 ? true : false
                        self.isEmailVerified = self.allverifyResp?.email_verify == 1 ? true : false
                        
                    }
                }  catch {
                    Loader.showAlert(message: "Error")
                }
                
            }
        }
    }
    func getUserProfileData() {
        if Connectivity.isConnectedToInternet {
            showActivityIndicator(sMessage: "Loading...")
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYuZmFudGFzeXBvd2VyMTEuY29tXC9uZXdfYXBpXC9mcDExXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTg3NDY4MzcyLCJleHAiOjE1ODc0NzE5NzIsIm5iZiI6MTU4NzQ2ODM3MiwianRpIjoiVm9yNVhMOHZXd3hUSzFvdCIsInN1YiI6OTkxMTcsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.Ceh0HxBV_DIRFa_ePcw1YQlSkFfcjC8IXox0xR9gAwo",
                "Accept": "application/json",
                "cache-control": "no-cache"
            ]
            if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                
                let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                let parameters = ["user_id": UserDic.value(forKey: "user_id")]
                guard let urlString = URL(string: kBASE_URL + kUserDetailsURL) else {
                    
                    return
                }
                Alamofire.request(urlString, method: .post, parameters: parameters as Parameters, encoding: URLEncoding.default, headers: headers).responseJSON{ response in
                    self.hideActivityIndicator()
                    let json = response.result.value as? NSDictionary
                    
                    if json != nil{
                        let json : NSDictionary = response.result.value as? NSDictionary ?? [:]
                        // print(json)
                        let status = json.value(forKey: "status") as? Int ?? 0
                        let message = json.value(forKey: "message") as? String ?? ""
                        let result = json.value(forKey: "result") as?  NSDictionary ?? [:]
                        if status == 1 { // for Success
                            
                            
                            
                            // Saved Registered User Data
                            let UserDataDic = result.value(forKey: "value") as? NSDictionary ?? [:]
                            UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: UserDataDic), forKey: "UserDetail")
                            
                            // Get Login User Data
                            if let heroObject = UserDefaults.standard.value(forKey: "UserDetail") as? NSData {
                                
                                let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                                
                                print(UserDic)
                            }
                        }
                        else {
                            print(message)
                        }
                    }
                }
            }
        }
        else {
            Loader.showAlert(message: "No Internet Connection")
        }
    }
    
    func setup() {
        if let heroObject = UserDefaults.standard.value(forKey: "UserDetail") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let string = UserDic.value(forKey: "image")
            let imageUrl = URL(string: string as? String ?? "" )
            nameLbl.text = UserDic.value(forKey: "username") as? String
            userProfileImageView.kf.setImage(with: imageUrl)
            userProfileImageView.contentMode = .scaleToFill
            userEmail.text = UserDic.value(forKey: "email") as? String
            if userProfileImageView .image == nil {
                userProfileImageView.image = UIImage(named: "Group 7421")
            }
        }
    }
    
    @IBAction func verifyAccount(_ sender: Any) {
        openVerifyAccount()
    }
    @IBAction func editProfile(_ sender: Any) {
        openProfile()
    }
    
    func registerCell() {
        aCollection.register(UINib(nibName: AddCashUICollectionCell.identifier(), bundle: nil), forCellWithReuseIdentifier: AddCashUICollectionCell.identifier())
        aCollection.register(UINib(nibName: PlayingHistoryCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: PlayingHistoryCollectionViewCell.identifier())
        aCollection.register(UINib(nibName: TransactionCollectionViewCell.identifier(), bundle: nil), forCellWithReuseIdentifier: TransactionCollectionViewCell.identifier())
        
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
            NetworkManager.post_Request(urlService: kMyBalance, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let json = try JSON(data:response as! Data)
                        let result = json["result"]
                        for arr in result.arrayValue {
                            self.myBalanceDataArray.append(BalanceModel(json:arr))
                        }
                    } else {
                       
//                        Loader.showAlert(message: "Unable to get Account Data")
                    }
                    
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    func openVerifyAccount() {
        openViewController(controller: VerifyAccountViewController.self, storyBoard: .moreStoryBoard) { (vc) in
            
        }
    }
    func openProfile() {
        openViewController(controller: ProfileViewController.self, storyBoard: .moreStoryBoard) { (vc) in
            
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        visibleCellIndex = Utility.findCenterCellIndex(collectionView: aCollection)
    }
    @IBAction func trasactionAction(_ sender: Any) {
        aCollection.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 2)
        
        
    }
    @IBAction func checkPayingHistoryAction(_ sender: Any) {
        aCollection.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 1)
        
    }
    @IBAction func checkBalanceAction(_ sender: Any) {
        
        aCollection.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 0)
    }
    
    
    @IBAction func openImageView(_ sender: Any) {
        setImageForProfile()
    }
    func setImageForProfile() {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
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
//            userProfileImageView.image = pickedImage
            let imageData = pickedImage.jpegData(compressionQuality: 0.1)! as Data
            //            uploadImageAPI(imageData: imageData as NSData)
            UPLOD(imgData: imageData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func UPLOD(imgData:Data)
    {
        //Parameter HERE
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let dict = ["user_id" :"\(UserDic.value(forKey: "user_id") ?? "")" ] as [String : Any]
            
            //Header HERE
            let headers = [
                "Authorization" : "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTU5MTM3MywiZXhwIjoxNTY1NTk0OTczLCJuYmYiOjE1NjU1OTEzNzMsImp0aSI6InEwNFJpdFc5dXBua080bU8iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.eSHL2YHOeqthUpUnJ1F8Pk5kkUpH4nUHhZ_DBGOJRus"
            ]
            
            
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                //Parameter for Upload files
                multipartFormData.append(imgData, withName: "file",fileName: "furkan.png" , mimeType: "image/png")
                
                for (key, value) in dict
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
            }, usingThreshold:UInt64.init(),
               to: kLiveURL + profileImageUpdate, //URL Here
                method: .post,
                headers: headers, //pass header dictionary here
                encodingCompletion: { (result) in
                    
                    switch result {
                    case .success(let upload, _, _):
                        print("the status code is :")
                        
                        upload.uploadProgress(closure: { (progress) in
                            
                            print("something")
                        })
                        
                        upload.responseJSON { response in
                            print("the resopnse code is : \(response.response?.statusCode)")
                            print("the response is : \(response)")
                            do {
                                let json = try JSON(data:response.data ?? Data())
                                let json2 = json["result"]
                                for aarr in json2.arrayValue {
                                    self.uploadData.append(uploadImage(json:aarr))
                                }
                                
                                //                            let image = json2["image"].string
                                //                            let status = json["status"].intValue
                                if self.uploadData[0].status == 1 {
                                    
                                    Loader.showToast(message: "Profile image upload successfully", onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 22))
                                    
                                    
                                }
                                
                            }
                            catch {
                                print("")
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
}

extension AccountCollectinViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCashUICollectionCell.identifier(), for: indexPath) as! AddCashUICollectionCell
        let cell1 =  collectionView.dequeueReusableCell(withReuseIdentifier: PlayingHistoryCollectionViewCell.identifier(), for: indexPath) as! PlayingHistoryCollectionViewCell
        let cell2 =  collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCollectionViewCell.identifier(), for: indexPath) as! TransactionCollectionViewCell
        switch indexPath.item {
        case 0:
            cell.delegate = self
            cell.setup(contestdata: myBalanceDataArray)
            return cell
        case 1 :
            if let data = playingHisotryData{
                cell1.configure(playing: data)
                return cell1
            }
            else {
                return cell1
            }
            
        case 2:
            if transactionData.count > 0 {
                cell2.transactionDataModel = transactionData
                return cell2
            }
            else {
                
                return cell2
            }
            
        default:
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: aCollection.frame.width, height: aCollection.frame.height)
    }
    public func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

extension AccountCollectinViewController:openAddMoney {
    func openInvestMent() {
          openViewController(controller: InvestmentAnalyzerViewController.self, storyBoard: .accountStoryBoard) { (vc) in
        }
    }
    
    func openMoneVc(bonous: String, deposit: String, winning: String) {
         openViewController(controller: AddMoneyViewController.self, storyBoard: .accountStoryBoard) { (vc) in
            vc.bonusCash = bonous
            vc.depositAmount = deposit
            vc.winnings = winning
               }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "withdrawSegue") {
            let vc = segue.destination as! WithdrawViewController
            vc.winningsAmount = myBalanceDataArray[0].winning ?? "0"
        }
    }
    
    func openWithdraw() {
        if isEmailVerified {
            if isMobileVerified {
               if isPanVerified {
                 if isBankVerified {
                         performSegue(withIdentifier: "withdrawSegue", sender: nil)
                    }
                 else {
                    Loader.showToast(message: "you need to verify first", onView: self.view, bottomMargin: 300, color: UIColor(red: 240, green: 75, blue: 80))
                           }
                }
                
               else {
                Loader.showToast(message: "you need to verify first", onView: self.view, bottomMargin: 300, color: UIColor(red: 240, green: 75, blue: 80))
                       }
                }
            
            else {
            Loader.showToast(message: "you need to verify first", onView: self.view, bottomMargin: 300, color: UIColor(red: 240, green: 75, blue: 80))
            }
            }
        
        else {
            Loader.showToast(message: "you need to verify first", onView: self.view, bottomMargin: 300, color: UIColor(red: 240, green: 75, blue: 80))
        }
    }
    
    func openMoneVc() {

//    performSegue(withIdentifier: "accountToAddCashSegue", sender: nil)
        
    }
    
    fileprivate func moveSelectionView(index: Int) {
        let selectionViewWidth = Int(ScreenSize.SCREEN_WIDTH / 3)
        switch index {
        //Live
        case 0:
            transactionOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            PayingHistoryOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            
            // myView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            UIView.animate(withDuration: 0.2) {
                self.selectionView.frame = CGRect(x: 0, y: 35, width: selectionViewWidth, height: 5)
                self.BalanceOutlt.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
                
            }
        //upcoming
        case 1:
            transactionOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            BalanceOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            
            UIView.animate(withDuration: 0.2) {
                self.selectionView.frame = CGRect(x: selectionViewWidth, y: 35, width: selectionViewWidth, height: 5)
                self.PayingHistoryOutlt.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
                
            }
        //Result
        case 2:
            
            PayingHistoryOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            BalanceOutlt.setTitleColor(UIColor(red: 255, green: 195, blue: 145), for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.selectionView.frame = CGRect(x: selectionViewWidth * index, y: 35, width: selectionViewWidth, height: 5)
                self.transactionOutlt.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            }
        default:
            break
        }
    }
    
}
