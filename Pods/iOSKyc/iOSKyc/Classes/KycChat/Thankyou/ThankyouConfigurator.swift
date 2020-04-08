//
//  ThankyouConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 13/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class ThankyouConfigurator : CongratulationsConfiguratorProtocol {
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var containerBackgroundColor: UIColor = .white
    
    var containerCornerRadius: CGFloat = 4
    
    var shadowColor: UIColor = UIColor.Theme.mainBlackColor
    
    var successImageConfigurationFactory: ConfigurationFactory<UIImageView> {
        return screenProfile.getAssetConfigurationFactory("SUCCESS")
    }
    
    var titleLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("THANK_YOU_TITLE")
    }
    
    var descriptionLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("THANK_YOU_SUBTITLE")
    }
    
    var whatsNextButtonFactory: Factory<UIButton>? = nil
}
