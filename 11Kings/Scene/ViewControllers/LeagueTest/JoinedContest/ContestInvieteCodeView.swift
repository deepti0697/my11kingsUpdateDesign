//
//  ContestInvieteCodeView.swift
//  Club11
//
//  Created by Developer on 29/05/19.
//

import UIKit

class ContestInvieteCodeView: UIView {

    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var aJoinButton: UIButton!
    
    var closeButtonClouser: (() -> Void) = { }
    var joinContestButtonClouser: ((String) -> Void) = { _ in }
    var containerYposition: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aJoinButton.setCornerRadius(value: 5)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func joinContestButtonAction(_ sender: UIButton) {
        if aTextField.text != "" {
            joinContestButtonClouser(aTextField.text ?? "")
        } else {
            Loader.showToast(message: "Enter Contest Code", onView: self, bottomMargin: 200, color: UIColor.black.withAlphaComponent(0.6)
)
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        closeButtonClouser()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        containerYposition = aContainerView.frame.origin.y
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            aContainerView.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        aContainerView.frame.origin.y = containerYposition
    }
}
