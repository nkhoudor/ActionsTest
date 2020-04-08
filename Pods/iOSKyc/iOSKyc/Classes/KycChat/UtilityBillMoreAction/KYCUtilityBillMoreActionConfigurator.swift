//
//  KYCUtilityBillMoreConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 22/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class KYCUtilityBillMoreActionConfigurator : ChatActionConfiguratorProtocol {
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var firstButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_I_UPLOADED_ALL")
    }
    
    var secondButtonFactory: Factory<UIButton>? {
        return screenProfile.getButtonFactory("BUTTON_ADDITIONAL_BILL_PAGES")
    }
    
    var bottomMargin: CGFloat = 40
}
