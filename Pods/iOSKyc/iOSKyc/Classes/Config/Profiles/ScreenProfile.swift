//
//  ScreenProfile.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import iOSBaseViews
import Kingfisher

class ScreenProfile {
    let name: String
    let texts: [String : TextStyleProfile]
    let buttons: [String : ButtonStyleProfile]
    let assets: [String : AssetProfile]
    let lines: [String : LineStyleProfile]
    let localizationProfile : ScreenLocalizationProfile?
    
    init(name: String, texts: [String : TextStyleProfile], buttons: [String : ButtonStyleProfile], assets: [String: AssetProfile], lines: [String : LineStyleProfile], localizationProfile : ScreenLocalizationProfile?) {
        self.name = name
        self.texts = texts
        self.buttons = buttons
        self.assets = assets
        self.lines = lines
        self.localizationProfile = localizationProfile
    }
    
    func getLocalizedText(_ key: String) -> String {
        return localizationProfile?.localization[key] ?? ""
    }
    
    func getLabelFactory(_ key: String) -> Factory<UILabel> {
        let style = texts[key]!
        let text = localizationProfile?.localization[key]
        let factory = { () -> UILabel in
            let label = UILabel()
            label.font = style.font
            label.text = text
            label.textColor = style.color
            return label
        }
        return factory
    }
    
    func getLabelConfigurationFactory(_ key: String) -> ConfigurationFactory<UILabel> {
        let style = texts[key]!
        let text = localizationProfile?.localization[key]
        let factory : ConfigurationFactory<UILabel> = { label in
            label.font = style.font
            label.text = text
            label.textColor = style.color
        }
        return factory
    }
    
    func getPrimaryButtonFactory(_ key: String) -> Factory<PrimaryButton> {
        let style = buttons[key]!
        let text = localizationProfile?.localization[key]
        let primaryStyle = style as! PrimaryButtonStyleProfile
        let factory = { () -> PrimaryButton in
            let button = PrimaryButton()
            button.setTitle(text, for: .normal)
            button.setTitleColor(primaryStyle.textColor, for: .normal)
            button.titleLabel?.font = primaryStyle.font
            button.buttonColor = primaryStyle.buttonColor
            button.shadowColor = primaryStyle.shadowColor
            button.successColor = primaryStyle.successColor
            button.successShadowColor = primaryStyle.successShadowColor
            button.cornerRadius = primaryStyle.cornerRadius
            return button
        }
        return factory
    }
    
    func getButtonFactory(_ key: String) -> Factory<UIButton> {
        let style = buttons[key]!
        let text = localizationProfile?.localization[key]
        
        if style is PrimaryButtonStyleProfile {
            return getPrimaryButtonFactory(key)
        } else {
            let factory = { () -> UIButton in
                let button = UIButton()
                button.setTitle(text, for: .normal)
                button.setTitleColor(style.textColor, for: .normal)
                button.titleLabel?.font = style.font
                
                button.layer.cornerRadius = style.cornerRadius
                button.layer.backgroundColor = style.buttonColor.cgColor
                return button
            }
            return factory
        }
    }
    
    func getAssetConfigurationFactory(_ key: String) -> ConfigurationFactory<UIImageView> {
        return assets[key]!.getAssetConfigurationFactory()
    }
    
    func getAssetConfigurationFactory(_ key: String) -> ConfigurationFactory<UIButton> {
        return assets[key]!.getAssetConfigurationFactory()
    }
    
    func getTextFieldFactory(_ key: String) -> Factory<UITextField> {
        let style = texts[key]!
        let text = localizationProfile?.localization[key]
        let factory : Factory<UITextField> = {
            let textField = UITextField()
            textField.textColor = style.color
            textField.font = style.font
            textField.text = text
            return textField
        }
        return factory
    }
    
    func getTextFieldConfigurationFactory(_ key: String) -> ConfigurationFactory<UITextField> {
        let style = texts[key]!
        let text = localizationProfile?.localization[key]
        let factory : ConfigurationFactory<UITextField> = { textField in
            textField.textColor = style.color
            textField.font = style.font
            textField.text = text
        }
        return factory
    }
    
    func getLineFactory(_ key: String) -> Factory<UIView> {
        let lineStyle = lines[key]!
        let factory : Factory<UIView> = {
            let v = UIView()
            v.frame = CGRect(x: 0, y: 0, width: 0, height: lineStyle.thickness)
            v.layer.cornerRadius = lineStyle.cornerRadius
            v.clipsToBounds = true
            v.backgroundColor = lineStyle.color
            return v
        }
        return factory
    }
}
