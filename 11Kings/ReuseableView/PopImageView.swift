//
//  ChangePasswordView.swift
//  Club11
//
//  Created by Developer on 13/06/19.
//

import UIKit

class PopImageView: UIView {

    @IBOutlet weak var popImageView: UIImageView!
    
    @IBOutlet weak var aContainerView: UIView!
    var imageStrng:String? {
        didSet {
          setup()
        }
    }
    func setup() {
           if let imageStr = imageStrng{
                      print(imageStr)
                     
                      let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                      let imageUrl = URL(string: urlString ?? "")
                      popImageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 9087"), options: .continueInBackground) { (img, err, cacheType, url) in
                      }
                  }
       }
    var closeButtonClouser: (() -> Void) = { }
   

    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        closeButtonClouser()
    }
    

}
