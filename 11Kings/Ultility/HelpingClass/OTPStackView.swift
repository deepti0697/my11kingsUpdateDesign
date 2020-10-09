//
//  OTPStackView.swift
//  OTPField
//
//  Created by Satyenkumar Mourya on 23/06/19.
//  Copyright © 2019 Satyenkumar Mourya. All rights reserved.
//

import Foundation
import UIKit

protocol OTPDelegate: class {
    //always triggers when the OTP field is valid
    func didChangeValidity(isValid: Bool)
    func getOtpText(text:String)
}


class OTPStackView: UIStackView {
    
    //Customise the OTPField here
    let numberOfFields = 6
    var textFieldsCollection: [OTPTextField] = []
    weak var delegate: OTPDelegate?
    var showsWarningColor = false
    
    //Colors
    let inactiveFieldBorderColor = UIColor(red: 255, green: 195, blue: 145)
    let textBackgroundColor = UIColor(red: 255, green: 195, blue: 145)
    let activeFieldBorderColor = UIColor(red: 255, green: 195, blue: 145)
    var remainingStrStack: [String] = []
      var allOTP = ""
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        addOTPFields()
    }
    
    //Customisation and setting stackView
    private final func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 5
    }
    
    //Adding each OTPfield to stack view
    private final func addOTPFields() {
        for index in 0..<numberOfFields{
            let field = OTPTextField()
            setupTextField(field)
            textFieldsCollection.append(field)
            //Adding a marker to previous field
            index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
            //Adding a marker to next field for the field at index-1
            index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
        }
        textFieldsCollection[0].becomeFirstResponder()
    }
    
    //Customisation and setting OTPTextFields
    private final func setupTextField(_ textField: OTPTextField){
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(textField)
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        textField.backgroundColor = UIColor(red: 255, green: 195, blue: 145)
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = UIFont(name: "Roboto", size: 30)
        textField.textColor = .black
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0
//        textField.layer.borderColor = UIColor.FlatColor.Black.balckcolor.cgColor
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .yes
        textField.textContentType = .oneTimeCode
    }
    
    //checks if all the OTPfields are filled
    private final func checkForValidity(){
        for fields in textFieldsCollection{
            if (fields.text == ""){
                   
                delegate?.didChangeValidity(isValid: false)
                return
            }
        }
        getOTP()
           delegate?.getOtpText(text: allOTP)
        delegate?.didChangeValidity(isValid: true)
    }
    
    //gives the OTP text
    final func getOTP() -> String {
      var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
            
        }
     allOTP = OTP
        return OTP
    }

    //set isWarningColor true for using it as a warning color
    final func setAllFieldColor(isWarningColor: Bool = false, color: UIColor){
        for textField in textFieldsCollection{
            textField.layer.borderColor = color.cgColor
        }
        showsWarningColor = isWarningColor
    }
    
    //autofill textfield starting from first
    private final func autoFillTextField(with string: String) {
        remainingStrStack = string.reversed().compactMap{String($0)}
        for textField in textFieldsCollection {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        checkForValidity()
        remainingStrStack = []
    }
    
}

//MARK: - TextField Handling
extension OTPStackView: UITextFieldDelegate {
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if showsWarningColor {
            setAllFieldColor(color: .black)
            showsWarningColor = false
        }
//        textField.layer.borderColor = UIColor.FlatColor.Black.balckcolor.cgColor
        textField.backgroundColor  = UIColor(red: 255, green: 195, blue: 145)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkForValidity()
//        textField.layer.borderColor = UIColor.FlatColor.Black.balckcolor.cgColor
        textField.backgroundColor  = UIColor(red: 255, green: 195, blue: 145)
    }
    
    //switches between OTPTextfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        if string.count > 1 {
            textField.resignFirstResponder()
            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0){
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                }else{
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
    
}