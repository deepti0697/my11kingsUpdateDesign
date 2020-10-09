//
//  BannerCVCell.swift
//  TeamBanao
//
//  Created by Developer on 16/02/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit
import SDWebImage

class BannerCVCell: UICollectionViewCell {

    @IBOutlet weak var aBannerImageView: UIImageView!
    @IBOutlet weak var aContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        aContainerView.setCornerRadius(value: 5)
    }
    
    func configureCell(sliderData: BannerResponses) {
        if let imageStr = sliderData.image{
            print(imageStr)
           
            let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imageUrl = URL(string: urlString ?? "")
            aBannerImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Mask Group 1"), options: .continueInBackground) { (img, err, cacheType, url) in
            }
        }
       
    }
}
