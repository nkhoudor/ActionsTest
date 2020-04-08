//
//  HalfScreenModalStyleProfile.swift
//  iOSKyc
//
//  Created by Nik on 27/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit

class HalfScreenModalStyleProfile {
    let name: String
    let backgroundColorProfile: ColorProfile
    let coverColorProfile: ColorProfile
    let coverRatio: CGFloat
    let cornerRadius: CGFloat
    let topArrowAssetProfile: AssetProfile
    
    var backgroundColor : UIColor {
        backgroundColorProfile.color
    }
    
    var coverColor : UIColor {
        coverColorProfile.color
    }
    
    init(name: String, backgroundColorProfile: ColorProfile, coverColorProfile: ColorProfile, coverRatio: CGFloat, cornerRadius: CGFloat, topArrowAssetProfile: AssetProfile) {
        self.name = name
        self.backgroundColorProfile = backgroundColorProfile
        self.coverColorProfile = coverColorProfile
        self.coverRatio = coverRatio
        self.cornerRadius = cornerRadius
        self.topArrowAssetProfile = topArrowAssetProfile
    }
}
