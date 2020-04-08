//
//  PrivacyPolicyOverlayConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 28/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import iOSBaseViews
import iOSKycViews
import Swinject

class PrivacyPolicyOverlayConfigurator : OverlayConfiguratorProtocol {
    let mainVCFactory : Factory<UIViewController>
    let screenProfile: ScreenProfile
    
    init(mainVCFactory : @escaping Factory<UIViewController>, screenProfile: ScreenProfile) {
        self.mainVCFactory = mainVCFactory
        self.screenProfile = screenProfile
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
        
        let nameLabelFactory = screenProfile.getLabelFactory("HEADER")
        
        return MainHolderConfigurator.getFactory(backgroundColor: .white, contentViewRadius: 16, backImageFactory: nil, topArrowImageFactory: upArrowAssetProfile.getAssetConfigurationFactory(), closeImageFactory: nil, nameLabelFactory: nameLabelFactory, headerLabelFactory: (labelFactory: screenProfile.getLabelFactory("HEADER"), backgroundColor: .white, underlineColor: UIColor.Theme.gray40), mainVCFactory: mainVCFactory)
    }
}
