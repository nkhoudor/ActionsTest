//
//  KYCUtilityBillActionConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 22/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class KYCUtilityBillActionConfigurator : ChatActionConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var firstButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("ANY_UTILITY_BILL")
    }
    
    var secondButtonFactory: Factory<UIButton>? = nil
    
    var bottomMargin: CGFloat = 40
}
