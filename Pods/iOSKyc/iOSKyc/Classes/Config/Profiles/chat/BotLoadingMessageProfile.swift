//
//  BotLoadingMessageProfile.swift
//  iOSKyc
//
//  Created by Nik on 02/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import SwiftyJSON
import Swinject

class BotLoadingMessageProfile {
    let name: String
    let avatar: AssetProfile
    let backgroundColorProfile: ColorProfile
    let textContainerRadius: CGFloat
    let verticalMargin: CGFloat
    let horizontalMargin: CGFloat
    let avatarMargin: CGFloat
    let indicatorColorProfile: ColorProfile
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        self.avatar = resolver.resolve(AssetProfile.self, name: source["avatar"].string!)!
        self.backgroundColorProfile = resolver.resolve(ColorProfile.self, name: source["backgroundColor"].string!)!
        self.textContainerRadius = CGFloat(source["textContainerRadius"].float!)
        self.verticalMargin = CGFloat(source["verticalMargin"].float!)
        self.horizontalMargin = CGFloat(source["horizontalMargin"].float!)
        self.avatarMargin = CGFloat(source["avatarMargin"].float!)
        
        self.indicatorColorProfile = resolver.resolve(ColorProfile.self, name: source["indicatorColor"].string!)!
    }
}


