//
//  CameraSettingsActionConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 19/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class CameraSettingsActionConfigurator : ChatActionConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var firstButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_CAMERA_SETTINGS")
    }
    
    var secondButtonFactory: Factory<UIButton>? = nil
    
    var bottomMargin: CGFloat = 40
}

