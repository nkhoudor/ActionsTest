//
//  ErrorWarningInfoOverlayConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 11/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews
import Swinject

class ErrorWarningInfoOverlayConfigurator : OverlayConfiguratorProtocol {
    var mainVCFactory : Factory<UIViewController>!
    
    init(mainVCFactory : @escaping Factory<UIViewController>) {
        self.mainVCFactory = mainVCFactory
    }
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var upArrowAssetProfile : AssetProfile = {
        return resolver.resolve(AssetProfile.self, name: "up_arrow")!
    }()
    
    var sideBarFactory: Factory<UIViewController> {
        {() -> UIViewController in
            return SideBarScrollStackVC.createInstance(presenter: ScrollStackPresenter(interactor: ScrollStackInteractor(), router: ScrollStackRouter(), configurator: SideBarConfigurator()))
        }
    }
    
    var mainFactory: Factory<MainHolderConfiguratorProtocol> {
        
        return MainHolderConfigurator.getFactory(backgroundColor: .white, contentViewRadius: 16, backImageFactory: nil, topArrowImageFactory: upArrowAssetProfile.getAssetConfigurationFactory(), closeImageFactory: nil, nameLabelFactory: nil, mainVCFactory: mainVCFactory)
    }
}
