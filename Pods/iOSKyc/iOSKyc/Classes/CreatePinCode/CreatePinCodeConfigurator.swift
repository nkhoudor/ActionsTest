//
//  PhoneRegistrationConfigurator.swift
//  iOSKycViews_Example
//
//  Created by Nik on 05/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import iOSBaseViews

class CreatePinCodeConfigurator : PinCodeConfiguratorProtocol {
    
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
    
    var policyButtonFactory : ConfigurationFactory<UIButton>? {
        return {[weak self] button in
            guard let templateLabel = self?.screenProfile.getLabelFactory("POLICY_BUTTON_TEXT")() else { return }
    
            if let attributeString = try? NSAttributedString(HTMLString: templateLabel.text ?? "", font: templateLabel.font, textColor: templateLabel.textColor) {
                button.setAttributedTitle(attributeString, for: .normal)
            }
            
            button.titleLabel?.textAlignment = .center
            button.titleLabel?.numberOfLines = 0
        }
    }
    
    var logoImageFactory: ConfigurationFactory<UIImageView>? {
        return nil
    }
    
    var titleLabelFactory: Factory<UILabel>? {
        return screenProfile.getLabelFactory("HEADER")
    }
    
    var subtitleLabelFactory: Factory<UILabel>? {
        return screenProfile.getLabelFactory("SUBTITLE")
    }
    
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
