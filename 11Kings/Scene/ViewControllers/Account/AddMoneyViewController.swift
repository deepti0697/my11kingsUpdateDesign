//
//  AddMoneyViewController.swift
//  Club11
//
//  Created by Developer on 26/05/19.
//

import UIKit
import PaymentSDK
import CFSDK
import SwiftyJSON
class AddMoneyViewController: BaseClass {
    
    @IBOutlet weak var promoAppliedLbl: UILabel!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aPromoCodeTextField: UITextField!
    @IBOutlet weak var aTotalAmountTextfield: UITextField!
    @IBOutlet weak var aTwoFiftyButton: UIButton!
    @IBOutlet weak var aFiveHundredButton: UIButton!
    @IBOutlet weak var aTwoThousandButton: UIButton!
    @IBOutlet weak var aOneThousandButton: UIButton!
    @IBOutlet weak var aApplyButtonButton: UIButton!
    @IBOutlet weak var aUnutilizedCashLabel: UILabel!
    @IBOutlet weak var availableBlc: UILabel!
    @IBOutlet weak var fanCash: UILabel!
    var bonusCash = ""
    var depositAmount = ""
    var winnings = ""
    var addAmount = "0"
    @IBOutlet weak var winningLbl: UILabel!
    //https://club11.co.in/api/get_cashfree_checksum
    

    var totalAmount = 0 {
        didSet {
            self.aTotalAmountTextfield.text = "\(totalAmount)"
        }
    }
    var myBalanceDataArray = [BalanceModel]() {
        didSet {
            setAccountData()
        }
    }
    var applyPromoCode = ""
    var isFromVC: UIViewController?

    let environment = "PROD" // Use "PROD" when you are ready to go live.
    let appId = "38933b9397fa24aa1cb275a1d33983" // <-Prod // "63254b2e71265f0516721e205236" // <-Test
    let appSecret = "5ec949ef9c42ca1e909ab38152ba02692939e2fe"
//    "cb4c4d8c592339dc01b315fcca5ba5bbd8add165" // <-Prod  "5ec949ef9c42ca1e909ab38152ba02692939e2fe" // <-Test
    let color1Hex = "#6a5594ff"
    let merchantName = "Club11"
    let notifyUrl = "https://admin.my11kings.in/admin/11Mykings_admin/admin/cashfree-notify"
    
    var customerPhone = "" // change when you are ready to go live.
    var customerEmail = "" // change when you are ready to go live.
    var orderId = ""
    let orderAmount = ""
    var customerID = ""
    let customerName = ""
    let orderNote = "This is a test note"
    var paymentReady = "CFTOKEN_VALUE"
    var source_config = "iossdk" // MUST be "iossdk"
    let paymentOption = ""    // Available values: cc, dc, nb, paypal, wallet. Leave it blank if you want to display all modes
    
    var isPaymentModePaytm = false
    var isPaymentModeCashFree = false
    var usableBlc = [userUsableBlc]()
    var challengeID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        aTotalAmountTextfield.delegate = self
        totalAmount = 0

    }
    func cashSetup() {
        aTotalAmountTextfield.text = addAmount
        availableBlc.text = depositAmount
        fanCash.text = bonusCash
        winningLbl.text = winnings
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchAccountUsableData()
        cashSetup()
        aPromoCodeTextField.text = ""
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        aTotalAmountTextfield.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func backAccountViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func setupUI() {
        
        aPromoCodeTextField.setLeftPaddingPoints(10.0)
        aTotalAmountTextfield.setLeftPaddingPoints(10.0)
    }
    func fetchAccountUsableData() {
           showActivityIndicator(sMessage: "Loading...")
           let headers = [
               
               "Content-Type": "application/json",
               "cache-control": "no-cache"
           ]
           if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
               
               let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
               let parameters = ["user_id": UserDic.value(forKey: "user_id"),"challengeid":challengeID]
               NetworkManager.post_Request2(urlService: kUsableBalance, param: parameters as [String : Any], head: headers) { (response) in
                   self.hideActivityIndicator()
                   do {
                       if response != nil {
                           let json = try JSON(data:response as! Data)
                           let result = json["result"]
                        self.usableBlc.removeAll()
                           for arr in result.arrayValue {
                               self.usableBlc.append(userUsableBlc(json:arr))
                           }
                      
                        self.cashSetup()
                       } else {
                           Loader.showAlert(message: "Unable to get Account Data")
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
    
    func setAccountData() {
        guard myBalanceDataArray.count > 0  else {
            return
        }
        let data = myBalanceDataArray[0]
//        aUnutilizedCashLabel.text = "\(kRupeeIcon) \(data.totalamount ?? 0)"
    }
    
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func fiveHundredButton(_ sender: UIButton) {
        if let text = aTotalAmountTextfield.text, let amountInTextField = Int(text) {
            totalAmount = amountInTextField + 500
        } else {
            totalAmount += 500
        }
    }
    @IBAction func twoFiftyButtonAction(_ sender: UIButton) {
        var tempBal = totalAmount
        if let text = aTotalAmountTextfield.text, let amountInTextField = Int(text) {
            tempBal = amountInTextField
        } else {
            tempBal = 0
        }
        totalAmount = tempBal + 250
        
    }
    @IBAction func twoThousandButton(_ sender: UIButton) {
        var tempBal = totalAmount
        if let text = aTotalAmountTextfield.text, let amountInTextField = Int(text) {
            tempBal = amountInTextField
        } else {
            tempBal = 0
        }
        totalAmount = tempBal + 2000
        
    }
    @IBAction func oneThousandButton(_ sender: UIButton) {
        var tempBal = totalAmount
        if let text = aTotalAmountTextfield.text, let amountInTextField = Int(text) {
            tempBal = amountInTextField
        } else {
            tempBal = 0
        }
        totalAmount = tempBal + 1000
        
    }
    @IBAction func applyPromoButtonAction(_ sender: Any) {
        callApplyPromoCode(promoCode: aPromoCodeTextField.text ?? "")
    }
    
    func callApplyPromoCode(promoCode: String) {
        if aPromoCodeTextField.text == "" {
            Loader.showToast(message: "Please enter promo code", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
            return
        }
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Content-Type": "application/json",
            "Accept":"application/json",
            "cache-control": "no-cache"
        ]
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                  
                  let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            let parameters = ["user_id": UserDic.value(forKey: "user_id"),"promo":promoCode]
            NetworkManager.post_Request2(urlService: kApplyPromoCode, param: parameters as [String : Any], head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let json = try JSON(data:response as! Data)
                    let jsonresult = json["status"].intValue
                    let jsonmsg = json["message"].stringValue
                    if jsonresult == 1 {
                         self.applyPromoCode = promoCode
                        self.promoAppliedLbl.isHidden = false
                         Loader.showToast(message: jsonmsg, onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 22))
                    }
                    else {
                         self.promoAppliedLbl.isHidden = true
                         Loader.showToast(message: jsonmsg, onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                    }
                   
                
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
        }
    }
    
    @IBAction func paytmButtonAction(_ sender: UIButton) {
        isPaymentModePaytm = true
        isPaymentModeCashFree = false
        if let here = UserDefaults.standard.value(forKey: "UserDetail") as? NSData {
                          
        let UserDic2 = NSKeyedUnarchiver.unarchiveObject(with: here as Data) as! NSDictionary
        
        
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                          
        let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
        if let amtStr = aTotalAmountTextfield.text {
            if amtStr == "" {
                Loader.showToast(message: "Please enter amount", onView: self.view, bottomMargin: 200, color: .black)
                return
            }
            if let amtInt = Int(amtStr) {
                if amtInt < 1 {
                    Loader.showToast(message: "Minimum 1 Rs. for add", onView: self.view, bottomMargin: 200, color: .black)
                    return
                }
            }
        }
            if let userEmail = UserDic.value(forKey: "email") as? String {
            self.customerEmail = userEmail
                self.customerPhone = UserDic.value(forKey: "mobile") as? String ?? UserDic2.value(forKey: "mobile") as? String ?? "0"
        } else {
            Loader.showToast(message: "Email address not verified", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
            return
        }
        orderId = "\(Int.random(in: 0..<10000000000000))"
       
            customerID = "\(UserDic.value(forKey: "user_id") ?? "")"
       
        }
        }
    }

  
    
    func addFundRequest(txnID: String, orderID: String, paymentType: String, amount: String) {
        showActivityIndicator(sMessage: "Loading...")
//        let headers = [
//            "content-type": "application/x-www-form-urlencoded",
//            "cache-control": "no-cache"
//        ]
//        let parameters = ["userid": UserDefaults.standard.object(forKey: kUserId) ?? -1,"amount": amount, "paymentby" : paymentType, "promo": applyPromoCode,"paytid": orderID,"TXNID": txnID,] as [String : Any]
//
//        NetworkManager.post_Request(urlService: kAndroidAddfundURL, param: parameters, head: headers) { (response) in
//            self.hideActivityIndicator()
//            do {
//                if response != nil {
//                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
//                    print("\(responseData)")
//                    let responseModel = try JSONDecoder().decode([AddFundResponse].self, from: responseData)
//                    if responseModel[0].status == 1 {
//                        Loader.showToast(message: responseModel[0].msg ?? "Fund Add Successfully", onView: self.view, bottomMargin: 200)
//                    } else {
//                        Loader.showToast(message: responseModel[0].msg ?? "Unable To Add Fund", onView: self.view, bottomMargin: 200)
//                    }
//
//                }
//            } catch {
//                Loader.showAlert(message: "Status code 500: server internal error")
//            }
//        }
    }
    
    fileprivate func goToPreviousController() {
        if isFromVC == nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            if var viewControllers = self.navigationController?.viewControllers {
                viewControllers = viewControllers.reversed()
                for currentViewController in viewControllers {
                    if currentViewController == isFromVC {
                        self.navigationController?.popToViewController(currentViewController, animated: true)
                        break
                    }
                }
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func AddmoneyVCOpen(_ sender: Any) {
//          performSegue(withIdentifier: "openPayment", sender: nil)
        if let amtStr = aTotalAmountTextfield.text {
            if amtStr == "" {
                Loader.showToast(message: "Please enter amount", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                return
            }
            if let amtInt = Int(amtStr) {
                if amtInt < 1 {
                    Loader.showToast(message: "Minimum 1 Rs. for add", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                    return
                }
            }
        }
  openViewController(controller: PauemtOptionsViewController.self, storyBoard: .accountStoryBoard) { (vc) in
    vc.amtTxt = self.aTotalAmountTextfield.text ?? "10"
        // vc.homeType = homeType
    }
    }
  
}

extension AddMoneyViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == aTotalAmountTextfield {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
