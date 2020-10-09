//
//  ReferListTVCell.swift
//  Club11
//
//  Created by Developer on 29/05/19.
//

import UIKit

class ReferListTVCell: UITableViewCell {

    @IBOutlet weak var aNameLabel: UILabel!
    @IBOutlet weak var aDateLabel: UILabel!
    @IBOutlet weak var AMoneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    func configureCell(data: ReferListResponse) {
        aNameLabel.text = data.email
//        aDateLabel.text = data.date
      
        AMoneyLabel.text = "\(kRupeeIcon) \(data.amount ?? 0)"
        
    }
    
}
