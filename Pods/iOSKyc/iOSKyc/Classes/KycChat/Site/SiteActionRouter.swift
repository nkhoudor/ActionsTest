//
//  SiteActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 13/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration
import iOSBaseViews
import iOSKycSDK
import RxSwift
import iOSKycViews

class SiteActionRouter : ChatActionRouterProtocol {
    
    let screenProfile: ScreenProfile
    
    init(screenProfile: ScreenProfile) {
        self.screenProfile = screenProfile
    }
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    func firstButton() {
        let urlStr = screenProfile.getLocalizedText("BUTTON_SITE_URL")
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func secondButton() {}
}

