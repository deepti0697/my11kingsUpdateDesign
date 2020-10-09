//
//  FCVerifyMobileTableViewCell.swift
//  FantasyCricket
//
//  Created by Developer on 20/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class FCVerifyMobileTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var aSendButton: UIButton!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aMobileNumberLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var aMobileNumberTextField: UITextField!
    
    var verifyMobileActionClousure: ((_ mobileNo: String,_ type: String) -> Void) = { _,_ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aContainerView.setCornerRadius(value: 5)
        aMobileNumberTextField.delegate = self
        //aSendButton.setCornerRadiusButton(value: 5)
        if let heroObject = UserDefaults.standard.value(forKey: "UserDetail") as? NSData {
                                                                                      
                                                         let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
            aMobileNumberTextField.text = UserDic.value(forKey: "mobile") as? String
    }
    }
    @IBAction func sendButtonAction(_ sender: Any) {
         let validmobile = validateMobileFields()
        if let mobileNumber = aMobileNumberTextField.text, mobileNumber != "" {
           if validmobile != "" {
             Loader.showToast(message: "Please enter Correct Mobile Number", onView: self, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
                 
            }
            else {
            verifyMobileActionClousure(mobileNumber,"mobile")
                
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == aMobileNumberTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    private func validateMobileFields() -> String {
           var message = ""
           if let text = aMobileNumberTextField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty && Validation.isValid(mobileNo: text) {
               message = ""
           } else {
               message = "Please Enter Correct Mobile No."
               return message
           }
           return message
       }
}
