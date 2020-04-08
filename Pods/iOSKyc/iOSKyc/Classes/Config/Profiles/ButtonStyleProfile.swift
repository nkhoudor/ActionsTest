//
//  ButtonStyleProfile.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit

class ButtonStyleProfile {
    let name: String
    let fontProfile: FontProfile
    let size: Int
    let textColorProfile: ColorProfile
    let buttonColorProfile: ColorProfile
    let cornerRadius: CGFloat
    
    var font : UIFont {
        fontProfile.font.withSize(CGFloat(size))
    }
    
    var textColor : UIColor {
        textColorProfile.color
    }
    
    var buttonColor : UIColor {
        buttonColorProfile.color
    }
    
    init(name: String, fontProfile: FontProfile, size: Int, textColorProfile: ColorProfile, buttonColorProfile: ColorProfile, cornerRadius: CGFloat) {
        self.name = name
        self.fontProfile = fontProfile
        self.size = size
        self.textColorProfile = textColorProfile
        self.buttonColorProfile = buttonColorProfile
        self.cornerRadius = cornerRadius
    }
}
