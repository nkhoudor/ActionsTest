//
//  BotTextMessageProfile.swift
//  iOSKyc
//
//  Created by Nik on 01/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import SwiftyJSON
import Swinject

class BotTextMessageProfile {
    let name: String
    let colorProfile: ColorProfile
    let fontProfile: FontProfile
    let size: Int
    let avatar: AssetProfile
    let backgroundColorProfile: ColorProfile
    let textContainerRadius: CGFloat
    let verticalMargin: CGFloat
    let horizontalMargin: CGFloat
    let avatarMargin: CGFloat
    let warningColorProfile: ColorProfile
    let warningThickness: CGFloat
    let warningCornerRadius: CGFloat
    let maskImageFontProfile: FontProfile
    let maskImageFontSize: Int
    let maskImageTextColorProfile: ColorProfile
    let maskImageMaskColorProfile: ColorProfile
    let maskImageCornerRadius: CGFloat
    
    var font : UIFont {
        fontProfile.font.withSize(CGFloat(size))
    }
    
    var maskImageFont : UIFont {
        maskImageFontProfile.font.withSize(CGFloat(maskImageFontSize))
    }
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        self.size = source["size"].int!
        self.fontProfile = resolver.resolve(FontProfile.self, name: source["font"].string!)!
        self.colorProfile = resolver.resolve(ColorProfile.self, name: source["color"].string!)!
        self.avatar = resolver.resolve(AssetProfile.self, name: source["avatar"].string!)!
        self.backgroundColorProfile = resolver.resolve(ColorProfile.self, name: source["backgroundColor"].string!)!
        self.textContainerRadius = CGFloat(source["textContainerRadius"].float!)
        self.verticalMargin = CGFloat(source["verticalMargin"].float!)
        self.horizontalMargin = CGFloat(source["horizontalMargin"].float!)
        self.avatarMargin = CGFloat(source["avatarMargin"].float!)
        
        self.warningColorProfile = resolver.resolve(ColorProfile.self, name: source["warningColor"].string!)!
        self.warningThickness = CGFloat(source["warningThickness"].float!)
        self.warningCornerRadius = CGFloat(source["warningCornerRadius"].float!)
        
        self.maskImageFontProfile = resolver.resolve(FontProfile.self, name: source["maskImageFont"].string!)!
        self.maskImageFontSize = source["maskImageFontSize"].int!
        self.maskImageTextColorProfile = resolver.resolve(ColorProfile.self, name: source["maskImageTextColor"].string!)!
        self.maskImageMaskColorProfile = resolver.resolve(ColorProfile.self, name: source["maskImageMaskColor"].string!)!
        self.maskImageCornerRadius = CGFloat(source["maskImageCornerRadius"].float!)
    }
}

