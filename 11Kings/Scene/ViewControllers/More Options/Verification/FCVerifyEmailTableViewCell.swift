//
//  FCVerifyEmailTableViewCell.swift
//  FantasyCricket
//
//  Created by Developer on 20/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class FCVerifyEmailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var aSendButton: UIButton!
    @IBOutlet weak var aEmailLabel: UILabel!
    @IBOutlet weak var aEmailTextField: UITextField!
    @IBOutlet weak var aContainerView: UIView!
    
    var verifyEmailActionClousure: ((_ email: String,_ type: String) -> Void) = { _,_ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aContainerView.setCornerRadius(value: 5)
        aSendButton.setCornerRadiusButton(value: 5)
        aEmailTextField.text = UserDefaults.standard.object(forKey: kEmailId) as? String
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
        if let email = aEmailTextField.text {
            verifyEmailActionClousure(email,"email")
        }
    }
}
