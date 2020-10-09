//
//  FCVerifyStaticMessageTVCell.swift
//  FantasyCricket
//
//  Created by Developer on 20/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class FCVerifyStaticMessageTVCell: UITableViewCell {
    
    @IBOutlet weak var aContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aContainerView.setCornerRadius(value: 5)
    }
    
}
