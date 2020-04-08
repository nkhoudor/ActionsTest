//
//  NumTextFieldStyleProfile.swift
//  iOSKyc
//
//  Created by Nik on 27/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import SwiftyJSON
import Swinject
import iOSBaseViews

class NumTextFieldStyleProfile {
    let name: String
    let textNormalColorProfile: ColorProfile
    let textSuccessColorProfile: ColorProfile
    let textErrorColorProfile: ColorProfile
    let normalColorProfile: ColorProfile
    let successColorProfile: ColorProfile
    let errorColorProfile: ColorProfile
    let size: Int
    let fontProfile: FontProfile
    
    var font : UIFont {
        fontProfile.font.withSize(CGFloat(size))
    }
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        self.size = source["size"].int!
        
        self.textNormalColorProfile = resolver.resolve(ColorProfile.self, name: source["textNormalColor"].string!)!
        self.textSuccessColorProfile = resolver.resolve(ColorProfile.self, name: source["textSuccessColor"].string!)!
        self.textErrorColorProfile = resolver.resolve(ColorProfile.self, name: source["textErrorColor"].string!)!
        self.normalColorProfile = resolver.resolve(ColorProfile.self, name: source["normalColor"].string!)!
        self.successColorProfile = resolver.resolve(ColorProfile.self, name: source["successColor"].string!)!
        self.errorColorProfile = resolver.resolve(ColorProfile.self, name: source["errorColor"].string!)!
        
        self.fontProfile = resolver.resolve(FontProfile.self, name: source["font"].string!)!
    }
    
    var factory: Factory<NumTextField> {
        return NumTextField.getFactory(font: font, textNormalColor: textNormalColorProfile.color, textSuccessColor: textSuccessColorProfile.color, textErrorColor: textErrorColorProfile.color, normalColor: normalColorProfile.color, successColor: successColorProfile.color, errorColor: errorColorProfile.color)
    }
}
