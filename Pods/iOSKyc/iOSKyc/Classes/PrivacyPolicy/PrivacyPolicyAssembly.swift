//
//  PrivacyPolicyAssembly.swift
//  iOSKyc
//
//  Created by Nik on 28/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import Swinject
import iOSBaseViews
import iOSKycViews
import iOSKycSDK

class PrivacyPolicyAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let navigator = resolver.resolve(StateNavigatorProtocol.self)!
            var storage = resolver.resolve(IKycStorage.self)!
            let overlayVC = OverlayVC()
            
            let router = PrivacyPolicyRouter()
            router.confirm = { [weak navigator] in
                navigator?.state.accept(.START_SCREEN)
            }
            
            router.deny = { [weak navigator] in
                navigator?.state.accept(.CLOSE_APP)
            }
            
            let interactor = PrivacyPolicyInteractor()
            
            interactor.setPPConfirmation = { value in
                storage.isPPConfirmed = value
            }
            let screenProfile = resolver.resolve(ScreenProfile.self, name: "PRIVACY_POLICY")!
            
            let mainVCFactory = { () -> UIViewController in
                return PrivacyPolicyVC.createInstance(presenter: PrivacyPolicyPresenter(interactor: interactor, router: router, configurator: PrivacyPolicyConfigurator(screenProfile: screenProfile)))
            }
            
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: OverlayRouter(), configurator: PrivacyPolicyOverlayConfigurator(mainVCFactory: mainVCFactory, screenProfile: screenProfile))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: PrivacyPolicyAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "PrivacyPolicyFactory"
}
