//
//  ContestCategoryTableHeaderView.swift
//  FantasyCrick2Part
//
//  Created by Developer on 09/05/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ContestCategoryTableHeaderViewExample: UICollectionViewCell {
    
    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet var aTitleLabel: UILabel!
    @IBOutlet var aSubTitleLabel: UILabel!
    
    var viewAllClouser: (() -> Void) = { }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(category: Categories) {
        aTitleLabel.text = category.name
//        aTitleLabel.backgroundColor = .clear
//        aTitleLabel.textColor = .black
        aSubTitleLabel.text = category.contest_sub_text
//        if let imageUrl = category.contest_image_url {
//            let urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            let imageUrl = URL(string: urlString ?? "")
//            aImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "sample"), options: .continueInBackground) { (img, err, cacheType, url) in
//            }
//
//        }
    }
    
    @IBAction func viewAllAction(sender: UIButton) {
        viewAllClouser()
    }
}
