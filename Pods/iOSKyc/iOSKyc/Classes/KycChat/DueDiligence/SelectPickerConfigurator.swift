//
//  SelectPickerConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 24/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject
import iOSKycViews

class SelectPickerConfigurator: SelectPickerConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "SELECT_PICKER")!
    }()
    
    var backgroundColor: UIColor = .clear
    
    var valueLabelConfigurationFactory: ConfigurationFactory<UILabel> {
        return screenProfile.getLabelConfigurationFactory("VALUE_LABEL")
    }
}
