//
//  PrimaryButtonStyleProfile.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import iOSBaseViews

class PrimaryButtonStyleProfile : ButtonStyleProfile {
    let shadowColorProfile: ColorProfile
    let successColorProfile: ColorProfile
    let successShadowColorProfile: ColorProfile
    
    var shadowColor : UIColor {
        shadowColorProfile.color
    }
    
    var successColor : UIColor {
        successColorProfile.color
    }
    
    var successShadowColor : UIColor {
        successShadowColorProfile.color
    }
    
    init(name: String, fontProfile: FontProfile, size: Int, textColorProfile: ColorProfile, buttonColorProfile: ColorProfile, shadowColorProfile: ColorProfile, successColorProfile: ColorProfile, successShadowColorProfile: ColorProfile, cornerRadius: CGFloat) {
        self.shadowColorProfile = shadowColorProfile
        self.successColorProfile = successColorProfile
        self.successShadowColorProfile = successShadowColorProfile
        super.init(name: name, fontProfile: fontProfile, size: size, textColorProfile: textColorProfile, buttonColorProfile: buttonColorProfile, cornerRadius: cornerRadius)
    }
}
