//
//  WrongCountryConnectEmailActionConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 13/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class WrongCountryConnectEmailActionConfigurator : ChatActionConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var firstButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_WRONG_COUNTRY_CONNECT_EMAIL_ACCEPT")
    }
    
    var secondButtonFactory: Factory<UIButton>? {
        return screenProfile.getButtonFactory("BUTTON_WRONG_COUNTRY_CONNECT_EMAIL_DENY")
    }
    
    var bottomMargin: CGFloat = 40
}

