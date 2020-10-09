//
//  Validation.swift
//  Club11
//
//  Created by Developer on 17/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class Validation: NSObject {
    class func isEmpty(textField: UITextField) -> Bool {
        if (textField.text?.isEmpty)! {
            return false
        } else {
            let textString = textField.text
            let trimedString = textString!.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimedString.count > 0 {
                return true
            } else {
                return false
            }
        }
    }
    
    class func isValid(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return emailTest.evaluate(with: email)
    }
    
    class func isValid(mobileNo: String) -> Bool {
        let regex = "^[2-9][0-9]{9}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return test.evaluate(with: mobileNo)
    }
    
    class func isValid(pinCode:String)->Bool{
        let postalcodeRegex = "^[0-9]{6}"
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", postalcodeRegex)
        let bool = pinPredicate.evaluate(with: pinCode) as Bool
        return bool
    }
    
    class func isValid(password:String) -> Bool{
        if password.count >= 6 {
            return true
        } else {
            return false
        }
    }
    
    class func isValid(name: String) -> Bool {
        let regex = "^[a-zA-Z ]{1,2000}$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return nameTest.evaluate(with: name)
    }
    
}
