//
//  PhoneRegistrationConfigurator.swift
//  iOSKycViews_Example
//
//  Created by Nik on 05/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import iOSKycViews
import iOSBaseViews
import Kingfisher

class PhoneRegistrationConfigurator : PhoneRegistrationConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
        
    var underlineFactory: Factory<UIView> {
        return screenProfile.getLineFactory("PHONE_UNDERLINE")
    }
    
    var phoneTextFieldFactory: ConfigurationFactory<UITextField> {
        return screenProfile.getTextFieldConfigurationFactory("PHONE_INPUT")
    }
    
    var phoneNumberLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("LABEL_PHONE_FORM")
    }
    
    var errorLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("ERROR_PHONE_FORM")
    }
    
    var continueButtonFactory : Factory<PrimaryButton> {
        return screenProfile.getPrimaryButtonFactory("CONTINUE_BUTTON")
    }
    
    var logoImageConfigurationFactory: ConfigurationFactory<UIImageView> {
        return screenProfile.getAssetConfigurationFactory("LOGO")
    }
    
    var disclaimerFactory: Factory<UITextView> {
        let factory : Factory<UITextView> = { [weak self] in
            let tv = UITextView()
            let label = self?.screenProfile.getLabelFactory("DISCLAIMER")()
            tv.isEditable = false
            tv.dataDetectorTypes = .link
            tv.isUserInteractionEnabled = true
            if let text = label?.text, let font = label?.font, let textColor = label?.textColor {
                tv.attributedText = try? NSAttributedString(HTMLString: text, font: font, textColor: textColor)
                tv.linkTextAttributes = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : textColor]
            }
            return tv
        }
        return factory
    }
    
    var phoneMaxLength: Int = 17
}
