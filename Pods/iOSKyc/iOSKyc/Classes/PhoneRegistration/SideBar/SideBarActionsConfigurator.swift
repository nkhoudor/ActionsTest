//
//  SideBarActionsConfigurator.swift
//  iOSBaseViews_Example
//
//  Created by Nik on 09/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import iOSBaseViews
import Swinject

class SideBarActionsConfigurator : SideBarActionsSetConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "SIDEBAR_ACTIONS")!
    }()
    
    var backgroundColor: UIColor = .clear
    
    var actionIconViewRadius: CGFloat = 4
    
    var actionIconBackgroundColor: UIColor = UIColor.Theme.gray5
    
    var actionIconFactories: [ConfigurationFactory<UIImageView>] {
        let infoFactory : ConfigurationFactory<UIImageView> = screenProfile.getAssetConfigurationFactory("INFO")
        let chatFactory : ConfigurationFactory<UIImageView> = screenProfile.getAssetConfigurationFactory("CHAT")
        
        return [infoFactory, chatFactory]
    }
}
