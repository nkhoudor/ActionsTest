//
//  UserTextMessageConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import iOSKycViews

class UserTextMessageConfigurator : UserTextMessageConfiguratorProtocol {
    
    let profile : UserTextMessageProfile
    
    init(profile : UserTextMessageProfile) {
        self.profile = profile
    }
    
    var textContainerColor: UIColor {
        return profile.backgroundColorProfile.color
    }
    
    var containerShadowColor: UIColor {
        return profile.containerShadowColorProfile.color
    }
    
    var textContainerRadius: CGFloat {
        return profile.textContainerRadius
    }
    
    var verticalMargin: CGFloat {
        return profile.verticalMargin
    }
    
    var horizontalMargin: CGFloat {
        return profile.horizontalMargin
    }
    
    var textFont: UIFont {
        return profile.font
    }
    
    var textColor: UIColor {
        return profile.colorProfile.color
    }
    
}
