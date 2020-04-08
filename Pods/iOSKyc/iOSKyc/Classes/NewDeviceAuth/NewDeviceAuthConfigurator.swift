//
//  NewDeviceAuthConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 10/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycSDK
import Swinject
import iOSKycViews

class NewDeviceAuthConfigurator : NewDeviceAuthConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "NEW_DEVICE_AUTH")!
    }()
    
    let deviceInfo : DeviceInfo
    
    init(deviceInfo : DeviceInfo) {
        self.deviceInfo = deviceInfo
    }
    
    var titleFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("TITLE")
    }
    
    var subtitleFactory: Factory<UILabel> {
        let label = screenProfile.getLabelFactory("SUBTITLE")()
        let deviceStr = deviceInfo.model ?? deviceInfo.device ?? ""
        let factory : Factory<UILabel> = {
            label.text = "\(deviceStr)\(label.text ?? "")"
            return label
        }
        return factory
    }
    
    var deviceImageConfigurationFactory: ConfigurationFactory<UIImageView> {
        let emptyFactory : ConfigurationFactory<UIImageView> = { _ in }
        guard let type = deviceInfo.deviceType else { return emptyFactory }
        switch type {
        case .ios:
            return screenProfile.getAssetConfigurationFactory("MOBILE")
        case .android:
            return screenProfile.getAssetConfigurationFactory("MOBILE")
        case .mobile:
            return screenProfile.getAssetConfigurationFactory("MOBILE")
        case .pc:
            return screenProfile.getAssetConfigurationFactory("PC")
        }
    }
    
    var confirmButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_CONFIRM")
    }
    
    var confirmButtonTitle: String {
        return screenProfile.getLocalizedText("BUTTON_CONFIRM")
    }
    
    var disableConfirmButtonConfigurationFacory: ConfigurationFactory<UIButton> {
        let buttonStyle = screenProfile.buttons["BUTTON_CONFIRM_DISABLED"] as? PrimaryButtonStyleProfile
        let factory : ConfigurationFactory<UIButton> = { button in
            guard let buttonStyle = buttonStyle else { return }
            (button as! PrimaryButton).setBackgroundColor(backgroundColor: buttonStyle.buttonColor, shadowColor: buttonStyle.shadowColor)
        }
        return factory
    }
    
    var enableConfirmButtonConfigurationFacory: ConfigurationFactory<UIButton> {
        let buttonStyle = screenProfile.buttons["BUTTON_CONFIRM"] as? PrimaryButtonStyleProfile
        let factory : ConfigurationFactory<UIButton> = { button in
            guard let buttonStyle = buttonStyle else { return }
            (button as! PrimaryButton).setBackgroundColor(backgroundColor: buttonStyle.buttonColor, shadowColor: buttonStyle.shadowColor)
        }
        return factory
    }
    
    var denyButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("BUTTON_DENY")
    }
    
    
}

