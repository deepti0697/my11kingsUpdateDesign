//
//  VerifiedTableViewCell.swift
//  FantasyCricket
//
//  Created by Developer on 20/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class VerifiedTableViewCell: UITableViewCell {
    
    var ispandUnderReview = false
    var isbankUnderreivew = false
    @IBOutlet weak var aTitleLabel: UILabel!
    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet weak var aValueLabel: UILabel!
    @IBOutlet weak var aContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aContainerView.setCornerRadius(value: 5)
//        aContainerView.setBorder(color: UIColor(red: 72 / 255, green: 197 / 255, blue: 82 / 255, alpha: 1.0), size: 1)
        
    }
    
    func configureCell(cellType: AccountCellType, isEmail: Bool) {
        if let heroObject = UserDefaults.standard.value(forKey: "UserDetail") as? NSData {
                                                                                 
                                                    let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
        switch cellType {
        case .mobileCellType:
            if isEmail {
                aTitleLabel.text = "Email Id"
               
                    aValueLabel.text = UserDic.value(forKey: "email") as? String
                aImageView.image = UIImage(named: "ic_email_verified")
                }
             else {
                aTitleLabel.text = "Mobile Number"
                aValueLabel.text = "\(UserDic.value(forKey: "mobile") ?? 0000000000)"
                aImageView.image = UIImage(named: "ic_email_verified")
            }
        case .pancardCellType:
            if ispandUnderReview {
                aTitleLabel.text = "PAN Card"
                aValueLabel.text = "Under Review"
                aImageView.image = UIImage(named: "ic_email_verified")
            }
            else {
            aTitleLabel.text = "PAN Card"
            aValueLabel.text = UserDefaults.standard.object(forKey: kPanCardNo) as? String
            aImageView.image = UIImage(named: "ic_email_verified")
            }
        case .bankCellType:
            if isbankUnderreivew {
                aTitleLabel.text = "Acc No."
                           aValueLabel.text = "Under Review"
                           aImageView.image = UIImage(named: "ic_email_verified")
            }
            else {
                aTitleLabel.text = "Acc No."
                           aValueLabel.text = UserDefaults.standard.object(forKey: kBankAccountNo) as? String
                           aImageView.image = UIImage(named: "ic_email_verified")
            }
           
        }
    }
    }
}
