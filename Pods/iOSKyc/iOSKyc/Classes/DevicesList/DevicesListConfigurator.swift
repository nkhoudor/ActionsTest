//
//  DevicesListConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 27/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class DevicesListConfigurator : DevicesListConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    let prohibitedColorProfile : ColorProfile
    
    lazy var sendButtonStyle : PrimaryButtonStyleProfile = {
        return screenProfile.buttons["CONFIRM_BUTTON"] as! PrimaryButtonStyleProfile
    }()
    
    init(screenProfile: ScreenProfile, prohibitedColorProfile : ColorProfile) {
        self.screenProfile = screenProfile
        self.prohibitedColorProfile = prohibitedColorProfile
    }
    
    var sendButtonBackgroundColor: UIColor {
        return sendButtonStyle.buttonColor
    }
    
    var sendButtonShadowColor: UIColor {
        return sendButtonStyle.shadowColor
    }
    
    var sendButtonProhibitedColor: UIColor {
        return prohibitedColorProfile.color
    }
    
    var sendButtonCornerRadius: CGFloat {
        return sendButtonStyle.cornerRadius
    }
    
    var sendLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("BUTTON_SEND")
    }
    
    var resendLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("BUTTON_RESEND")
    }
    var resendInLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("TIMER_REEQUEST_RESEND")
    }
    
    var recoverButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_RECOVERY")
    }
    
    var cellNameConfigurationFactory: ConfigurationFactory<UILabel> {
        return screenProfile.getLabelConfigurationFactory("CELL_NAME")
    }
    
    var cellDescriptionConfigurationFactory: ConfigurationFactory<UILabel> {
        return screenProfile.getLabelConfigurationFactory("CELL_DESCRIPTION")
    }
    
    var titleLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("TITLE")
    }
}
