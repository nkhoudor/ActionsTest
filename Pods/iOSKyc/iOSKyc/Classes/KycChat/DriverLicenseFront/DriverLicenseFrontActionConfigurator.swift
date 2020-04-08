//
//  DriverLicenseFrontActionConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class DriverLicenseFrontActionConfigurator : ChatActionConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var firstButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_DRIVER_LICENSE_FRONT")
    }
    
    var secondButtonFactory: Factory<UIButton>? {
        return screenProfile.getButtonFactory("BUTTON_CHANGE_DOCUMENT")
    }
    
    var bottomMargin: CGFloat = 40
}
