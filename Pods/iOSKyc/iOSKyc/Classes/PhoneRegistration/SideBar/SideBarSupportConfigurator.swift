//
//  SideBarSupportConfigurator.swift
//  iOSBaseViews_Example
//
//  Created by Nik on 09/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import iOSBaseViews
import Swinject

class SideBarSupportConfigurator : SideBarSupportConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "SIDEBAR_SUPPORT")!
    }()
    
    var backgroundColor: UIColor = .clear
    
    var contentViewBackgroundColor: UIColor = UIColor.Theme.gray3
    
    var contentViewMargin: CGFloat = 16
    
    var contentViewRadius: CGFloat = 4
    
    var imageBackgroundColor: UIColor = UIColor.Theme.gray40
    
    var supportImageFactory: ConfigurationFactory<UIImageView> {
        return screenProfile.getAssetConfigurationFactory("SUPPORT")
    }
    
    var supportLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("SUPPORT_TEXT")
    }
}
