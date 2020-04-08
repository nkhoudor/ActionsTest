//
//  CheckPinCodeConfigurator.swift
//  iOSKycViews_Example
//
//  Created by Nik on 05/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import iOSBaseViews

class CheckPinCodeConfigurator : PinCodeConfiguratorProtocol {
    
    let pinCodeDotStyleProfile: PinCodeDotStyleProfile
    let pinCodeDigitButtonStyleProfile: PinCodeDigitButtonStyleProfile
    let screenProfile: ScreenProfile
    
    init(pinCodeDotStyleProfile: PinCodeDotStyleProfile, pinCodeDigitButtonStyleProfile: PinCodeDigitButtonStyleProfile, screenProfile: ScreenProfile) {
        self.pinCodeDotStyleProfile = pinCodeDotStyleProfile
        self.pinCodeDigitButtonStyleProfile = pinCodeDigitButtonStyleProfile
        self.screenProfile = screenProfile
    }
    
    var backgroundColor: UIColor = .clear
    
    var forgotButtonFactory: Factory<UIButton>? = nil
    
    var biometricsButtonFactory : ConfigurationFactory<UIButton>? = nil
    
    var policyButtonFactory : ConfigurationFactory<UIButton>? = nil
    
    var logoImageFactory: ConfigurationFactory<UIImageView>? {
        return screenProfile.getAssetConfigurationFactory("LOGO")
    }
    
    var titleLabelFactory: Factory<UILabel>? = nil
    
    var subtitleLabelFactory: Factory<UILabel>? = nil
    
    var eraseButtonImageFactory: ConfigurationFactory<UIButton> {
        return screenProfile.getAssetConfigurationFactory("ERASE")
    }
    
    var digitButtonFactory: Factory<DigitButton> {
        return pinCodeDigitButtonStyleProfile.factory
    }
    
    var dotFactory: Factory<DotView> {
        return pinCodeDotStyleProfile.factory
    }
    
    var errorLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("ERROR")
    }
}
