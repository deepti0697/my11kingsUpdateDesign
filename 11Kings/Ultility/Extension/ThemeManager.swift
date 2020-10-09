//
//  ThemeManager.swift
//  LoginScreen
//
//  Created by Test on 07/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//
import UIKit
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }

struct FlatColor {
    struct white {
        static let whitecolor = UIColor(netHex: 0xffffff)
    }
    struct Black {
        static let balckcolor = UIColor(netHex: 0x141414)
    }
    struct Green {
        static let f = UIColor()
        static let Fern = UIColor(netHex: 0x6ABB72)
        static let ParrotGreen = UIColor(netHex: 0x28b446)
        static let ChateauGreen = UIColor(netHex: 0x4DA664)
        static let PersianGreen = UIColor(netHex: 0x2CA786)
    }
    struct Grey {
        static let DarkGrey = UIColor(netHex: 0x8e9193)
        static let lightGrey = UIColor(netHex: 0xe1e1e1)
    }
    struct Blue {
        static let DarkBlue = UIColor(netHex: 0x04263f)
        static let lightBlue = UIColor(netHex: 0x3b5999)
        static let skyBlue = UIColor(netHex: 0x518ef8)
        static let Denim = UIColor(netHex: 0x2F6CAD)
        static let Chambray = UIColor(netHex: 0x485675)
        static let GreenishBlue = UIColor(netHex: 0x0875b7)
    }
    
    struct Violet {
        static let Wisteria = UIColor(netHex: 0x9069B5)
        static let BlueGem = UIColor(netHex: 0x533D7F)
    }
    
    struct Yellow {
        static let yellowColor = UIColor(netHex: 0xfbbb00)
        static let Turbo = UIColor(netHex: 0xF7C23E)
    }
    
    struct Orange {
        static let NeonCarrot = UIColor(netHex: 0xF79E3D)
        static let Sun = UIColor(netHex: 0xEE7841)
    }
    
    struct Red {
        static let BloodRed = UIColor(netHex: 0xf14336)
        static let Valencia = UIColor(netHex: 0xCC4846)
        static let Cinnabar = UIColor(netHex: 0xDC5047)
        static let WellRead = UIColor(netHex: 0xB33234)
    }
}

}

