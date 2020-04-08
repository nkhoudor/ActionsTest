//
//  UtilityBillAddressActionConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 22/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class UtilityBillAddressActionConfigurator : ChatActionConfiguratorProtocol {
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var firstButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_GOT_IT")
    }
    
    var secondButtonFactory: Factory<UIButton>? = nil
    
    var bottomMargin: CGFloat = 40
}
