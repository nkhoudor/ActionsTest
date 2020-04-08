//
//  LabeledTextFieldProfile.swift
//  iOSKyc
//
//  Created by Nik on 02/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import SwiftyJSON
import Swinject
import iOSBaseViews

class LabeledTextFieldProfile {
    let name: String
    let fontProfile: FontProfile
    let size: Int
    let textColorProfile: ColorProfile
    let labelColorProfile: ColorProfile
    let errorColorProfile: ColorProfile
    let underlineColorProfile: ColorProfile
    
    var font : UIFont {
        fontProfile.font.withSize(CGFloat(size))
    }
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        self.size = source["size"].int!
        self.fontProfile = resolver.resolve(FontProfile.self, name: source["font"].string!)!
        self.textColorProfile = resolver.resolve(ColorProfile.self, name: source["textColor"].string!)!
        self.labelColorProfile = resolver.resolve(ColorProfile.self, name: source["labelColor"].string!)!
        self.errorColorProfile = resolver.resolve(ColorProfile.self, name: source["errorColor"].string!)!
        self.underlineColorProfile = resolver.resolve(ColorProfile.self, name: source["underlineColor"].string!)!
        
    }
    
    var labeledTextFieldFactory: Factory<LabeledTextFieldView> {
        return LabeledTextFieldView.getFactory(labelFactory: UILabel.getFactory(font: font, textColor: labelColorProfile.color, text: nil), textFieldColor: textColorProfile.color, errorColor: errorColorProfile.color, underlineColor: underlineColorProfile.color)
    }
}
