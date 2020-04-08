//
//  EmailFormOverlayConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 29/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import iOSBaseViews
import iOSKycViews
import Swinject

class EmailFormOverlayConfigurator : OverlayConfiguratorProtocol {
    let mainVCFactory : Factory<UIViewController>
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
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
        
        let nameLabelFactory = UILabel.getFactory(font: UIFont.Theme.boldFont, textColor: UIColor.Theme.mainBlackColor, text: "Enter your Email")
        
        return MainHolderConfigurator.getFactory(backgroundColor: .white, contentViewRadius: 16, backImageFactory: backArrowAssetProfile.getAssetConfigurationFactory(), topArrowImageFactory: upArrowAssetProfile.getAssetConfigurationFactory(), closeImageFactory: nil, nameLabelFactory: nameLabelFactory, mainVCFactory: mainVCFactory)
    }
}

