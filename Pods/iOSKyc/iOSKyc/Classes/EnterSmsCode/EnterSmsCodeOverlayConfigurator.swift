//
//  PhoneRegistrationOverlay.swift
//  iOSKycViews_Example
//
//  Created by Nik on 13/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import iOSBaseViews
import iOSKycViews

class EnterSmsCodeOverlayConfigurator : OverlayConfiguratorProtocol {
    let mainVCFactory : Factory<UIViewController>
    let screenProfile: ScreenProfile
    let upArrowAssetProfile: AssetProfile
    let backArrowAssetProfile: AssetProfile
    
    init(mainVCFactory : @escaping Factory<UIViewController>, screenProfile: ScreenProfile, upArrowAssetProfile: AssetProfile, backArrowAssetProfile: AssetProfile) {
        self.mainVCFactory = mainVCFactory
        self.screenProfile = screenProfile
        self.upArrowAssetProfile = upArrowAssetProfile
        self.backArrowAssetProfile = backArrowAssetProfile
    }
    
    var sideBarFactory: Factory<UIViewController> {
        {() -> UIViewController in
            return SideBarScrollStackVC.createInstance(presenter: ScrollStackPresenter(interactor: ScrollStackInteractor(), router: ScrollStackRouter(), configurator: SideBarConfigurator()))
        }
    }
    
    var mainFactory: Factory<MainHolderConfiguratorProtocol> {
        
        let nameLabelFactory = screenProfile.getLabelFactory("HEADER")
        
        return MainHolderConfigurator.getFactory(backgroundColor: .white, contentViewRadius: 16, backImageFactory: backArrowAssetProfile.getAssetConfigurationFactory(), topArrowImageFactory: upArrowAssetProfile.getAssetConfigurationFactory(), closeImageFactory: nil, nameLabelFactory: nameLabelFactory, mainVCFactory: mainVCFactory)
    }
}
