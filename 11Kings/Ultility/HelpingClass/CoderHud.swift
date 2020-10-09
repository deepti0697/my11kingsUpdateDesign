//
//  CoderHud.swift
//  Muzibees
//
//  Created by Ajay on 08/06/18.
//  Copyright © 2018 Arthonsys Technologies LLP. All rights reserved.
//

import Foundation
import NVActivityIndicatorView


class CoderHud: NSObject, NVActivityIndicatorViewable{
    
    // Options
    //size: <#T##CGSize?#>
    //message: <#T##String?#>
    //messageFont: <#T##UIFont?#>
    //messageSpacing: <#T##CGFloat?#>
    //type: <#T##NVActivityIndicatorType?#>
    //color: <#T##UIColor?#>
    //padding: <#T##CGFloat?#>
    //displayTimeThreshold: <#T##Int?#>
    //minimumDisplayTime: <#T##Int?#>
    //backgroundColor: UIColor.clear
    //textColor: <#T##UIColor?#>
    
    class func show(){
       let activityData = ActivityData(type: .circleStrokeSpin, color: UIColor(hex: "CD0945"), backgroundColor: UIColor.clear)
       // let activityData = ActivityData(type: .circleStrokeSpin, color: UIColor(hex: "000000"), backgroundColor: UIColor.clear)
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    class func show( withStatus : String){
        let activityData = ActivityData(message: withStatus, messageFont: UIFont.systemFont(ofSize: 15), type: .circleStrokeSpin, color: UIColor(hex: "CD0945"), backgroundColor: UIColor.clear, textColor : UIColor(hex: "CD0945"))
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    class func dismiss(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}

//***
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
