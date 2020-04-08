//
//  SwipeModalConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 19/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject

class SwipeModalConfigurator : SwipeModalConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var upArrowAssetProfile : AssetProfile = {
        return resolver.resolve(AssetProfile.self, name: "up_arrow")!
    }()
    
    var arrowImageFactory: ConfigurationFactory<UIImageView> {
        return upArrowAssetProfile.getAssetConfigurationFactory()
    }
}
