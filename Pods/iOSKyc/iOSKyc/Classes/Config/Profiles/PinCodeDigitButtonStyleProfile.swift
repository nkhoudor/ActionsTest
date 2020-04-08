//
//  PinCodeDigitButtonStyleProfile.swift
//  iOSKyc
//
//  Created by Nik on 28/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import SwiftyJSON
import Swinject
import iOSBaseViews

class PinCodeDigitButtonStyleProfile {
    let name: String
    
    let titleColorProfile: ColorProfile
    let buttonColorProfile: ColorProfile
    let pressedColorProfile: ColorProfile
    
    let size: Int
    let fontProfile: FontProfile
    
    var font : UIFont {
        fontProfile.font.withSize(CGFloat(size))
    }
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        self.size = source["size"].int!
        
        self.titleColorProfile = resolver.resolve(ColorProfile.self, name: source["titleColor"].string!)!
        self.buttonColorProfile = resolver.resolve(ColorProfile.self, name: source["buttonColor"].string!)!
        self.pressedColorProfile = resolver.resolve(ColorProfile.self, name: source["pressedColor"].string!)!
        
        self.fontProfile = resolver.resolve(FontProfile.self, name: source["font"].string!)!
    }
    
    var factory: Factory<DigitButton> {
        return DigitButton.getFactory(font: font, titleColor: titleColorProfile.color, title: "", buttonColor: buttonColorProfile.color, pressedColor: pressedColorProfile.color)
    }
}

