//
//  PopOverTableViewCell.swift
//  TeamBanao
//
//  Created by Developer on 27/02/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class PopOverTableViewCell: UITableViewCell {

    @IBOutlet private var aStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(state: String) {
        aStateLabel.text = state
    }
}
