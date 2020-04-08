//
//  UIColorExtensions.swift
//  iOSBaseViews
//
//  Created by Nik on 02/01/2020.
//

import Foundation

public extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
    
    convenience init(rgb: Int) {
        let r = (rgb >> 16) & 0xFF
        let g = (rgb >> 8) & 0xFF
        let b = rgb & 0xFF
        self.init(red: r, green: g, blue: b)
    }
    
    convenience init(argb: Int) {
        let r = (argb >> 16) & 0xFF
        let g = (argb >> 8) & 0xFF
        let b = argb & 0xFF
        let a = (argb >> 24) & 0xFF
        self.init(red: r, green: g, blue: b, a: a)
    }
}
