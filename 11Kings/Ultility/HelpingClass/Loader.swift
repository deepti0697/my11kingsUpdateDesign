//
//  Loader.swift
//  Club11
//
//  Created by Developer on 17/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit
import SwiftToast
class Loader: NSObject {
    
    var loadView:RuleView?

    // MARK:- Show Alert
    class func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            //APP_DEL.window?.rootViewController!.present(alert, animated: true, completion: nil)
        }
        
    }
    func showNavToast () {
    let test =  SwiftToast(
                        text: "This is a customized SwiftToast with image",
                        textAlignment: .left,
                        image: UIImage(named: "ic_alert"),
                        backgroundColor: .purple,
                        textColor: .white,
                        font: .boldSystemFont(ofSize: 15.0),
                        duration: 2.0,
                        minimumHeight: CGFloat(100.0),
                        statusBarStyle: .lightContent,
                        aboveStatusBar: true,
                        target: nil,
                        style: .navigationBar)
       // self.view.window.present(test, animated: true, completion: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    // MARK:- Show Toast
    class func showCreateTeamToast(message: String, onView: UIView, bottomMargin: CGFloat) {
        onView.endEditing(true)
               DispatchQueue.main.async {
                   APP_DEL.window?.viewWithTag(9999)?.removeFromSuperview()
               
                let toastLabel = UILabel(frame: CGRect(x: 0, y: -60, width: onView.frame.size.width, height: 60))
               
                   toastLabel.tag = 9999
                    toastLabel.backgroundColor = UIColor(red: 240, green: 75, blue: 80)
                   toastLabel.textColor = UIColor.white
                   toastLabel.textAlignment = .center;
                   toastLabel.font = UIFont.systemFont(ofSize: 15)
                   toastLabel.text = message
                   
                   toastLabel.layer.cornerRadius = 10;
                   toastLabel.numberOfLines = 0
                   toastLabel.clipsToBounds = true
                 
                UIView.animate(withDuration: 1) {
                                    toastLabel.alpha = 1.0
                                   toastLabel.frame.origin.y = 60
                      APP_DEL.window?.addSubview(toastLabel)
                               }
                   perform(#selector(Loader.removeToast(label:)), with: toastLabel, afterDelay: 1.5)
               }
    }
    class func showToast(message: String, onView: UIView, bottomMargin: CGFloat , color:UIColor) {
        onView.endEditing(true)
        DispatchQueue.main.async {
            
            APP_DEL.window?.viewWithTag(9999)?.removeFromSuperview()
             APP_DEL.window?.viewWithTag(9999)?.removeFromSuperview()
            let uiviw = UIView(frame: CGRect(x:0, y: -80, width: onView.frame.size.width, height: 80))
            
            uiviw.tag = 9999
            uiviw.backgroundColor = .clear
            uiviw.alpha = 1.0
            
            uiviw.clipsToBounds = true
            let backimage = UIImageView(frame: CGRect(x:0, y: -80, width: onView.frame.size.width, height: 80))
            //            image.image = #imageLiteral(resourceName: "Path 25162")
                        
            backimage.image =  UIImage(named: "Path 25162")
//                        backimage.contentMode = .scaleToFill
                        backimage.alpha = 1.0
            var imageModel = UIImageView()
            imageModel = UIImageView(frame: CGRect(x:10, y:30, width:30, height: 25))
            let toastLabel = UILabel(frame: CGRect(x:imageModel.frame.origin.x + 50, y:0, width: onView.frame.size.width - 70, height: 90))
//            toastLabel.tag = 9999
            toastLabel.backgroundColor = .clear
            
            toastLabel.textColor = UIColor(red: 172, green: 135, blue: 54)
            toastLabel.textAlignment = .left;
            toastLabel.font = UIFont.boldSystemFont(ofSize: 15)
            toastLabel.text = message
            toastLabel.alpha = 1.0
          
            toastLabel.numberOfLines = 0
            toastLabel.clipsToBounds = true
            
            imageModel.backgroundColor = .clear
                imageModel.alpha = 0
//            UIView.animate(withDuration: 2) {
//                imageModel.alpha = 1.0
//                uiviw.addSubview(imageModel)
//            }
            UIView.animate(withDuration:1,
                           delay: 0.1,
                           usingSpringWithDamping: 0.1,
                           initialSpringVelocity: 0.1,
                           options: .curveEaseInOut,
            animations: {
                   //Do all animations here
                   }, completion: {
                   //Code to run after animating
                       (value: Bool) in
                    imageModel.alpha = 1.0
                                   uiviw.addSubview(imageModel)
                    
               })
                imageModel.image = UIImage(named: "close Toast")
            imageModel.tintColor = .white
                           imageModel.clipsToBounds = true
            UIView.animate(withDuration: 0.5) {
               
                  

                                             uiviw.alpha = 1.0
                                            uiviw.frame.origin.y = 0
                
                               APP_DEL.window?.addSubview(uiviw)
                  backimage.frame.origin.y = 0
                  uiviw.addSubview(backimage)
                 uiviw.addSubview(toastLabel)
              
//                APP_DEL.window?.addSubview(imageView)
                                          
}
            perform(#selector(Loader.removeToast(label:)), with: uiviw, afterDelay: 1.5)
//              perform(#selector(Loader.removeToastImage(image:)), with: imageView, afterDelay: 1.5)
        }
    }
    
    @objc class func removeToast(label:UIImageView) -> Void {
        label.removeFromSuperview()
    }
    @objc class func removeToastImage(image:UIImageView) -> Void {
           image.removeFromSuperview()
       }
    
}
extension UIView {

  var safeTopAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.topAnchor
    }
    return self.topAnchor
  }

  var safeLeftAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.leftAnchor
    }
    return self.leftAnchor
  }

  var safeRightAnchor: NSLayoutXAxisAnchor {
    if #available(iOS 11.0, *){
      return self.safeAreaLayoutGuide.rightAnchor
    }
    return self.rightAnchor
  }

  var safeBottomAnchor: NSLayoutYAxisAnchor {
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.bottomAnchor
    }
    return self.bottomAnchor
  }
}
