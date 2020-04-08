//
//  TextStyleProfile.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit

class TextStyleProfile {
    let name: String
    let colorProfile: ColorProfile
    let fontProfile: FontProfile
    let size: Int
    
    var font : UIFont {
        fontProfile.font.withSize(CGFloat(size))
    }
    
    var color : UIColor {
        colorProfile.color
    }
    
    init(name: String, colorProfile: ColorProfile, fontProfile: FontProfile, size: Int) {
        self.name = name
        self.colorProfile = colorProfile
        self.fontProfile = fontProfile
        self.size = size
    }
}
