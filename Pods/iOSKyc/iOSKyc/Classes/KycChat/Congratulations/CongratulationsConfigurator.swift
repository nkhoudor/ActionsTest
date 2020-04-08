//
//  CongratulationsConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 23/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class CongratulationsConfigurator : CongratulationsConfiguratorProtocol {
    
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
        return screenProfile.getLabelFactory("CONGRATULATIONS_TITLE")
    }
    
    var descriptionLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("CONGRATULATIONS_SUBTITLE")
    }
    
    var whatsNextButtonFactory: Factory<UIButton>?  {
        return screenProfile.getButtonFactory("BUTTON_FINISH")
    }
    
    
}
