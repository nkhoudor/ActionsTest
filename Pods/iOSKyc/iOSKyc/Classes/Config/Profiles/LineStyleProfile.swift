//
//  LineStyleProfile.swift
//  iOSKyc
//
//  Created by Nik on 27/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit

class LineStyleProfile {
    let name: String
    let colorProfile: ColorProfile
    let thickness: CGFloat
    let cornerRadius: CGFloat
    
    var color : UIColor {
        colorProfile.color
    }
    
    init(name: String, colorProfile: ColorProfile, thickness: CGFloat, cornerRadius: CGFloat) {
        self.name = name
        self.colorProfile = colorProfile
        self.thickness = thickness
        self.cornerRadius = cornerRadius
    }
}
