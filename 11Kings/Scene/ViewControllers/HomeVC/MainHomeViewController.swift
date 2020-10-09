//
//  MainHomeViewController.swift
//  DreamTeam
//
//  Created by Test on 31/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FirebaseCrashlytics

class MainHomeViewController: BaseClass {
    
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var footballViewButton: UIButton!
    @IBOutlet weak var cricktViewButton: UIButton!
    @IBOutlet weak var atableView: UITableView!
    @IBOutlet weak var kabbdiViewButton: UIButton!
    
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var footballImageView: UIImageView!
    @IBOutlet weak var kabaddImageView: UIImageView!
    @IBOutlet weak var cricketImageView: UIImageView!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var footballOutlt: UIButton!
    @IBOutlet weak var kabaddiOutlt: UIButton!
    @IBOutlet weak var cricketOutlt: UIButton!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var updateTeam = false
    
    var stringPopImage:String?
    var matchType = "CRICKET"
    
    var getMatch:JSON!
    var bannerTimer = Timer()
    var matchKey:String?
    var changePasswordView: PopImageView?
    var isMaintanceViewAvail:MaintananceView?
    private var bannerDataArray = [BannerResponses]() {
        didSet {
            
            atableView.reloadDataInMainQueue()
        }
    }
    
    var getCricketData = [GetMatchDetails]() {
        didSet{
            homeCollectionView.reloadDataInMainQueue()
        }
    }
    
    var getKabaddiData = [GetMatchDetails]() {
        didSet{
            homeCollectionView.reloadDataInMainQueue()
        }
    }
    
    var getFootbaalData = [GetMatchDetails]()
    {
        didSet{
            homeCollectionView.reloadDataInMainQueue()
        }
    }
    
    var selectedContest: ((GetMatchDetails, String, HomeType) -> Void) = { _, _, _  in }
    
    var userDetailArray: UserDetailsResponses? {
        didSet {
            configureUserFullData()
        }
    }
    var userDetail:UserDetailsResponse? {
        didSet {
            configureUserFullDatas()
        }
    }
    
    func configureUserFullDatas() {
        
        UserDefaults.standard.set(userDetail?.email, forKey: kEmailId)
        UserDefaults.standard.set(userDetail?.mobile, forKey: kMobileNumber)
        if let teamName = userDetail?.team {
            if teamName == "" {
                openViewController(controller: UpdateTeamNameViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                    vc.deleegate = self
                    vc.teamNameClouser = {[weak self] name in
                        if let _ = self {
                            UserDefaults.standard.set(name, forKey: kTeamName)
                        }
                    }
                }
            } else {
                getBannerData()
                UserDefaults.standard.set(teamName, forKey: kTeamName)
            }
        } else {
            openViewController(controller: UpdateTeamNameViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                
            }
        }
        getBannerData()
        UserDefaults.standard.set(userDetail?.refercode, forKey: kReferCode)
    }
    
    var panDetail : PanResponse? {
        didSet {
            configurePanData()
        }
    }
    var bankDetailsArray = [BankDetailResponses]() {
        didSet {
            configureBankData()
        }
    }
    
    var myBalanceDataArray = [BalanceModel]() {
        didSet {
            amountLbl.text = "\(kRupeeIcon) \(myBalanceDataArray[0].totalamount ?? "0")"
        }
    }
    
    var visibleCellIndex = 0 {
        didSet {
            moveSelectionViewbase(index: visibleCellIndex)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureBankData() {
        
        UserDefaults.standard.set(bankDetailsArray[0].accno, forKey: kBankAccountNo)
        
    }
    
    func configureUserFullData() {
        UserDefaults.standard.set(userDetailArray?.email, forKey: kEmailId)
        UserDefaults.standard.set(userDetailArray?.mobile, forKey: kMobileNumber)
        UserDefaults.standard.set(userDetailArray?.refercode, forKey: kReferCode)
    }
    
    
    func configurePanData() {
        
        UserDefaults.standard.set(panDetail?.pannumber, forKey: kPanCardNo)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PopupImageViewController" {
            let pop = segue.destination as! PopupImageViewController
            pop.imageString = stringPopImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.matchType = "CRICKET"
        getCricketDaata()
        getUserProfileData()
        registerCell()
        //
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if getCricketData.count == 0 {
            getCricketDaata()
        }
        if updateTeam {
            getBannerData()
            updateTeam = false
        }
        getBankDetails()
        getPanDetails()
        fetchAccountData()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let tabbar = tabBarController as! HomeTabBarController
        tabbar.matchTYPE = matchType
        tabbar.checkHomeType = true
    }
    override func viewDidAppear(_ animated: Bool) {
        let tab = tabBarController as! HomeTabBarController
        matchType = tab.matchTYPE
        if tab.checkHomeType {
            if tab.matchTYPE == "CRICKET" {
                //            getCricketdata()
                moveSelectionViewbase(index: 0)
                //            moveSelectionView(index: 0)
                homeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            }
            if tab.matchTYPE == "FOOTBALL" {
                //            getFotballData()
                moveSelectionViewbase(index: 1)
                //                                 moveSelectionView(index: 0)
                homeCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
            }
            if tab.matchTYPE == "BASKETBALL" {
                
                moveSelectionViewbase(index: 2)
                
                homeCollectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
            }
            tab.checkHomeType = false
        }
    }
    fileprivate func removeChangePassView() {
        self.view.isUserInteractionEnabled = true
        changePasswordView?.removeFromSuperview()
        changePasswordView = nil
    }
    
    @IBAction func cricketBtnAction(_ sender: Any) {
        getCricketDaata()
        
        homeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionViewbase(index: 0)
        
    }
    
    @IBAction func walletBuutonAction(_ sender: Any) {
        openViewController(controller: AccountCollectinViewController.self, storyBoard: .accountStoryBoard) { (vc) in
            
        }
    }
    @IBAction func kabaddiBtnAction(_ sender: Any) {
        
        homeCollectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionViewbase(index: 2)
    }
    
    @IBAction func footballBottonACtion(_ sender: Any) {
        homeCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionViewbase(index: 1)
    }
    
    @IBAction func notificationAction(_ sender: Any) {
        openViewController(controller: NotificationViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            
        }
        
    }
    fileprivate func setContestData() {
        
        
    }
    
    /// Get Cricket Data from api
    func getCricketDaata() {
        
        self.showActivityIndicator(sMessage: "..Loading")
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYuZmFudGFzeXBvd2VyMTEuY29tXC9uZXdfYXBpXC9mcDExXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTg3NTU5Nzg2LCJleHAiOjE1ODc2NDYxODYsIm5iZiI6MTU4NzU1OTc4NiwianRpIjoibGVCRm1jV1FjQ3B5TGJBaSIsInN1YiI6OTkxMTcsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.mRtYmTgwyZDJApSar19QXI1x1EAiPiww-vSr3QBrh-U",
            "Accept": "application/json",
            "cache-control": "no-cache"
        ]
        
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let params = ["user_id":UserDic.value(forKey: "user_id"),
                          "sport_key":"CRICKET"]
            NetworkManager.post_Request2(urlService: kgetMatchList, param: params as [String : Any], head: headers)  { (response) in
                self.hideActivityIndicator()
                
                guard let data = response else { return }
                do{
                    let json = try JSON(data:data as! Data)
                    let results = json["result"]
                    self.getCricketData.removeAll()
                    for arr in results.arrayValue{
                        
                        self.getCricketData.append(GetMatchDetails(json: arr))
                    }
                    
                    self.homeCollectionView.reloadDataInMainQueue()
                }
                catch{
                    Loader.showAlert(message: "Internal Error")
                }
            }
        }
    }
    
    
    
    /// get BasketBall Response from API
    func getBasketBallResponse() {
        self.showActivityIndicator(sMessage: "..Loading")
        let headers = [
            "Content-Type": "application/json",
            "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYuZmFudGFzeXBvd2VyMTEuY29tXC9uZXdfYXBpXC9mcDExXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTg3NTU5Nzg2LCJleHAiOjE1ODc2NDYxODYsIm5iZiI6MTU4NzU1OTc4NiwianRpIjoibGVCRm1jV1FjQ3B5TGJBaSIsInN1YiI6OTkxMTcsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.mRtYmTgwyZDJApSar19QXI1x1EAiPiww-vSr3QBrh-U",
            "Accept": "application/json",
            "cache-control": "no-cache"
        ]
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameter = ["user_id":UserDic.value(forKey: "user_id") ,
                             "sport_key":"BASKETBALL"]
            NetworkManager.post_Request2(urlService: kgetMatchList, param: parameter as [String : Any], head: headers)  { (response) in
                self.hideActivityIndicator()
                guard let data = response else { return }
                do{
                    let json = try JSON(data:data as! Data)
                    let results = json["result"]
                    self.getKabaddiData.removeAll()
                    for arr in results.arrayValue{
                        self.getKabaddiData.append(GetMatchDetails(json: arr))
                    }
                    self.homeCollectionView.reloadDataInMainQueue()
                }
                catch{
                    self.view.makeToast(message: "We having some problem we will come back soon")
                }
            }
        }
        
        
    }
    
    
    /// Get Football Response from api
    func getFootbaalResponse() {
        
        self.showActivityIndicator(sMessage: "..Loading")
        let headers =
            [ "Content-Type": "application/json",
              "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYuZmFudGFzeXBvd2VyMTEuY29tXC9uZXdfYXBpXC9mcDExXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTg3NTU5Nzg2LCJleHAiOjE1ODc2NDYxODYsIm5iZiI6MTU4NzU1OTc4NiwianRpIjoibGVCRm1jV1FjQ3B5TGJBaSIsInN1YiI6OTkxMTcsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.mRtYmTgwyZDJApSar19QXI1x1EAiPiww-vSr3QBrh-U",
              "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["user_id":UserDic.value(forKey: "user_id"),
                         "sport_key":"FOOTBALL"]
            NetworkManager.post_Request2(urlService: kgetMatchList, param: param as [String : Any], head: headers) { response in
                self.hideActivityIndicator()
                do {
                    if response !=  nil {
                        let json = try JSON(data: response as! Data)
                        let result = json["result"]
                        self.getFootbaalData.removeAll()
                        for arr in result.arrayValue{
                            
                            self.getFootbaalData.append(GetMatchDetails(json: arr))
                            
                        }
                        self.homeCollectionView.reloadDataInMainQueue()
                    }
                }catch {
                    Loader.showAlert(message: "InternalError")
                }
            }
        }
    }
    
    
    /// Get User Data full profile data from api
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
                    let dataResponse = response.data as? Data
                    if json != nil{
                        let json : NSDictionary = response.result.value as? NSDictionary ?? [:]
                        do {
                            let jsonResponse = try JSON(data:dataResponse!)
                            //                            let status = jsonResponse["status"]
                            let jsonResult = jsonResponse["result"]
                            let jsonValue = jsonResult["value"]
                            self.userDetail = UserDetailsResponse(userJson: jsonValue)
                            
                        }
                        catch {
                            
                        }
                        print(json)
                        let status = json.value(forKey: "status") as? Int ?? 0
                        let message = json.value(forKey: "message") as? String ?? ""
                        let result = json.value(forKey: "result") as?  NSDictionary ?? [:]
                        if status == 1 { // for Success
                            
                            
                            
                            // Saved Registered User Data
                            let UserDataDic = result.value(forKey: "value") as? NSDictionary ?? [:]
                            UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: UserDataDic), forKey: "UserDetail")
                            
                            // Get Login User Data
                            
                        }
                        else {
                            Loader.showAlert(message: message)
                        }
                    }
                }
            }
        }
        else {
            Loader.showAlert(message: "No Internet Connection")
        }
    }
    
    
    /// get user Bank details
    func getBankDetails() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id")]
            
            NetworkManager.post_Request(urlService: kBankDetailsURL, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let jsonResponse = try JSON(data: response as! Data)
                        let status = jsonResponse["status"].intValue
                        if status == 1 {
                            let result = jsonResponse["result"]
                            for i in result.arrayValue {
                                self.bankDetailsArray.append(BankDetailResponses(json: i))
                                //                                   self.bankDetailsArray = responseModel
                            }
                        }
                    }
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
        
    }
    
    
    func getPanDetails() {
        
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
            
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id")]
            
            NetworkManager.post_Request(urlService: kPanDetailsURL, param: parameters as [String : Any], head: headers) { (response) in
                self.hideActivityIndicator()
                do {
                    if response != nil {
                        let jsonResponse = try JSON(data: response as! Data)
                        let status = jsonResponse["status"].intValue
                        if status == 1 {
                            let result = jsonResponse["result"]
                            
                            self.panDetail = (PanResponse(json: result))
                            //                                   self.bankDetailsArray = responseModel
                            
                        }
                    }
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
                
            }
        }
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
                        Loader.showAlert(message: "Unable to get Account Data")
                    }
                    
                } catch {
                    Loader.showAlert(message: "Status code 500: server internal error")
                }
            }
        }
    }
    
    
    
    fileprivate func getBannerData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        NetworkManager.post_Request2(urlService: kBanner_URL, param: nil, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let jsonResponse = try JSON(data:response as! Data)
                    let result = jsonResponse["result"]
                    let popstatus = jsonResponse["popup_status"].intValue
                    let popString = jsonResponse["popup_image"].stringValue
                    let cashfree = jsonResponse["cashfree"].intValue
                    let paytm = jsonResponse["paytm"].intValue
                    let razorpay = jsonResponse["razorpay"].intValue
                    APP_DEL.appStoreUrl = jsonResponse["ios_url"].stringValue
                    let ismantananceView = jsonResponse["is_maintenance"].intValue
                    UserDefaults.standard.set(cashfree, forKey: "cashfree")
                    UserDefaults.standard.set(razorpay, forKey: "razorpay")
                    UserDefaults.standard.set(paytm, forKey: "paytm")
                    self.bannerDataArray.removeAll()
                    for arr in result.arrayValue {
                        self.bannerDataArray.append(BannerResponses(json:arr))
                    }
                    if ismantananceView == 1 {
                        DispatchQueue.main.async {
                            self.AddMaintananceView()
                        }
                    }
                    else {
                        if popstatus == 1 {
                            DispatchQueue.main.async {
                                self.stringPopImage = popString
                                //                            self.performSegue(withIdentifier: "PopupImageViewController", sender: nil)
                                self.popImageView()
                            }
                        }
                    }
                }
                else {
                    Loader.showAlert(message: "Unable to get Banner data")
                }
            }
            catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    fileprivate func popImageView() {
        if changePasswordView == nil {
            self.view.isUserInteractionEnabled = false
            changePasswordView = Bundle.main.loadNibNamed("PopImageView", owner: self, options: nil)?.first as? PopImageView
            changePasswordView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            changePasswordView?.imageStrng = self.stringPopImage
            changePasswordView?.closeButtonClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.removeChangePassView()
                }
            }
            
        APP_DEL.window?.addSubview(changePasswordView!)
        }
    }
    
    
    fileprivate func AddMaintananceView() {
        if isMaintanceViewAvail == nil {
            self.view.isUserInteractionEnabled = false
            isMaintanceViewAvail = Bundle.main.loadNibNamed("MaintananceView", owner: self, options: nil)?.first as? MaintananceView
            //            changePasswordView?.frame = CGRect(x: ScreenSize.SCREEN_WIDTH/2 - self.view.frame.width * 0.9 / 2 , y: ScreenSize.SCREEN_HEIGHT/2 - self.view.frame.height * 0.6 / 2, width: self.view.frame.width * 0.9 , height: self.view.frame.height * 0.6)
            isMaintanceViewAvail?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            
            APP_DEL.window?.addSubview(isMaintanceViewAvail!)
        }
    }
    
    
    
    fileprivate func moveSelectionViewbase(index: Int) {
        let selectionViewWidth = Int(ScreenSize.SCREEN_WIDTH / 3)
        switch index {
        //Live
        case 0:
            getCricketDaata()
            self.matchType = "CRICKET"
            kabaddImageView.tintColor = UIColor(red: 217, green: 180, blue: 181)
            footballImageView.tintColor = UIColor(red: 217, green: 180, blue: 181)
            
            kabaddiOutlt.setTitleColor(UIColor(red: 217, green: 180, blue: 181), for: .normal)
            footballOutlt.setTitleColor(UIColor(red: 217, green: 180, blue: 181), for: .normal)
            UIView.animate(withDuration: 0.2) {
                
                self.cricketImageView.tintColor = UIColor(red: 255, green: 253, blue: 166)
                self.selectionView.frame = CGRect(x: 0, y: 47, width: selectionViewWidth, height: 3)
                self.cricketOutlt.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            }
        //upcoming
        case 1:
            getFootbaalResponse()
            self.matchType = "FOOTBALL"
            cricketImageView.tintColor = UIColor(red: 217, green: 180, blue: 181)
            footballImageView.tintColor = UIColor(red: 217, green: 180, blue: 181)
            cricketOutlt.setTitleColor(UIColor(red: 217, green: 180, blue: 181), for: .normal)
            footballOutlt.setTitleColor(UIColor(red: 217, green: 180, blue: 181), for: .normal)
            
            UIView.animate(withDuration: 0.2) {
                self.selectionView.frame = CGRect(x:  (0 + (selectionViewWidth * index)) , y: 47, width: selectionViewWidth, height: 3)
                self.kabaddImageView.tintColor = UIColor(red: 255, green: 253, blue: 166)
                self.kabaddiOutlt.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            }
        //Result
        case 2:
            getBasketBallResponse()
            
            self.matchType = "BASKETBALL"
            cricketImageView.tintColor = UIColor(red: 217, green: 180, blue: 181)
            kabaddImageView.tintColor = UIColor(red: 217, green: 180, blue: 181)
            cricketOutlt.setTitleColor(UIColor(red: 217, green: 180, blue: 181), for: .normal)
            kabaddiOutlt.setTitleColor(UIColor(red: 217, green: 180, blue: 181), for: .normal)
            
            UIView.animate(withDuration: 0.2) {
                self.footballImageView.tintColor = UIColor(red: 255, green: 253, blue: 166)
                self.selectionView.frame = CGRect(x:(0 + (selectionViewWidth * index))  , y: 47, width: selectionViewWidth, height: 3)
                self.footballOutlt.setTitleColor(UIColor(red: 255, green: 253, blue: 166), for: .normal)
            }
            
        default:
            break
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        visibleCellIndex = Utility.findCenterCellIndex(collectionView: homeCollectionView)
        
    }
    
    func registerCell() {
        atableView.register(UINib(nibName: BannerTVCell.identifier(), bundle: nil), forCellReuseIdentifier: BannerTVCell.identifier())
        homeCollectionView.register(UINib(nibName: HomeVCCollectionCEll.identifier(), bundle: nil), forCellWithReuseIdentifier: HomeVCCollectionCEll.identifier())
    }
    
}


extension MainHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeVCCollectionCEll.identifier(), for: indexPath) as! HomeVCCollectionCEll
        
        
        
        cell.contestData.removeAll()
        cell.delegate = self
        switch indexPath.item {
            
        case 0:
            cell.matchType = .cricket
            cell.contestData.removeAll()
            if getCricketData.count > 0 {
                cell.contestData = getCricketData
                cell.showNoDataLabel(show: false, text: "")
            } else {
                cell.showNoDataLabel(show: true, text: "No Upcomming Match Found")
            }
            
        //live
        case 1:
            
            cell.matchType = .football
            cell.contestFootballData.removeAll()
            if getFootbaalData.count > 0 {
                cell.contestFootballData = getFootbaalData
                cell.showNoDataLabel(show: false, text: "")
            } else {
                cell.showNoDataLabel(show: true, text: "No Finished Match Found")
                
            }
        //result
        case 2:
            cell.matchType = .kabaddi
            cell.contestKabaddiData.removeAll()
            
            if getKabaddiData.count > 0 {
                cell.contestKabaddiData = getKabaddiData
                cell.showNoDataLabel(show: false, text: "")
            } else {
                cell.showNoDataLabel(show: true, text: "No Live Match Found")
            }
        default:
            break
        }
        cell.itematIndex = indexPath.item
        return cell
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: homeCollectionView.frame.width, height: homeCollectionView.frame.height)
        
        
    }
    
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


// Conform prototype to get macth Details

extension MainHomeViewController :MatchTypeDetails {
    func sendgetMatchDetail(contstData: GetMatchDetails, matchType: String) {
        openChallengeViewController(contest: contstData, match: matchType)
    }
    
    func openChallengeViewController(contest: GetMatchDetails,match:String) {
        openViewController(controller: LeagueCollectionViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.getContestDetail = contest
            vc.matchTYPES = match
            vc.totalAmountString = self.amountLbl.text
            
        }
    }
    
    func openReferViewController(url:String){
        
        let myUrl = url
        if let url = URL(string: "\(myUrl)"), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        
        
    }
}
// Table view delegate and DataSouce for Banner
extension MainHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BannerTVCell.identifier(), for: indexPath) as! BannerTVCell
        cell.bannerArr = bannerDataArray
        
        
        cell.bannerSelection =  {[weak self] val in
            if let strongSelf = self {
                strongSelf.openReferViewController(url: val)
                
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return kBannerTVCellIHeight
        
        
    }
    
}

extension MainHomeViewController:hitBannerData {
    func check(check: Bool) {
        updateTeam = check
    }
    
    
}
