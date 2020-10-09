//
//  FCPanCardTableViewCell.swift
//  FantasyCricket
//
//  Created by Developer on 20/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class FCPanCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var aImageButton: UIButton!
    @IBOutlet weak var aImageUploadLabel: UILabel!
    @IBOutlet weak var aSubmitButton: UIButton!
    @IBOutlet weak var aPanNameTextField: UITextField!
    @IBOutlet weak var aPanNameLabel: UILabel!
    @IBOutlet weak var aPanNumberTextField: UITextField!
    @IBOutlet weak var aPanNumberLabel: UILabel!
    @IBOutlet weak var aPanDobTextField: UITextField!
    @IBOutlet weak var aPanDobLabel: UILabel!
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aImageView: UIImageView!
    
    var uploadImageClouser: ((AccountCellType) -> Void) = { _ in }
    var submitButtonActionClousure: ((_ panName: String,_ panNumber: String,_ dob: String) -> Void) = { _,_,_ in }
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aSubmitButton.setCornerRadiusButton(value: 5)
        aContainerView.setCornerRadius(value: 5)
        aImageButton.setDashedBorderButton(color: .lightGray)
        aImageButton.setCornerRadiusButton(value: 3)
         aPanNameTextField.setLeftPaddingPoints(10.0)
        aPanNumberTextField.setLeftPaddingPoints(10.0)
        aPanDobTextField.setLeftPaddingPoints(10.0)
aPanDobTextField.addTarget(self, action: #selector(textFieldDidChangeAccountNumber(_:)), for: .editingChanged)
         aPanNameTextField.addTarget(self, action: #selector(textFieldDidChangeBank(_:)), for: .editingChanged)
         aPanNumberTextField.addTarget(self, action: #selector(textFieldDidChangeIFSC(_:)), for: .editingChanged)
   aPanNameTextField.text =  APP_DEL.panName
         aPanNumberTextField.text = APP_DEL.panNumber
          aPanDobTextField.text  =  APP_DEL.panDob
    }
    
    func imageUploadMsg(isUpload: Bool) {
//        if isUpload {
//            aImageButton.setTitle("Your pan card image upload successfully", for: .normal)
//            aImageUploadLabel.textColor = .green
//        } else {
//            aImageUploadLabel.text = "Upload PAN Card Image"
//            aImageUploadLabel.textColor = .lightGray
//        }
    }
    @objc func textFieldDidChangeBank(_ textField: UITextField) {
     
              APP_DEL.panName = aPanNameTextField.text ?? ""
      
          }
     @objc func textFieldDidChangeIFSC(_ textField: UITextField) {
        
                 APP_DEL.panNumber = aPanNumberTextField.text ?? ""
         
             }
     @objc func textFieldDidChangeAccountNumber(_ textField: UITextField) {
    
             APP_DEL.panDob = aPanDobTextField.text ?? ""
     
         }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if let panName = aPanNameTextField.text, panName != "", let panNo = aPanNumberTextField.text, panNo != "", let dob = aPanDobTextField.text, dob != "" {
            if validatePANCardNumber(aPanNumberTextField.text ?? "") {
            if aPanNumberTextField.text != aPanDobTextField.text {
                 Loader.showToast(message: "Pan Number not Matched", onView: self, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
            }
            else {
            submitButtonActionClousure(panName,panNo,dob)
            }
        }
            else {
                self.makeToast(message: "Please Enter valid Pan No", duration: 2.0, position:HRToastPositionCenter as AnyObject)
                // self.makeToast(message:"Enter valid Pan No")
//                Loader.showToast(message: "Enter valid Pan No", onView: self, bottomMargin: 200, color: .red)
            }
        } else {
            Loader.showToast(message: "Please enter all mentadtory fields", onView: self, bottomMargin: 200, color: UIColor(red: 240, green: 75, blue: 80))
        }
        
    }
    
    @IBAction func cameraButtonAction(_ sender: Any) {
        uploadImageClouser(.pancardCellType)
    }
    

   func validatePANCardNumber(_ strPANNumber : String) -> Bool{
       let regularExpression = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
       let panCardValidation = NSPredicate(format : "SELF MATCHES %@", regularExpression)
       return panCardValidation.evaluate(with: strPANNumber)
   }
    
}
