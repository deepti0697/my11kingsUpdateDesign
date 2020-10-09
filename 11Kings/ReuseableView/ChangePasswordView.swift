//
//  ChangePasswordView.swift
//  Club11
//
//  Created by Developer on 13/06/19.
//

import UIKit

class ChangePasswordView: UIView {

    @IBOutlet weak var aNewPasswordLabel: UILabel!
    @IBOutlet weak var aConfirmPasswordLabel: UILabel!
    @IBOutlet weak var aNewPasswordextField: UITextField!
    @IBOutlet weak var aConfirmPasswordTextField: UITextField!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aCloseButtonAction: UIButton!
    @IBOutlet weak var aChangePassword: UIButton!
    
    var closeButtonClouser: (() -> Void) = { }
    var changePasswordButtonClouser: ((_ password: String) -> Void) = { _ in }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    fileprivate func setupUI() {
        aNewPasswordLabel.isHidden = true
        aConfirmPasswordLabel.isHidden = true
//        aNewPasswordextField.delegate = self
//        aConfirmPasswordTextField.delegate = self
        aChangePassword.setCornerRadiusButton(value: 5)
        aContainerView.setCornerRadius(value: 5)
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        closeButtonClouser()
    }
    @IBAction func changePasswordButtonAction(_ sender: Any) {
//        if let newPass = aNewPasswordextField.text, let confirmPass = aConfirmPasswordTextField.text, newPass != "", confirmPass != "" {
//            if newPass == confirmPass {
//                if newPass.count >= 4 {
//                    changePasswordButtonClouser(newPass)
//                } else {
//                    Loader.showToast(message: "Password should be 4 to 8 char long", onView: self, bottomMargin: 200)
//                }
//            } else {
//                Loader.showToast(message: "Your Password and confirm password not matche", onView: self, bottomMargin: 200)
//            }
//        } else {
//            Loader.showToast(message: "Please enter your password", onView: self, bottomMargin: 200)
//        }
    }
}
extension ChangePasswordView: UITextFieldDelegate {
    
    func setupUIForTextfield(resultString: String = "") {
        if aNewPasswordextField.text != "" || resultString != "" {
            aNewPasswordLabel.isHidden = false
        } else {
            aNewPasswordLabel.isHidden = true
        }
        if aConfirmPasswordTextField.text != "" || resultString != "" {
            aConfirmPasswordLabel.isHidden = false
        } else {
            aConfirmPasswordLabel.isHidden = true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case aNewPasswordextField:
            aNewPasswordLabel.isHidden = false
        case aConfirmPasswordTextField:
            aConfirmPasswordLabel.isHidden = false
        default:
            break
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case aNewPasswordextField:
            aNewPasswordLabel.isHidden = true
            setupUIForTextfield()
        case aConfirmPasswordTextField:
            aConfirmPasswordLabel.isHidden = true
            setupUIForTextfield()
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setupUIForTextfield()
        if aNewPasswordextField.isFirstResponder {
            aNewPasswordextField.resignFirstResponder()
            aConfirmPasswordTextField.becomeFirstResponder()
        } else if aConfirmPasswordTextField.isFirstResponder {
            endEditing(true)
        }
        return true
    }
}
