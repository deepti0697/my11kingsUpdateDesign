//
//  HomeTabBarController.swift
//  DreamTeam
//
//  Created by Test on 12/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController,UITabBarControllerDelegate {

    
          var matchTYPE = "Cricket"
           var checkHomeType = false
            override func viewDidLoad() {
                super.viewDidLoad()
                self.delegate = self
                self.view.layoutIfNeeded()
            }
            
    
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                customizeTabBarView()
                configureTabItems()
                self.tabBar.unselectedItemTintColor = UIColor(red: 133/255.0, green: 116/255.0, blue: 78/255.0, alpha: 1.0)
            }
         
            fileprivate func configureTabItems() {
                let selectedColor = UIColor(red: 185, green: 33, blue: 36)
                let unselectedColor = UIColor(red: 133, green: 116, blue: 78)
                UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
                UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
                if let arrayOfTabBarItems = self.tabBar.items as NSArray? {
                    for (index, item) in arrayOfTabBarItems.enumerated() {
                        if let tabItem = item as? UITabBarItem {
                          tabItem.tag = index
                          tabItem.title = homeTabOptions[index]
                          tabItem.image = UIImage(named: homeTabDefaultImage[index])
                          tabItem.selectedImage = UIImage(named: homeTabSelectedImage[index])

                            tabItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1)
                        }
                    }
                }
            }
            
            fileprivate func customizeTabBarView() {
                let bgView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "Path 25163"))
                bgView.contentMode = .scaleToFill
                   bgView.frame = tabBar.bounds
                   tabBar.addSubview(bgView)
                
UITabBar.appearance().barTintColor = UIColor(red: 255, green: 253, blue: 166)
UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 133, green: 116, blue: 78), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .selected)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: .normal)
            }
    
       
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 40
        return sizeThatFits
    }
}
