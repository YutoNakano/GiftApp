//
//  AppColor.swift
//  GiftApp
//
//  Created by 中野湧仁 on 2019/08/16.
//  Copyright © 2019 中野湧仁. All rights reserved.
//


import UIKit

public enum AppColorType: String {
    
    case white = "FFFFFF"
    case black = "000000"
    case character = "5B5355"
    case yesPink = "DD78A4"
    case subPink = "DE8892"
    case noBlue = "ABBEE9"
    case gray = "ABBEE8"
    case background = "E7F1FD"
    case lightGray = "DEDADA"
    case navbar = "FEFFFF"
    case lineGreen = "50B535"
    case alartRed = "FD5105"
    case twitterBlue = "72B4E1"
    case pinkBackground = "A0FAEC"
}

extension UIColor {

    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    public static func appColor(_ type: AppColorType, alpha:CGFloat? = nil) -> UIColor {
        if let alpha = alpha {
            return UIColor(hex: type.rawValue).withAlphaComponent(alpha)
        } else {
            return UIColor(hex: type.rawValue)
        }
    }
    
    
}
