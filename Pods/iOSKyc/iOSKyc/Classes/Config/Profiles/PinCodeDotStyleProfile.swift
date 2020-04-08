//
//  PinCodeDotStyleProfile.swift
//  iOSKyc
//
//  Created by Nik on 28/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import SwiftyJSON
import Swinject
import iOSBaseViews

class PinCodeDotStyleProfile {
    let name: String
    
    let normalColorProfile: ColorProfile
    let filledColorProfile: ColorProfile
    let successColorProfile: ColorProfile
    let errorColorProfile: ColorProfile
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        
        self.normalColorProfile = resolver.resolve(ColorProfile.self, name: source["normalColor"].string!)!
        self.filledColorProfile = resolver.resolve(ColorProfile.self, name: source["filledColor"].string!)!
        self.successColorProfile = resolver.resolve(ColorProfile.self, name: source["successColor"].string!)!
        self.errorColorProfile = resolver.resolve(ColorProfile.self, name: source["errorColor"].string!)!
    }
    
    var factory: Factory<DotView> {
        return DotView.getFactory(normalColor: normalColorProfile.color, filledColor: filledColorProfile.color, successColor: successColorProfile.color, errorColor: errorColorProfile.color)
    }
}
