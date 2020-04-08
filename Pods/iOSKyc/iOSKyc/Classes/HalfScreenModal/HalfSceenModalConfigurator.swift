//
//  HalfSceenModalConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 30/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject

class HalfSceenModalConfigurator : HalfSceenModalConfiguratorProtocol {
    
    var titleLabelFactory: Factory<UILabel>?
    var titleUnderlineColor: UIColor?
    var titleUnderlineFactory: Factory<UIView>?
    
    var halfScreenModalStyleProfile : HalfScreenModalStyleProfile?
    
    var coverRatio: CGFloat {
        return halfScreenModalStyleProfile?.coverRatio ??  533.0 / 811.0
    }
    
    var backgroundColor: UIColor {
        return halfScreenModalStyleProfile?.backgroundColor ?? .white
    }
    
    var coverColor: UIColor {
        return halfScreenModalStyleProfile?.coverColor ?? UIColor.Theme.gray10
    }
    
    var cornerRadius: CGFloat {
        return halfScreenModalStyleProfile?.cornerRadius ?? 15.0
    }
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var upArrowAssetProfile : AssetProfile = {
        return resolver.resolve(AssetProfile.self, name: "down_arrow")!
    }()
    
    var topArrowImageViewFactory: ConfigurationFactory<UIImageView> {
        if halfScreenModalStyleProfile != nil {
            return halfScreenModalStyleProfile!.topArrowAssetProfile.getAssetConfigurationFactory()
        }
        return upArrowAssetProfile.getAssetConfigurationFactory()
    }
    
    init(titleLabelFactory: Factory<UILabel>? = nil, titleUnderlineColor: UIColor? = nil, titleUnderlineFactory: Factory<UIView>? = nil, halfScreenModalStyleProfile : HalfScreenModalStyleProfile? = nil) {
        self.titleLabelFactory = titleLabelFactory
        self.titleUnderlineColor = titleUnderlineColor
        self.titleUnderlineFactory = titleUnderlineFactory
        self.halfScreenModalStyleProfile = halfScreenModalStyleProfile
    }
}
