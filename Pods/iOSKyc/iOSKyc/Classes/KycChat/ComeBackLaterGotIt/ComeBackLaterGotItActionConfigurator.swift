//
//  ComeBackLaterGotItActionConfigurator.swift
//  FlagKit
//
//  Created by Admin on 23/03/2020.
//

import iOSBaseViews
import iOSKycViews

class ComeBackLaterGotItActionConfigurator : ChatActionConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var firstButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_THANK_YOU_GOT_IT")
    }
    
    var secondButtonFactory: Factory<UIButton>? = nil
    
    var bottomMargin: CGFloat = 40
}


