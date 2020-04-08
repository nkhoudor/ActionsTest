//
//  KYCLetsBeginConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class KYCLetsBeginConfigurator : ChatActionConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var firstButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_LETS_BEGIN")
    }
    
    var secondButtonFactory: Factory<UIButton>? = nil
    
    var bottomMargin: CGFloat = 40
    
    
}
