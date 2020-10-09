//
//  BaseClass.swift
//  DreamTeam
//
//  Created by Test on 08/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import SystemConfiguration
import Alamofire
import SwiftToast
class BaseClass:UIViewController {
    
    var container: UIView = UIView()
       var loadingView: UIView = UIView()
       var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
       var meassagelabel:UILabel = UILabel()
     var customNavigationView: NavigationBarView?
    func bottomline(btn:UIButton,color:UIColor,height:CGFloat) {
    let space:CGFloat = 0.5

    btn.setNeedsLayout()
    btn.layoutIfNeeded()

    let border = CALayer()
        border.backgroundColor = color.cgColor
    border.frame = CGRect(x: 0, y: (btn.titleLabel?.frame.size.height)! + space, width: (btn.titleLabel?.frame.size.width)!, height: height)
    btn.titleLabel?.layer.addSublayer(border)
        }
    
    func showHUD(progressLabel:String){
        DispatchQueue.main.async{
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = progressLabel
        }
    }

    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
    func showToast(mesage:String){
        let test =  SwiftToast(
                            text: mesage,
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
        present(test, animated: true)
    }
func hidenavigationBackButton(){
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    class func showAlert(alertTitle : String, alertMsg : String, view: UIViewController) {
           
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
           
           let actionOK : UIAlertAction = UIAlertAction(title: "OK", style: .default) { (alt) in
               print("This is ok action");
           }
           alert.addAction(actionOK)
           
           view.present(alert, animated: true, completion: nil)
           
       }
       override func viewWillDisappear(_ animated: Bool) {
             super.viewWillDisappear(animated)
             customNavigationView?.removeFromSuperview()
             customNavigationView = nil
    //self.tabBarController?.tabBar.isHidden = true
    }
       class func showAlertOKAction(_ alertTitle : String, _ alertMsg : String, _ okTitle : String, _ view: UIViewController, successClosure: @escaping (String?) -> () ) {
           
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
           
           let actionOK : UIAlertAction = UIAlertAction(title: okTitle, style: .default) { (alt) in
               print("This is ok action");
               successClosure("OK")
           }
           alert.addAction(actionOK)
           
           view.present(alert, animated: true, completion: nil)
           
       }
       
       class func showAlertOKCancelAction(_ alertTitle : String, _ alertMsg : String, _ view: UIViewController, successClosure: @escaping (String?) -> (), cancelClosure: @escaping (String?) -> () ) {
           
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
           
           let actionOK : UIAlertAction = UIAlertAction(title: "OK", style: .default) { (alt) in
               successClosure("OK")
           }
           let actionCancel : UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { (alt) in
               cancelClosure("Cancel")
           }
           alert.addAction(actionOK)
           alert.addAction(actionCancel)
           
           view.present(alert, animated: true, completion: nil)
       }
    func ShowimportantAlert(title: String, message: String, handlerOK:((UIAlertAction) -> Void)?, handlerCancle: ((UIAlertAction) -> Void)?) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .destructive, handler: handlerOK)
           let actionCanel = UIAlertAction(title: "Cancle", style: .cancel, handler: handlerCancle)
           alert.addAction(action)
           alert.addAction(actionCanel)
           DispatchQueue.main.async {
               self.present(alert, animated: true, completion: nil)
           }
       }
    func addNavigationBar(navigationTitle: String, titleContentMode: UIView.ContentMode, isNavImageShow: Bool, isBackButtonShow: Bool, isWalletButtonShow: Bool,isBinButtonShow:Bool) {
            if customNavigationView != nil{
                customNavigationView?.removeFromSuperview()
            }
            setupDefaultNavigationBar()
            customNavigationView = Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)?.first as? NavigationBarView
        
            customNavigationView?.baseControllerObj = self
            customNavigationView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
            navigationController?.navigationBar.addSubview(customNavigationView!)
            customNavigationView?.setNavigtionTitle(title: navigationTitle, contentMode: titleContentMode)
            customNavigationView?.showNaviGationTitle(show: isNavImageShow)
          navigationController?.navigationBar.isTranslucent = true
            customNavigationView?.showNaviGationBackButton(show: !isBackButtonShow)
            customNavigationView?.showNaviGationNotificationButton(show: !isWalletButtonShow)
          customNavigationView?.showNaviGationNotificationBinButton(show: !isBinButtonShow)
        }
    func addNavigationBarwithBinButton(navigationTitle: String, titleContentMode: UIView.ContentMode, isNavImageShow: Bool, isBackButtonShow: Bool, isWalletButtonShow: Bool,isBinButtonShow:Bool) {
        if customNavigationView != nil{
            customNavigationView?.removeFromSuperview()
        }
        setupDefaultNavigationBar()
        customNavigationView = Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)?.first as? NavigationBarView
    
        customNavigationView?.baseControllerObj = self
        customNavigationView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        navigationController?.navigationBar.addSubview(customNavigationView!)
        navigationController?.navigationBar.isTranslucent = true
    
        customNavigationView?.setNavigtionTitle(title: navigationTitle, contentMode: titleContentMode)
        customNavigationView?.showNaviGationTitle(show: isNavImageShow)
        customNavigationView?.showNaviGationBackButton(show: !isBackButtonShow)
        customNavigationView?.showNaviGationNotificationButton(show: !isWalletButtonShow)
      
    }
//
        func setupDefaultNavigationBar () {
           
            self.navigationController?.isNavigationBarHidden = false
            tabBarController?.navigationItem.hidesBackButton = true
            navigationItem.setHidesBackButton(true, animated: false)
            navigationController?.navigationItem.hidesBackButton = true
            navigationController?.navigationBar.barTintColor = UIColor(red: 20, green: 20, blue: 20)
            
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
        }
        
        func handleBackButtonAction() -> Void {
            // Don't implement any logic here overrride this function in your class
        }
        
        func handleWalletButtonAction() -> Void {
//            openViewController(controller: HomeViewController.self, storyBoard: .accountStoryBoard) { (vc) in
//
//            }
        }
        func handleBinButtonAction() -> Void {
//                    openViewController(controller: HomeViewController.self, storyBoard: .accountStoryBoard) { (vc) in
        //
        //            }
                }
        func changeNavigationTitleForTimer(timeStr: String) {
            customNavigationView?.setNavigtionTitle(title: timeStr, contentMode: .center)
        }
        
        // MARK:- Activity indicator
        
        func showActivityIndicator(sMessage:String) {
            DispatchQueue.main.async {
                self.container.frame = self.view.frame
                self.container.center = self.view.center
                self.container.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.3)
                self.container.isHidden = false
                self.loadingView.frame = CGRect(x: (self.view.frame.size.width-150)/2, y: (self.view.frame.size.height-150)/2-50, width: 150, height: 150)
                print(self.loadingView.center)
                self.loadingView.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.8)
                self.loadingView.clipsToBounds = true
                self.loadingView.layer.cornerRadius = 10
                
                self.activityIndicator.frame = CGRect(x: 0.0,y:  10.0,width : 40.0, height : 40.0);
                self.activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
                self.activityIndicator.center = CGPoint(x: self.loadingView.frame.size.width / 2, y: self.loadingView.frame.size.height / 2)
                
                self.meassagelabel.frame = CGRect(x: 0.0,y : 100.0,width : 150.0,height : 45.0)
                self.meassagelabel.text = sMessage
                self.meassagelabel.textAlignment = .center
                self.meassagelabel.textColor = UIColor.white
                self.meassagelabel.backgroundColor = UIColor.clear
                self.loadingView.addSubview(self.meassagelabel)
                self.loadingView.addSubview(self.activityIndicator)
                self.container.addSubview(self.loadingView)
                APP_DEL.window?.addSubview(self.container)
                self.activityIndicator.startAnimating()
                print(self.loadingView.frame)
            }
        }
        
        func hideActivityIndicator() {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.container.isHidden = true
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
}
