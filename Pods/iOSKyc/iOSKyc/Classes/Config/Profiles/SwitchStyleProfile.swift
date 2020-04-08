//
//  SwitchStyleProfile.swift
//  iOSKyc
//
//  Created by Nik on 03/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import SwiftyJSON
import iOSBaseViews

class SwitchStyleProfile {
    let name: String
    let onColorProfile: ColorProfile
    let offColorProfile: ColorProfile
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        self.onColorProfile = resolver.resolve(ColorProfile.self, name: source["onColor"].string!)!
        self.offColorProfile = resolver.resolve(ColorProfile.self, name: source["offColor"].string!)!
    }
    
    var factory: Factory<UISwitch> {
        return UISwitch.getFactory(onColor: onColorProfile.color, offColor: offColorProfile.color)
    }
}
