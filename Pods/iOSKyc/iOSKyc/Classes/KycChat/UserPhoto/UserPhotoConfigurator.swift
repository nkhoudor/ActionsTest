//
//  UserPhotoConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 19/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import iOSKycViews

class UserPhotoConfigurator : UserPhotoConfiguratorProtocol {
    
    let profile : UserPhotoMessageProfile
    
    init(profile : UserPhotoMessageProfile) {
        self.profile = profile
    }
    
    var photoPadding: CGFloat {
        return profile.photoPadding
    }
    
    var containerColor: UIColor {
        return profile.containerColorProfile.color
    }
    
    var containerShadowColor: UIColor {
        return profile.containerShadowColorProfile.color
    }
    
    var containerRadius: CGFloat {
        return profile.containerRadius
    }
}
