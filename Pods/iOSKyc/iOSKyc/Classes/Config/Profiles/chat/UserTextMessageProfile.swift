//
//  UserTextMessageProfile.swift
//  iOSKyc
//
//  Created by Nik on 02/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import SwiftyJSON
import Swinject

class UserTextMessageProfile {
    let name: String
    let colorProfile: ColorProfile
    let fontProfile: FontProfile
    let size: Int
    let backgroundColorProfile: ColorProfile
    let textContainerRadius: CGFloat
    let verticalMargin: CGFloat
    let horizontalMargin: CGFloat
    let containerShadowColorProfile: ColorProfile
    
    var font : UIFont {
        fontProfile.font.withSize(CGFloat(size))
    }
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        self.size = source["size"].int!
        self.fontProfile = resolver.resolve(FontProfile.self, name: source["font"].string!)!
        self.colorProfile = resolver.resolve(ColorProfile.self, name: source["color"].string!)!
        self.backgroundColorProfile = resolver.resolve(ColorProfile.self, name: source["backgroundColor"].string!)!
        self.textContainerRadius = CGFloat(source["textContainerRadius"].float!)
        self.verticalMargin = CGFloat(source["verticalMargin"].float!)
        self.horizontalMargin = CGFloat(source["horizontalMargin"].float!)
        self.containerShadowColorProfile = resolver.resolve(ColorProfile.self, name: source["containerShadowColor"].string!)!
    }
}

