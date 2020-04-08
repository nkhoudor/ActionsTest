//
//  CountryPickerConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 01/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject

class CountryPickerConfigurator : CountryPickerConfiguratorProtocol {
    var textFieldMaxLength: Int = 0
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "COUNTRY_PICKER")!
    }()
    
    lazy var closeConfigurationFactory: ConfigurationFactory<UIButton> = {
        return screenProfile.getAssetConfigurationFactory("CLOSE")
    }()
    
    var backgroundColor: UIColor = .clear
    
    var textFieldFactory: Factory<UITextField> {
        return screenProfile.getTextFieldFactory("COUNTRY_TEXT_FIELD")
    }
    
    var underlineColor: UIColor = UIColor.Theme.gray5
    
    var cancelButtonFactory: Factory<UIButton> {
        return {[weak self] in
            let b = UIButton()
            self?.closeConfigurationFactory(b)
            return b
        }
    }
    
    var serviceUnavailableLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("SERVICE_UNAVAILABLE")
    }
    
    var countryNameLabelConfigurationFactory: ConfigurationFactory<UILabel> {
        return screenProfile.getLabelConfigurationFactory("COUNTRY_NAME_LABEL")
    }
}
