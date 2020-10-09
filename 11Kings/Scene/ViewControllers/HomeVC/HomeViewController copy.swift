////
////  HomeViewController.swift
////
////
////  Created by Test on 11/05/20.
////
////
import UIKit
import MBProgressHUD
import Alamofire
import AuthenticationServices
import SwiftyJSON
class HomeViewController: BaseClass {


    @IBOutlet weak var navigationUI: UIView!
    @IBOutlet weak var CricketMatch: UIButton!
    @IBOutlet weak var kabaddiMatch: UIButton!
    @IBOutlet weak var footballMatch: UIButton!

    @IBOutlet weak var tableView: UITableView!
    var userDetail:UserDetailsResponse?

    //    var contestData = [getMatchDetails]() {
    //        didSet {
    var selectedContest: ((GetMatchDetails, String, HomeType) -> Void) = { _, _, _  in }
    @IBOutlet weak var liveBtn: UIView!

    var userDetailArray: UserDetailsResponses? {
        didSet {
            configureUserFullData()
        }
    }
    func configureBankData() {

        UserDefaults.standard.set(bankDetailsArray?.accno, forKey: kBankAccountNo)


    }
    func configureUserFullData() {
        //   UserDefaults.standard.set(userDetailArray, forKey: "UserDetail")
        UserDefaults.standard.set(userDetailArray?.email, forKey: kEmailId)
        UserDefaults.standard.set(userDetailArray?.mobile, forKey: kMobileNumber)
        UserDefaults.standard.set(userDetailArray?.refercode, forKey: kReferCode)
    }

    var panArray:PanResponse?
    var panDetailsArray: PanDetailResponse? {
        didSet {
            configurePanData()
        }
    }
    var bankDetailsArray:BankDetailResponse? {
        didSet {
            configureBankData()
        }
    }
    func configurePanData() {

        UserDefaults.standard.set(panDetailsArray?.pannumber, forKey: kPanCardNo)

    }
    var homeType: HomeType = .live
    var liveData = [GetMatchDetails]()




    var getMatch:JSON!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         getLiveData()
        getPanDetailAla()
        getUserProfileData()
        getBankDetails()
        getPanDetails()

        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.FlatColor.Black.balckcolor
        navigationUI.backgroundColor =  UIColor.FlatColor.Black.balckcolor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        //        addNavigationBar(navigationTitle: "DreamTeam", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: false, isWalletButtonShow: true, isBinButtonShow: false)
        //getLiveData()

        setNeedsStatusBarAppearanceUpdate()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func getLiveData() {
        self.showActivityIndicator(sMessage: "..Loading")
        CricketMatch.setTitleColor(UIColor.black, for: .normal)
        let headers = [
            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYuZmFudGFzeXBvd2VyMTEuY29tXC9uZXdfYXBpXC9mcDExXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTg3NTU5Nzg2LCJleHAiOjE1ODc2NDYxODYsIm5iZiI6MTU4NzU1OTc4NiwianRpIjoibGVCRm1jV1FjQ3B5TGJBaSIsInN1YiI6OTkxMTcsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.mRtYmTgwyZDJApSar19QXI1x1EAiPiww-vSr3QBrh-U",
            "Content-Type":"application/json",
            "Accept" :"application/json"]


        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {

            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let param = ["user_id":UserDic.value(forKey: "user_id"),
                         "sport_key":"CRICKET"]
            NetworkManager.post_Request2(urlService: kgetMatchList, param: param as [String : Any], head: headers){
                (response) in
                
            
           
                self.hideActivityIndicator()
                guard let data = response else { return }
                do{
                    let json = try JSON(data:data as! Data)
                    let results = json["result"]
                    self.liveData.removeAll()
                    for arr in results.arrayValue{

                        self.liveData.append(GetMatchDetails(json: arr))

                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
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

                                   MBProgressHUD.hide(for: self.view, animated: true)

                                    // Saved Registered User Data
                                    let UserDataDic = result.value(forKey: "value") as? NSDictionary ?? [:]
                                                       UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: UserDataDic), forKey: "UserDetail")

                                                       // Get Login User Data
                              if let heroObject = UserDefaults.standard.value(forKey: "UserDetail") as? NSData {

                              let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                                let value = UserDic.value(forKey:"mobile")
                                               UserDefaults.standard.set(value, forKey: kMobileNumber)
                                    print(UserDic)
                                    }
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
            func getBankDetails() {
                showActivityIndicator(sMessage: "Loading...")
                let headers = [
                    "content-type": "application/x-www-form-urlencoded",
                    "cache-control": "no-cache"
                ]
                if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {

                    let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                    let parameters = ["user_id": UserDic.value(forKey: "user_id")]

                    NetworkManager.post_Request3(urlService: kBankDetailsURL, param: parameters as [String : Any], head: headers) { (response) in
                        self.hideActivityIndicator()
                        do {
                            if response != nil {
                                let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                                let responseModel = try JSONDecoder().decode(BankDetailResponse.self, from: responseData)
                                self.bankDetailsArray = responseModel
                            }
                        } catch {
                            Loader.showAlert(message: "Status code 500: server internal error")
                        }
                    }
                }

            }

    func savePanNo() {
        let pannp:String = panArray?.pannumber ?? ""
        
        UserDefaults.standard.set(pannp, forKey: kPanCardNo) 
        
      //  print(UserDefaults.value(forKey: kPanCardNo))
    }
            func getPanDetailAla() {
                           showActivityIndicator(sMessage: "Loading...")
                           let headers = [
                               "Content-Type": "application/x-www-form-urlencoded",
                               "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTU5MTM3MywiZXhwIjoxNTY1NTk0OTczLCJuYmYiOjE1NjU1OTEzNzMsImp0aSI6InEwNFJpdFc5dXBua080bU8iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.eSHL2YHOeqthUpUnJ1F8Pk5kkUpH4nUHhZ_DBGOJRus",
                               "Accept": "application/json",
                               "cache-control": "no-cache"
                           ]
                           if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {

                               let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                               let parameters = ["user_id": UserDic.value(forKey: "user_id")]

                               NetworkManager.post_Request(urlService: kPanDetailsURL, param: parameters as [String : Any], head: headers) { (response) in
                                   self.hideActivityIndicator()
                                   do {
                                       if response != nil {
                                        let json = try JSON(data: response as! Data)
                                        let result = json["result"]
                                        self.panArray =  PanResponse(json: result)
                                        self.savePanNo()
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
                    "Content-Type": "application/x-www-form-urlencoded",
                    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTU5MTM3MywiZXhwIjoxNTY1NTk0OTczLCJuYmYiOjE1NjU1OTEzNzMsImp0aSI6InEwNFJpdFc5dXBua080bU8iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.eSHL2YHOeqthUpUnJ1F8Pk5kkUpH4nUHhZ_DBGOJRus",
                    "Accept": "application/json",
                    "cache-control": "no-cache"
                ]
                if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {

                    let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                    let parameters = ["user_id": UserDic.value(forKey: "user_id")]

                    NetworkManager.post_Request3(urlService: kPanDetailsURL, param: parameters as [String : Any], head: headers) { (response) in
                        self.hideActivityIndicator()
                        do {
                            if response != nil {
                                let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                                let responseModel = try JSONDecoder().decode(PanDetailResponse.self, from: responseData)
                                self.panDetailsArray = responseModel
                            }
                        } catch {
                            Loader.showAlert(message: "Status code 500: server internal error")
                        }
                    }
                }
            }

        }



        extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return liveData.count
            }

            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

                let cell = tableView.dequeueReusableCell(withIdentifier:  "AllMatch", for: indexPath) as! AllMatchDetailTableViewCell



                cell.configureMyContestCell(data: liveData[indexPath.row])

                return cell
            }
           

            func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let data = liveData[indexPath.row]
                openChallengeViewController(contest: data)
            }
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "segue" {
                    // Setup new view controller
                }
            }
            func openChallengeViewController(contest: GetMatchDetails) {
                openViewController(controller: LeagueCollectionViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                    vc.getContestDetail = contest
                    // vc.homeType = homeType
                }
            }
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return kContestTVCellHeight
            }
            func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
            {
                let verticalPadding: CGFloat = 30

                let maskLayer = CALayer()
                maskLayer.cornerRadius = 10    //if you want round edges
                maskLayer.backgroundColor = UIColor.black.cgColor
                maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/3)
                cell.layer.mask = maskLayer
            }
            func senddata() {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                //        let destination = storyboard.instantiateViewController(withIdentifier: "YourViewController") as! LeaguesViewController
                //        navigationController?.pushViewController(destination, animated: true)
            }

        }
        extension String {
            func toImage() -> UIImage? {
                if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
                    return UIImage(data: data)
                }
                return nil
            }
}

//  HomeViewController.swift
//
//
//  Created by Test on 11/05/20.
//
//
//import UIKit
//import MBProgressHUD
//import Alamofire
//import AuthenticationServices
//import SwiftyJSON
//class HomeViewController: BaseClass {
//
//
//    @IBOutlet weak var navigationUI: UIView!
//    @IBOutlet weak var CricketMatch: UIButton!
//    @IBOutlet weak var kabaddiMatch: UIButton!
//    @IBOutlet weak var footballMatch: UIButton!
//
//    @IBOutlet weak var tableView: UITableView!
////    var contestData = [getMatchDetails]() {
////        didSet {
//     var selectedContest: ((GetMatchDetails, String, HomeType) -> Void) = { _, _, _  in }
//    @IBOutlet weak var liveBtn: UIView!
//    //            tableView.reloadDataInMainQueue()
////        }
////    }
//      var homeType: HomeType = .live
//    var liveData = [GetMatchDetails]()
//
//
//
//
//    var getMatch:JSON!
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getLiveData()
//        self.navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = UIColor.FlatColor.Black.balckcolor
//        navigationUI.backgroundColor =  UIColor.FlatColor.Black.balckcolor
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//         navigationController?.setNavigationBarHidden(true, animated: animated)
////        addNavigationBar(navigationTitle: "DreamTeam", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: false, isWalletButtonShow: true, isBinButtonShow: false)
//        //getLiveData()
//
//            setNeedsStatusBarAppearanceUpdate()
//    }
//   override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//    func getLiveData() {
//        self.showActivityIndicator(sMessage: "..Loading")
//        CricketMatch.setTitleColor(UIColor.black, for: .normal)
//        let headers = [
//            "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYuZmFudGFzeXBvd2VyMTEuY29tXC9uZXdfYXBpXC9mcDExXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTg3NTU5Nzg2LCJleHAiOjE1ODc2NDYxODYsIm5iZiI6MTU4NzU1OTc4NiwianRpIjoibGVCRm1jV1FjQ3B5TGJBaSIsInN1YiI6OTkxMTcsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.mRtYmTgwyZDJApSar19QXI1x1EAiPiww-vSr3QBrh-U",
//            "Content-Type":"text/plain",
//            "Accept" :"application/json"]
//
//
//        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
//
//            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
//            let param = ["user_id":UserDic.value(forKey: "user_id"),
//                         "sport_key":"CRICKET"]
//        Alamofire.request(UrlService.getmatchkey, method: .post, parameters: param as Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
//            self.hideActivityIndicator()
//                guard let data = response.data else { return }
//                           do{
//                               let json = try JSON(data:data)
//                               let results = json["result"]
//                              self.liveData.removeAll()
//                               for arr in results.arrayValue{
//
//                                   self.liveData.append(GetMatchDetails(json: arr))
//
//                            }
//                            DispatchQueue.main.async {
//                                               self.tableView.reloadData()
//                                           }
//                           }catch{
//                               print(error.localizedDescription)
//                           }
//                       }.resume()
//            }
//    }
//}
//
//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return liveData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier:  "AllMatch", for: indexPath) as! AllMatchDetailTableViewCell
//
//
//
//        cell.configureMyContestCell(data: liveData[indexPath.row])
//
//        return cell
//    }
//    func selectedContestAction(contest: GetMatchDetails, format: String, homeType: HomeType) {
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let data = liveData[indexPath.row]
//        openChallengeViewController(contest: data)
//        }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segue" {
//            // Setup new view controller
//        }
//    }
//   func openChallengeViewController(contest: GetMatchDetails) {
//          openViewController(controller: LeagueCollectionViewController.self, storyBoard: .homeStoryBoard) { (vc) in
//              vc.getContestDetail = contest
//             // vc.homeType = homeType
//          }
//      }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return kContestTVCellHeight
//    }
//   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//   {
//       let verticalPadding: CGFloat = 30
//
//       let maskLayer = CALayer()
//       maskLayer.cornerRadius = 10    //if you want round edges
//       maskLayer.backgroundColor = UIColor.black.cgColor
//    maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/3)
//       cell.layer.mask = maskLayer
//   }
//    func senddata() {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
////        let destination = storyboard.instantiateViewController(withIdentifier: "YourViewController") as! LeaguesViewController
////        navigationController?.pushViewController(destination, animated: true)
//    }
//
//}
//extension String {
//    func toImage() -> UIImage? {
//        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
//            return UIImage(data: data)
//        }
//        return nil
//    }
//}
