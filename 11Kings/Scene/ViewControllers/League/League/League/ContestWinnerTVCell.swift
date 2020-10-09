//
//  ContestWinnerTVCell.swift
//  Club11
//
//  Created by Developer on 14/06/19.
//

import UIKit

class ContestWinnerTVCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var aRankLabel: UILabel!
    @IBOutlet weak var aWnningAmt: UILabel!
    
    var getPercentInput: ((Double, Int) -> Void) = { _, _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aTextField.setBorderTextField(color: .darkGray, size: 1)
        aTextField.setCornerRadiusTextField(value: 3)
    }

    func configureCell(index: Int, amount: Double, percent: Double, isLastIndex: Bool) {
        aRankLabel.text = "#\(index + 1)"
        aWnningAmt.text = kRupeeIcon + String(format: "%.2f", amount)
        aTextField.text = String(format: "%.2f", percent)
        if isLastIndex {
            aTextField.isEnabled = false
        } else {
            aTextField.isEnabled = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let updatedText = aTextField.text {
            if let doubelUpdatedText = Double(updatedText) {
                if doubelUpdatedText > 100.0 {
                    self.endEditing(true)
                    Loader.showToast(message: "Percentage should be within 100.0", onView: self, bottomMargin: 200)
                } else {
                    getPercentInput(doubelUpdatedText, self.tag)
                }
            }
        } else {
            self.endEditing(true)
            Loader.showToast(message: "Enter Winner percentage", onView: self, bottomMargin: 200)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
}
