//
//  RestrictedCountryConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 30/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews

class RestrictedCountryConfigurator : RestrictedCountryPopupConfiguratorProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var infoImageViewFactory: ConfigurationFactory<UIImageView> {
        return screenProfile.getAssetConfigurationFactory("ICON")
    }
    
    var descriptionLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("DESCRIPTION")
    }
    
    var changeNumberButtonFactory: Factory<UIButton> {
        return screenProfile.getPrimaryButtonFactory("CHANGE_NUMBER_BUTTON")
    }
    
    var psTextViewFactory: Factory<UITextView> {
        let factory : Factory<UITextView> = { [weak self] in
            let tv = UITextView()
            let label = self?.screenProfile.getLabelFactory("FIND_MORE")()
            tv.isEditable = false
            tv.isScrollEnabled = false
            tv.dataDetectorTypes = .link
            tv.isUserInteractionEnabled = true
            if let text = label?.text {
                tv.attributedText = try? NSAttributedString(HTMLString: text, font: label!.font, textColor: label!.textColor)
            }
            return tv
        }
        return factory
    }
    
    
}
