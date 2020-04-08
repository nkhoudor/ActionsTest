//
//  UserPhotoMessageProfile.swift
//  iOSKyc
//
//  Created by Nik on 02/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import SwiftyJSON
import Swinject

class UserPhotoMessageProfile {
    let name: String
    let containerColorProfile: ColorProfile
    let containerRadius: CGFloat
    let photoPadding: CGFloat
    let containerShadowColorProfile: ColorProfile
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        self.containerColorProfile = resolver.resolve(ColorProfile.self, name: source["containerColor"].string!)!
        self.containerRadius = CGFloat(source["containerRadius"].float!)
        self.photoPadding = CGFloat(source["photoPadding"].float!)
        self.containerShadowColorProfile = resolver.resolve(ColorProfile.self, name: source["containerShadowColor"].string!)!
    }
}


