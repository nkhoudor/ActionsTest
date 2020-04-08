//
//  SideBarMaskLogoutConfigurator.swift
//  iOSBaseViews_Example
//
//  Created by Nik on 09/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import iOSBaseViews
import Swinject

class SideBarMaskLogoutConfigurator : SideBarMaskLogoutConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "SIDEBAR_MASK_LOGOUT")!
    }()
    
    lazy var switchStyleProfile: SwitchStyleProfile = {
        return resolver.resolve(SwitchStyleProfile.self, name: "defaultSwitch")!
    }()
    
    var backgroundColor: UIColor = .clear
    
    var contentViewBackgroundColor: UIColor = UIColor.Theme.gray3
    
    var contentViewMargin: CGFloat = 16
    
    var contentViewRadius: CGFloat = 4
    
    var maskSwitchFactory: Factory<UISwitch> {
        return switchStyleProfile.factory
    }
    
    var imageBackgroundColor: UIColor = UIColor.Theme.gray40
    
    var maskImageFactory: ConfigurationFactory<UIImageView> {
        return screenProfile.getAssetConfigurationFactory("MASK")
    }
    
    var logoutImageFactory: ConfigurationFactory<UIImageView>? {
        return screenProfile.getAssetConfigurationFactory("LOGOUT")
    }
    
    var maskLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("MASK_TEXT")
    }
    
    var logoutLabelFactory: Factory<UILabel>? {
        return screenProfile.getLabelFactory("LOGOUT_TEXT")
    }
}
