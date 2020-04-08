//
//  TemplateFormOverlayConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 20/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import iOSBaseViews
import iOSKycViews
import Swinject

class TemplateFormOverlayConfigurator : OverlayConfiguratorProtocol {
    let mainVCFactory : Factory<UIViewController>
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "ADDRESS_FORM")!
    }()
    
    lazy var upArrowAssetProfile : AssetProfile = {
        return resolver.resolve(AssetProfile.self, name: "up_arrow")!
    }()
    
    lazy var backArrowAssetProfile : AssetProfile = {
        return resolver.resolve(AssetProfile.self, name: "back_arrow")!
    }()
    
    init(mainVCFactory : @escaping Factory<UIViewController>) {
        self.mainVCFactory = mainVCFactory
    }
    
    var sideBarFactory: Factory<UIViewController> {
        {() -> UIViewController in
            return SideBarScrollStackVC.createInstance(presenter: ScrollStackPresenter(interactor: ScrollStackInteractor(), router: ScrollStackRouter(), configurator: SideBarConfigurator()))
        }
    }
    
    var mainFactory: Factory<MainHolderConfiguratorProtocol> {        
        return MainHolderConfigurator.getFactory(backgroundColor: .white, contentViewRadius: 16, backImageFactory: backArrowAssetProfile.getAssetConfigurationFactory(), topArrowImageFactory: upArrowAssetProfile.getAssetConfigurationFactory(), closeImageFactory: nil, nameLabelFactory: screenProfile.getLabelFactory("HEADER"), mainVCFactory: mainVCFactory)
    }
}

