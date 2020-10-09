//
//  ContactUsViewController.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import UIKit
import MessageUI
import ChatSDK
import MessagingSDK
import CommonUISDK // import the necessary component

class ContactUsViewController: BaseClass, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var aEmailButton: UIButton!
    @IBOutlet weak var aEmailContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.isNavigationBarHidden = false
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUI() {
        aEmailContainerView.setCornerRadius(value: 5)
    }
    
   
    @IBAction func chatAction(_ sender: Any) {
       startChat()
        
    }
    func startChat() {
        do {
                   let messagingConfiguration = MessagingConfiguration()
//                              messagingConfiguration.name = "My11Kings"
                   let chatConfiguration = ChatConfiguration()
                   chatConfiguration.isAgentAvailabilityEnabled = true
  navigationController?.navigationBar.barTintColor = UIColor(red: 185, green: 33, blue: 36)
            navigationController?.navigationBar.tintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            CommonTheme.currentTheme.primaryColor = UIColor(red: 185, green: 33, blue: 36)
            
//            CommonTheme.currentTheme.ba
            chatConfiguration.isPreChatFormEnabled = false

                        let chatEngine = try ChatEngine.engine()
                        let viewController = try Messaging.instance.buildUI(engines: [chatEngine], configs:   [messagingConfiguration, chatConfiguration])
                 
                        self.navigationController?.pushViewController(viewController, animated: true)
                      } catch {
                        // handle error
                      }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    fileprivate func openContactWebVC(url: String, navTitle: String) {
            openViewController(controller: ContactusWebVC.self, storyBoard: .moreStoryBoard) { (vc) in
                vc.navTitle = navTitle
                vc.webUrlToOpen = url
            }
        }
        
        @IBAction func facebookButtonAction(_ sender: Any) {
            openContactWebVC(url: kFacebookURL, navTitle: "Facebook")
        }
        
        @IBAction func twitterButtonAction(_ sender: Any) {
            openContactWebVC(url: kTwitterURL, navTitle: "Twitter")
        }
        
       
        
        @IBAction func instagramButtonAction(_ sender: Any) {
            openContactWebVC(url: kInstaGramURL, navTitle: "Instagram")
        }
        
        @IBAction func emailButtonAction(_ sender: Any) {
            let mailComposeViewController = configureMailComposer()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                print("Can't send email")
            }
        }
        
        func configureMailComposer() -> MFMailComposeViewController{
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(["support@My11Kings.co.in"])
            return mailComposeVC
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
