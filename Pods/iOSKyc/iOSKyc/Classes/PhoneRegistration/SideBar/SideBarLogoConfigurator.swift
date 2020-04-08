//
//  SideBarLogoConfigurator.swift
//  iOSBaseViews_Example
//
//  Created by Nik on 09/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import iOSBaseViews
import Swinject

class SideBarLogoConfigurator : SideBarLogoConfiguratorProtocol {
    var backgroundColor: UIColor = .clear
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    var logoAssetProfile : AssetProfile?
    
    init() {
        logoAssetProfile = resolver.resolve(AssetProfile.self, name: "logo")
    }
    
    var logoImageFactory: ConfigurationFactory<UIImageView> {
        if logoAssetProfile != nil {
            return logoAssetProfile!.getAssetConfigurationFactory()
        }
        return { _ in }
    }
}
