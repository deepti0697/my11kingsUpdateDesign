//
//  AvatarCollectionViewCell.swift
//  Club11
//
//  Created by Randhir Kumar on 29/05/19.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var aContentView: UIView!
    
    @IBOutlet weak var aAvatarImageView: UIImageView!
    @IBOutlet weak var aTickMarkImageView: UIImageView!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aAvatarImageView.setBorderImageView(color: .lightGray, size: 1.0)
        aAvatarImageView.layer.masksToBounds = true
        aTickMarkImageView.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setCircularImageView()
    }
    override var isSelected: Bool {
        didSet {
            
//            self.aContentView.alpha = isSelected ? 0.70 : 1.0
            self.aTickMarkImageView.isHidden = !isSelected
        }
    }
    
    func configCell(imageUrl: String) {
        let url = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let image = URL(string: url ?? "")
        self.aAvatarImageView.sd_setImage(with: image) { (_, _, _, _) in
            
        }
    }
    
    func setCircularImageView() {
        self.aAvatarImageView.layer.cornerRadius = CGFloat(roundf(Float(self.aAvatarImageView.frame.size.width / 2.0)))
    }
    
}
