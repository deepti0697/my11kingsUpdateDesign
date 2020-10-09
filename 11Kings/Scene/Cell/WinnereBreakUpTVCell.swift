//
//  WinnereBreakUpTVCell.swift
//  Club11
//
//  Created by Developer on 29/05/19.
//

import UIKit

class WinnereBreakUpTVCell: UITableViewCell {

    @IBOutlet weak var aRankLabel: UILabel!
    @IBOutlet weak var aPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureCell(data: Any) {
        if let winArr = data as? WinnerbreakUpResponse {
            aPriceLabel.text = kRupeeIcon + "\(winArr.price ?? 0)"
            aRankLabel.text = "Rank \(winArr.start_position ?? "")"
        }
    }

}
