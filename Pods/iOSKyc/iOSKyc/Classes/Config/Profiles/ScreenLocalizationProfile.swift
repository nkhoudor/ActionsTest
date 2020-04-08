//
//  ScreenLocalizationProfile.swift
//  iOSKyc
//
//  Created by Nik on 27/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit

class ScreenLocalizationProfile {
    let name: String
    let localization: [String : String]
    
    init(name: String, localization: [String : String]) {
        self.name = name
        self.localization = localization
    }
}
