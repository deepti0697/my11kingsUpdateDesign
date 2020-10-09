//
//  PopupImageViewController.swift
//  11Kings
//
//  Created by uu on 16/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class PopupImageViewController: UIViewController {

    @IBOutlet weak var popUpImage: UIImageView!
    var imageString:String?  {
        didSet {
            setup()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    func setup() {
        if let imageStr = imageString{
                   print(imageStr)
                  
                   let urlString = imageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                   let imageUrl = URL(string: urlString ?? "")
                   popUpImage?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Group 9087"), options: .continueInBackground) { (img, err, cacheType, url) in
                   }
               }
    }
    @IBAction func dismissImage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        
        
        
    
    }
    
    

}
