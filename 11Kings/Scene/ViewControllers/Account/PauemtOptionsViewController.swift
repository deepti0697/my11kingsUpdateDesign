    //
    //  PauemtOptionsViewController.swift
    //  DreamTeam
    //
    //  Created by Test on 01/06/20.
    //  Copyright © 2020 Macbook. All rights reserved.
    //

    import UIKit
    import PaymentSDK
    import SwiftyJSON
    import CFSDK
    import Alamofire
    import Razorpay
    class PauemtOptionsViewController: BaseClass,PGTransactionDelegate, ResultDelegate {
        func onPaymentCompletion(msg: String) {
          let inputData = msg.data(using: .utf8)!
                     let decoder = JSONDecoder()
                     if msg != "" {
                         do {
                             let result = try decoder.decode(CashFreeResult.self, from: inputData)
                             print(result.orderId)
                             print(result)
                             self.addFundRequest(txnID: result.referenceId, orderID: result.orderId, paymentType: "cashfree", amount: result.orderAmount)
                         } catch {
                             // handle exception
                             print("BDEBUG: Error Occured while retrieving transaction response")
                         }
                     } else {
                         print("BDEBUG: transactionResult is empty")
                     }
                     self.goToPreviousController()
                 }
        
            
//            addFundRequest(txnID: orderId, orderID: orderId, paymentType: "Cashfree", amount: amtTxt)
        
        @IBOutlet weak var razorView: UIView!
        
        @IBOutlet weak var paytmView: UIView!
        @IBOutlet weak var cashfreeView: UIView!
        @IBOutlet weak var stackViewHieght: NSLayoutConstraint!
        var rajorWallet:RazorPayResult?
        var razorpay: RazorpayCheckout!
        var totalAmount = 0
        @IBOutlet weak var amountLbl: UILabel!
        var paytmResponse: PaytmCheckSumResponse? {
            didSet {
                initaitePaytmPayment()
            }
        }
        var lblarra = ["PayTm","CashFree","Credit Debit,Netbanking,UPI Payments"]
        var imageArray = [#imageLiteral(resourceName: "Group 8701"),#imageLiteral(resourceName: "Mask Group 15"),#imageLiteral(resourceName: "razorPay")]
        let environment = "PROD" // Use "PROD" when you are ready to go live.
             let appId = "38933b9397fa24aa1cb275a1d33983" // <-Prod // "63254b2e71265f0516721e205236" // <-Test
             let appSecret = "9e260d0ea12e31f9d072a2b7490f9bc9e3926310"

//" // <-Prod  "5ec949ef9c42ca1e909ab38152ba02692939e2fe" // <-Test
             let color1Hex = "#6a5594ff"
             let merchantName = "My11Kings"
             let notifyUrl = "https://admin.my11kings.in/admin/11Mykings_admin/admin/cashfree-notify"
             let orderNote = "This is a test note"
             var paymentReady = "CFTOKEN_VALUE"
             var source_config = "iossdk" // MUST be "iossdk"
             let paymentOption = ""
        var isFromVC: UIViewController?
        var customerPhone = "" // change when you are ready to go live.
        var customerEmail = "" // change when you are ready to go live.
        var orderId = ""
        let orderAmount = ""
        var customerID = ""
        var customerName = ""
        var amtTxt = ""
        var fundData: AddFundWallet?
        var paymentCount = 0
        var razorpayTestKey = "rzp_live_dQtOKLarDzPMfv"
        
        func setUP() {
            if UserDefaults.standard.value(forKey: "paytm") as? Int == 1 {
                paymentCount = paymentCount + 1
            }
            if UserDefaults.standard.value(forKey: "cashfree") as? Int == 1 {
                paymentCount = paymentCount + 1
            }
            if UserDefaults.standard.value(forKey: "razorpay") as? Int == 1 {
                           paymentCount = paymentCount + 1
            }
        }
       
        override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            amountLbl.text = amtTxt
            paymentSetup()
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            razorpay = RazorpayCheckout.initWithKey(razorpayTestKey, andDelegate: self)
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            // Do any additional setup after loading the view.
//           get()
        }
        
//        override var preferredStatusBarStyle: UIStatusBarStyle {
//            if #available(iOS 13.0, *) {
//                return .darkContent
//            } else {
//                // Fallback on earlier versions
//            }
//        }
        override func viewWillDisappear(_ animated: Bool) {
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
                   // Do any additional setup after loading the view.
             self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        func cashFree() {
            self.getCashfreeToken(completion: {
                        DispatchQueue.main.async {
                            let cashfreeVC = CFViewController(params: self.getPaymentParams(), appId: self.appId, env: self.environment, callBack: self)
            self.navigationController?.pushViewController(cashfreeVC, animated: true)
            
        }
            })
        }
        func  getPaymentParams() -> Dictionary<String, String> {
                return [
                    "orderId": self.orderId,
                "tokenData" : paymentReady,
                "orderAmount": amtTxt,
                "customerName": customerName,
                "orderNote": orderNote,
                "orderCurrency": "INR",
                "customerPhone": customerPhone,
                "customerEmail": customerEmail,
                "notifyUrl": notifyUrl
                ]
        }
        
         private func getCashfreeToken(completion:@escaping ()->()) {
        if let here = UserDefaults.standard.value(forKey: "UserDetail") as? NSData {
                         
              let UserDic2 = NSKeyedUnarchiver.unarchiveObject(with: here as Data) as! NSDictionary
              
             if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                                
              let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                  if let userEmail = UserDic.value(forKey: "email") as? String {
                  self.customerEmail = userEmail
                    let value = UserDic.value(forKey:"mobile")
                                  UserDefaults.standard.set(value, forKey: kMobileNumber)
                                  self.customerPhone = "\(UserDefaults.standard.value(forKey: kMobileNumber) ?? "")"
                      
              } else {
                  Loader.showToast(message: "Email address not verified", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                  return
              }
                customerName = UserDic2.value(forKey: "username") as? String ?? ""
                    orderId = ""
                    customerID = ""
                    orderId = "\(Int.random(in: 0..<10000000000000))"
                customerID = "\(UserDic.value(forKey: "user_id") ?? "")"
                let Url = String(format: "https://api.cashfree.com/api/v2/cftoken/order")
                guard let serviceUrl = URL(string: Url) else { return }
                let parameterDictionary = ["orderId": self.orderId,
                                           "orderAmount": Int(amtTxt) ?? 0,
                                           "orderCurrency": "INR"] as [String : Any]
                var request = URLRequest(url: serviceUrl)
                request.httpMethod = "POST"
                request.setValue(appId , forHTTPHeaderField: "X-Client-Id")
                request.setValue(appSecret, forHTTPHeaderField: "X-Client-Secret")
                request.setValue("application/json", forHTTPHeaderField:"Content-Type" )
                guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                    return
                }
                request.httpBody = httpBody
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    if response != nil {
                        //print(response)
                    }
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            //print(json)
                            if let token = (json as! NSDictionary)["cftoken"] as? String {
                                self.paymentReady = token
                                completion()
                            }
                        } catch {
                            print(error)
                        }
                    }
        
                    }.resume()
            }
            }
        }
        @IBAction func backToAccount(_ sender: Any) {
            
            self.navigationController?.popViewController(animated: true)
        }
        
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
        @IBAction func paytmAction(_ sender: Any) {
             getdata()
        }
        
        @IBAction func rzorPayAction(_ sender: Any) {
              addOrderId()
        }
        
        @IBAction func cashfreaAction(_ sender: Any) {
             cashFree()
        }
        func paymentSetup() {
            if UserDefaults.standard.value(forKey: "cashfree") as? Int == 0 {
                cashfreeView.isHidden = true
            }
            if UserDefaults.standard.value(forKey: "razorpay") as? Int == 0 {
                           razorView.isHidden = true
                       }
            if UserDefaults.standard.value(forKey: "paytm") as? Int == 0 {
                                      paytmView.isHidden = true
                                  }
            if UserDefaults.standard.value(forKey: "cashfree") as? Int == 1 {
                           cashfreeView.isHidden = false
                       }
                       if UserDefaults.standard.value(forKey: "razorpay") as? Int == 1 {
                                      razorView.isHidden = false
                                  }
                       if UserDefaults.standard.value(forKey: "paytm") as? Int == 1 {
                                                 paytmView.isHidden = false
                                             }
            if cashfreeView.isHidden == true &&  paytmView.isHidden == true {
                
                stackViewHieght.constant = 60
            }
           else   if cashfreeView.isHidden == true &&  razorView.isHidden == true {
             stackViewHieght.constant = 60
        }
            else  if cashfreeView.isHidden == false &&  razorView.isHidden == false && paytmView.isHidden == false {
             stackViewHieght.constant = 180
            }
            else if  cashfreeView.isHidden == true ||  paytmView.isHidden == true ||  razorView.isHidden == true  {
                stackViewHieght.constant = 120
            }
            else {
                 stackViewHieght.constant = 120
            }
        }
    }
    extension PauemtOptionsViewController:UITableViewDelegate,UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return lblarra.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPaymentTableViewCell", for: indexPath) as! AddPaymentTableViewCell

            cell.payLBL.text = lblarra[indexPath.row]
            cell.payimage.image = imageArray[indexPath.row]
        return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
            getdata()
            }
            if indexPath.row == 1 {
                cashFree()
            }
            if indexPath.row == 2 {
//                razorPayment()
            addOrderId()
            }
         
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    return  60
                }
        
        
            
       func  getdata(){
                    if let here = UserDefaults.standard.value(forKey: "UserDetail") as? NSData {
                    
         let UserDic2 = NSKeyedUnarchiver.unarchiveObject(with: here as Data) as! NSDictionary
         
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                           
         let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
             if let userEmail = UserDic.value(forKey: "email") as? String {
             self.customerEmail = userEmail
                let value = UserDic.value(forKey:"mobile")
                UserDefaults.standard.set(value, forKey: kMobileNumber)
                self.customerPhone = "\(UserDefaults.standard.value(forKey: kMobileNumber) ?? "")"
         } else {
             Loader.showToast(message: "Email address not verified", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
             return
         }
         orderId = "\(Int.random(in: 0..<10000000000000))"
        
             customerID = "\(UserDic.value(forKey: "user_id") ?? "")"
             getPaytmCheckSum()
        }
    }
    }
    }
    extension PauemtOptionsViewController {
         func getPaytmCheckSum() {
                showActivityIndicator(sMessage: "Loading...")
                let headers = [
                    "content-type": "application/x-www-form-urlencoded",
                    "cache-control": "no-cache"
                ]
                let parameters = ["MID": "LKPRFA86921657224548",
                                  "ORDER_ID": orderId,
                                  "CUST_ID": customerID,
                                  "MOBILE_NO": self.customerPhone,
                    "EMAIL": self.customerEmail,
                    "CHANNEL_ID": "WAP",
                    "WEBSITE": "DEFAULT",
                    "TXN_AMOUNT": amtTxt ,
                    "INDUSTRY_TYPE_ID": "Retail105",
                   
                    "CALLBACK_URL": "https://securegw.paytm.in/theia/paytmCallback?\(orderId)"]
                NetworkManager.post_Request3(urlService: kPayTmCheckSumURL, param: parameters, head: headers) { (response) in
                    self.hideActivityIndicator()
                    do {
                        if response != nil {
                            let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                            let responseModel = try JSONDecoder().decode(PaytmCheckSumResponse.self, from: responseData)
                            self.paytmResponse = responseModel
                        }
                    } catch {
                        Loader.showAlert(message: "Status code 500: server internal error")
                    }
                }
            }
            
            func initaitePaytmPayment() {
                guard let paytmParam = paytmResponse else {
                    Loader.showToast(message: "Unable To Get Paytm Data", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                    return
                }
                var serv = PGServerEnvironment()
                serv = serv.createProductionEnvironment()
                let type :ServerType = .eServerTypeProduction
                let order = PGOrder(orderID: "", customerID: "", amount: "", eMail: "", mobile: "")
                order.params = ["MID": paytmParam.mID ?? "LKPRFA86921657224548",
                                "ORDER_ID": paytmParam.oRDER_ID ?? orderId,
                                "CUST_ID": paytmParam.cUST_ID ?? customerID,
                                "MOBILE_NO": paytmParam.mOBILE_NO ?? self.customerPhone,
                    "EMAIL": paytmParam.eMAIL ?? self.customerEmail,
                    "CHANNEL_ID": paytmParam.cHANNEL_ID ?? "WAP",
                    "WEBSITE": paytmParam.wEBSITE ?? "DEFAULT",
                    "TXN_AMOUNT": paytmParam.tXN_AMOUNT ?? amtTxt ,
                    "INDUSTRY_TYPE_ID": paytmParam.iNDUSTRY_TYPE_ID ?? "Retail",
                    "CHECKSUMHASH": paytmParam.cHECKSUMHASH ?? "",
                    "CALLBACK_URL": paytmParam.cALLBACK_URL ?? "https://securegw.paytm.in/theia/paytmCallback?\(orderId)"]
                var txnController = PGTransactionViewController()
                txnController = txnController.initTransaction(for: order) as! PGTransactionViewController
                txnController.title = "Paytm Payments"
                txnController.setLoggingEnabled(true)
                if(type != ServerType.eServerTypeNone) {
                    txnController.serverType = type;
                } else {
                    return
                }
                txnController.merchant = PGMerchantConfiguration.defaultConfiguration()
                txnController.delegate = self
                self.navigationController?.pushViewController(txnController, animated: true)
            }
            
            func didFinishedResponse(_ controller: PGTransactionViewController, response responseString: String) {
                let msg : String = ""  //responseString
                var titlemsg : String = ""
                if let data = responseString.data(using: String.Encoding.utf8) {
                    do {
                        if let jsonresponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] , jsonresponse.count > 0{
                            let status = jsonresponse["STATUS"] as? String ?? ""
                            if status == "TXN_SUCCESS" {
                                let trasactionID = jsonresponse["TXNID"] as? String ?? ""
                                let orderID = jsonresponse["ORDERID"] as? String ?? ""
                                let amount = jsonresponse["TXNAMOUNT"] as? String ?? ""
                                self.addFundRequest(txnID: trasactionID, orderID: orderID, paymentType: "paytm", amount: amount)
                                print(status)
                                titlemsg = "Transaction Success"
                            } else {
                                Loader.showToast(message: "Transaction Failure", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                                titlemsg = "Transaction Failure"
                            }
                            
                        }
                    } catch {
                        Loader.showAlert(message: "Status code 500: server internal error")
                    }
                }
                let actionSheetController: UIAlertController = UIAlertController(title: titlemsg , message: msg, preferredStyle: .alert)
                let cancelAction : UIAlertAction = UIAlertAction(title: "OK", style: .cancel) {
                    action -> Void in
                    self.goToPreviousController()
                }
                actionSheetController.addAction(cancelAction)
                self.present(actionSheetController, animated: true, completion: nil)
            }
            
            func didCancelTrasaction(_ controller: PGTransactionViewController) {
                controller.navigationController?.popViewController(animated: true)
            }
            
            func errorMisssingParameter(_ controller: PGTransactionViewController, error: NSError?) {
                controller.navigationController?.popViewController(animated: true)
            }
          func addFundRequest(txnID: String, orderID: String, paymentType: String, amount: String) {
                showActivityIndicator(sMessage: "Loading...")
                let headers = [
                    "Content-Type": "application/x-www-form-urlencoded"
                    ,"Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDIxMjI3NywiZXhwIjoxNTY0MjE1ODc3LCJuYmYiOjE1NjQyMTIyNzcsImp0aSI6IjgyQXk1MDlYd1JPb0Vrb1IiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.QAIl3-xxKFQY76OAv241eVyVummgC_zuxXZNlGPtE2Q",
                    "Accept": "application/json"
                ]

            if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                              
            let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                let parameters = ["user_id": UserDic.value(forKey: "user_id") ?? -1,"amount": amount, "paymentby" : paymentType, "promo_id":"1398" ,"payment_id": txnID,"order_id": orderID,] as [String : Any]
        
                NetworkManager.post_Request(urlService: kAndroidAddfundURL, param: parameters, head: headers) { (response) in
                    self.hideActivityIndicator()
                    do {
                        if response != nil {
                            let jsonResponse = try JSON(data:response as! Data)
                            let data = jsonResponse["result"]
    //                        let message  = data["msg"].stringValue
                            self.fundData = AddFundWallet(json: data)
                            if self.fundData?.status == 1 {
                                Loader.showToast(message: self.fundData?.msg ?? "Fund Add Successfully", onView: self.view, bottomMargin: 200, color: UIColor(red: 49, green: 139, blue: 22))
                                } else {
                                Loader.showToast(message: self.fundData?.msg ?? "Unable To Add Fund", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                                }
                            }
                           
                        }
                     catch {
                        Loader.showAlert(message: "Status code 500: server internal error")
                    }
                }
            }
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

        }


    extension PauemtOptionsViewController:RazorpayPaymentCompletionProtocol {
        func onPaymentSuccess(_ payment_id: String) {
            print(payment_id)
            self.addFundRequest(txnID: payment_id, orderID: rajorWallet?.id ?? "0", paymentType: "razorpay", amount: amountLbl.text ?? "")
        }
        
        func onPaymentError(_ code: Int32, description str: String) {
            print(description)
            
        }
        func razorPayment() {
             if let here = UserDefaults.standard.value(forKey: "UserDetail") as? NSData {
                                     
                          let UserDic2 = NSKeyedUnarchiver.unarchiveObject(with: here as Data) as! NSDictionary
                          
                         if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                                            
                          let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                              if let userEmail = UserDic.value(forKey: "email") as? String {
                              self.customerEmail = userEmail
                                let value = UserDic.value(forKey:"mobile")
                                              UserDefaults.standard.set(value, forKey: kMobileNumber)
                                              self.customerPhone = "\(UserDefaults.standard.value(forKey: kMobileNumber) ?? "")"
                                  
                          } else {
                              Loader.showToast(message: "Email address not verified", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                              return
                          }
                            customerName = UserDic2.value(forKey: "username") as? String ?? ""
                                orderId = ""
                                customerID = ""
                               
                            customerID = "\(UserDic.value(forKey: "user_id") ?? "")"
                          
            let options: [String:Any] = [
                "amount": rajorWallet?.amount ?? "1", //This is in currency subunits. 100 = 100 paise= INR 1.
                "currency": "INR",//We support more that 92 international currencies.
                "description": "Add Fund",
                "order_id": rajorWallet?.id ?? "0",
                "image": "https://www.my11kings.in/dist/assets/images/logo.png",
                "name": "My11Kings",
                "prefill": [
                    "contact":customerPhone ,
                    "email": customerEmail
                ],
                "theme": [
                    "color": "#F37254"
                  ]
            ]
            razorpay.open(options, displayController: self)
        
            }
            }
    }
        func addOrderId() {
                    showActivityIndicator(sMessage: "Loading...")
                    let headers = [
                        "Content-Type": "application/json"
                        ,
                        "Accept": "application/json"
                    ]

                if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                                  
                let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                    let parameters = ["user_id": UserDic.value(forKey: "user_id") ?? -1,"amount":amtTxt] as [String : Any]
            
                    NetworkManager.post_Request2(urlService: kOrderId, param: parameters, head: headers) { (response) in
                        self.hideActivityIndicator()
                        do {
                            if response != nil {
                                let jsonResponse = try JSON(data:response as! Data)
                               
        //                        let message  = data["msg"].stringValue
                                self.rajorWallet = RazorPayResult(json: jsonResponse)
                                DispatchQueue.main.async {
                                    self.razorPayment()
                                }

                                }
                            }
                         catch {
                            Loader.showAlert(message: "Status code 500: server internal error")
                        }
                    }
                }
            }
    func convertImageToBase64String () -> String {
        let img:UIImage = #imageLiteral(resourceName: "logo 111")
        let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }
    }
