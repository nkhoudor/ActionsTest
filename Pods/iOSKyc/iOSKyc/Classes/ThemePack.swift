//
//  ThemePack.swift
//  iOSBaseViews_Example
//
//  Created by Nik on 05/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import iOSBaseViews

extension UIColor {
  struct Theme {
    static let mainColor: UIColor = UIColor(argb: 0xFF0267B4)
    static let mainShadowColor: UIColor = UIColor(rgb: 0x02599C)
    static let warningColor: UIColor = UIColor(rgb: 0xFF6F00)
    static let warningColor10: UIColor = UIColor(argb: 0x1AFF6F00)
    static let mainBlackColor: UIColor = UIColor(argb: 0xCC0E1114)
    static let secondaryTextColor: UIColor = UIColor(argb: 0x660E1114)
    
    static let sideBarBackground: UIColor = UIColor(rgb: 0xF3F4F5)
    
    static let gray50: UIColor = UIColor(argb: 0x800E1114)
    static let gray40: UIColor = UIColor(argb: 0x660E1114)
    static let gray24: UIColor = UIColor(argb: 0x3D0E1114)
    static let gray10: UIColor = UIColor(argb: 0x1A0E1114)
    static let gray5: UIColor = UIColor(argb: 0x0D0E1114)
    static let gray3: UIColor = UIColor(argb: 0x080E1114)
    
    static let dotFilled: UIColor = UIColor(argb: 0xCC0E1114)
    static let dotSuccess: UIColor = UIColor(argb: 0x4D00B533)
    static let dotError: UIColor = UIColor(argb: 0x4DFF6F00)
    
    static let textSuccess: UIColor = UIColor(rgb: 0x00B533)
    static let textError: UIColor = UIColor(rgb: 0xFF6F00)
  }
}

extension UIFont {
    struct Theme {
        static let font : UIFont = UIFont.systemFont(ofSize: 17)
        static let semiBoldFont : UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let boldFont : UIFont = UIFont.boldSystemFont(ofSize: 18)
    }
}
