//
//  ChatOverlayConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 15/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import iOSBaseViews
import iOSKycViews

class ChatOverlayConfigurator : OverlayConfiguratorProtocol {
    let mainVCFactory : Factory<UIViewController>
    let screenProfile: ScreenProfile
    let upArrowAssetProfile: AssetProfile
    let isRecovery: Bool
    
    init(mainVCFactory : @escaping Factory<UIViewController>, screenProfile: ScreenProfile, upArrowAssetProfile: AssetProfile, isRecovery: Bool) {
        self.mainVCFactory = mainVCFactory
        self.screenProfile = screenProfile
        self.upArrowAssetProfile = upArrowAssetProfile
        self.isRecovery = isRecovery
    }
    
    var sideBarFactory: Factory<UIViewController> {
        {() -> UIViewController in
            return SideBarScrollStackVC.createInstance(presenter: ScrollStackPresenter(interactor: ScrollStackInteractor(), router: ScrollStackRouter(), configurator: SideBarConfigurator()))
        }
    }
    
    var mainFactory: Factory<MainHolderConfiguratorProtocol> {
        
        let nameLabelFactory = isRecovery ? screenProfile.getLabelFactory("HEADER_RECOVERY") : screenProfile.getLabelFactory("HEADER")
        
        return MainHolderConfigurator.getFactory(backgroundColor: .white, contentViewRadius: 16, backImageFactory: nil, topArrowImageFactory: upArrowAssetProfile.getAssetConfigurationFactory(), closeImageFactory: nil, nameLabelFactory: nameLabelFactory, headerLabelFactory: (labelFactory: nameLabelFactory, backgroundColor: .clear, underlineColor: UIColor.Theme.gray5), mainVCFactory: mainVCFactory)
    }
}
