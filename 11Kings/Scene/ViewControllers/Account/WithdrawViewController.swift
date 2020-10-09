//
//  WithdrawViewController.swift
//  Club11
//
//  Created by Developer on 26/05/19.
//

import UIKit
import SwiftyJSON
class WithdrawViewController: BaseClass {
    
    @IBOutlet weak var accountNoImageView: UILabel!
    @IBOutlet weak var bankName: UILabel!
    
    @IBOutlet weak var paytmImageView: UIImageView!
    @IBOutlet weak var paytmButton: UIButton!
    @IBOutlet weak var bankButtom: UIButton!
    @IBOutlet weak var accountNo: UILabel!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aTotalAmountTextfield: UITextField!
    @IBOutlet weak var aWinningsCashLabel: UILabel!
     @IBOutlet weak var bankImageView: UIImageView!
    var bankArray = [BankDetailResponses]()
    var withdrawType = "Paytm"
    var winningsAmount = "0"
    var token = ""
    var withdrawRespnse:WithDrawAmountResponses?
    var totalAmount = 0 {
        didSet {
            self.aTotalAmountTextfield.text = "\(totalAmount)"
        }
    }
    
    var isPaytmSelected: Bool = true {
           didSet {
               if isPaytmSelected {
                   paytmImageView.isHidden = false
                  
                   bankImageView.isHidden = true
                   paytmImageView.backgroundColor =  UIColor(red: 255, green: 253, blue: 166)
                   //aMaleCheckBoxButton.backgroundColor = .blue
                   paytmButton.borderColor = UIColor(red: 255, green: 253, blue: 166)
                 bankButtom.borderColor =  UIColor(red: 255, green: 253, blue: 166)
                   paytmButton.borderWidth = 3
                  bankButtom.borderWidth = 3
                   bankButtom.backgroundColor = .clear
               } else {
                   paytmImageView.isHidden = true
                    bankImageView.isHidden = false
                   paytmImageView.backgroundColor = .clear
                   bankButtom.borderColor =  UIColor(red: 255, green: 253, blue: 166)
                   bankButtom.borderWidth = 3
                 paytmButton.borderWidth = 3
                   bankImageView.backgroundColor =  UIColor(red: 255, green: 253, blue: 166)
                    paytmButton.borderColor = UIColor(red: 255, green: 253, blue: 166)
                   //aFemaleCheckBoxButton.backgroundColor = .blue
                  // aMaleCheckBoxButton.backgroundColor = .white
               }
           }
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        totalAmount = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(true, animated: false)
        aTotalAmountTextfield.setLeftPaddingPoints(10.0)
        getBankDetails()
               bankImageView.layer.cornerRadius = bankImageView.frame.size.width/2
               bankImageView.clipsToBounds = true
               paytmImageView.layer.cornerRadius = paytmImageView.frame.size.width/2
               paytmImageView.clipsToBounds = true
        isPaytmSelected = true
        setupUI()
        
        aWinningsCashLabel.text = winningsAmount
        paytmButton.setCornerRadiusButton(value: 13)
           bankButtom.setCornerRadiusButton(value: 13)
              
        //   aFemaleCheckBoxButton.clipsToBounds = true
         //  aCameraButton.setCornerRadiusButton(value: 5)
           
           paytmButton.setBorderButton(color: UIColor(red: 255, green: 253, blue: 166), size: 1.0)
           bankButtom.setBorderButton(color:  UIColor(red: 255, green: 253, blue: 166), size: 2.0)
           //aAvatarImageView.setCornerRadiusImageView(value: 35)
          // aAvatarImageView.setBorderImageView(color: .lightGray,size: 1)
           paytmButton.borderWidth = 3
           paytmButton.borderWidth = 3
    }
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    @IBAction func backButtonHanlde(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        
        aContainerView.setCornerRadius(value: 10)
        if bankArray.count > 0 {
            bankName.text = bankArray[0].bankname
            accountNo.text = bankArray[0].accno
            
        }
    }
    
   
    @IBAction func withdrawAmount(_ sender: Any) {
     if aTotalAmountTextfield.text == "" {
                Loader.showToast(message: "Please enter some amount", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                return
            }
     else if withdrawType == "Bank" {
        let text = Int(aTotalAmountTextfield.text ?? "")
        if text ?? 0 < 200 {
            Loader.showToast(message: "Please enter minimum 200 balance", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                           return
        }
        else {
            let amount = aTotalAmountTextfield.text ?? "0"
                   requestWithDraw(type: withdrawType, amount: amount)
                   }
        }
     else if withdrawType == "Paytm" {
            let text = Int(aTotalAmountTextfield.text ?? "")
            if text ?? 0 < 99 {
                Loader.showToast(message: "Please enter minimum 100 balance", onView: self.view, bottomMargin: 200, color: .red)
                               return
            }
            else {
                let amount = aTotalAmountTextfield.text ?? "0"
                       requestWithDraw(type: withdrawType, amount: amount)
                       }
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

                      NetworkManager.post_Request(urlService: kBankDetailsURL, param: parameters as [String : Any], head: headers) { (response) in
                          self.hideActivityIndicator()
                          do {
                              if response != nil {
                                let json = try JSON(data : response as! Data)
                                let result = json["result"]
                                self.bankArray.removeAll()
                                for arr in result.arrayValue {
                                    self.bankArray.append(BankDetailResponses(json: arr))
                                }
                                self.setupUI()
                              }
                          } catch {
                              Loader.showAlert(message: "Status code 500: server internal error")
                          }
                      }
                  }

              }

    
    @IBAction func paytmButtonAction(_ sender: UIButton) {
        withdrawType = "Paytm"
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
        isPaytmSelected = true
    }
    
    @IBAction func bankButtonAction(_ sender: UIButton) {
        withdrawType = "Bank"
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
        isPaytmSelected = false
        
    }
    
    
    func requestWithDraw(type: String, amount: String) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NTU5MTM3MywiZXhwIjoxNTY1NTk0OTczLCJuYmYiOjE1NjU1OTEzNzMsImp0aSI6InEwNFJpdFc5dXBua080bU8iLCJzdWIiOjExOCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.eSHL2YHOeqthUpUnJ1F8Pk5kkUpH4nUHhZ_DBGOJRus",
            "Content-Type": "application/json"]
            
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                                                                       
                                          let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                   
            let parameters = ["user_id": (UserDic.value(forKey: "user_id")), "amount": amount, "payment_type": "Bank"]
            NetworkManager.post_Request2(urlService: kAmountWithDrawURl, param: parameters as [String : Any], head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let json = try JSON(data:response as! Data)
                    let jsonResult = json["result"]
                    self.withdrawRespnse = WithDrawAmountResponses(withdrawJson: jsonResult)
                    Loader.showToast(message: self.withdrawRespnse?.msg ?? "Error", onView: self.view, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                    
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    }
}
