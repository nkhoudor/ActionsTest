//
//  ComeBackLaterGotItActionRouter.swift
//  FlagKit
//
//  Created by Admin on 23/03/2020.
//

import Swinject
import iOSBaseViews
import iOSKycViews

class ComeBackLaterGotItActionRouter : ChatActionRouterProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    func firstButton() {
        resolver.resolve(ScreenStateService.self)?.pinCodeVerified()
    }
    
    func secondButton() {
        
    }
}
