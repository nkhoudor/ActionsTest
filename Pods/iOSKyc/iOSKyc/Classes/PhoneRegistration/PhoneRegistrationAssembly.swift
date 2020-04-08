//
//  PhoneRegistrationAssembly.swift
//  iOSKyc
//
//  Created by Nik on 13/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import iOSBaseViews
import iOSKycViews
import iOSKycSDK

class PhoneRegistrationAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let flowService = resolver.resolve(IFlowService.self)!
            let overlayVC = OverlayVC()
            
            let viewModel = resolver.resolve(PhoneRegistrationViewModel.self)!
            let navigator = resolver.resolve(StateNavigatorProtocol.self)!
            let screenProfile = resolver.resolve(ScreenProfile.self, name: "PHONE")!
            
            let upArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "up_arrow")!
            
            let mainVCFactory = { () -> UIViewController in
                let vc = PhoneRegistrationVC()
                
                let router = KYCPhoneRegistrationRouter()
                
                vc.presenter = PhoneRegistrationPresenter(interactor: KYCPhoneRegistrationInteractor(flowService: flowService, navigator: navigator, viewModel: viewModel), router: router, configurator: PhoneRegistrationConfigurator(screenProfile: screenProfile))
                
                return vc
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: OverlayRouter(), configurator: PhoneRegistrationOverlayConfigurator(mainVCFactory: mainVCFactory, screenProfile: screenProfile, upArrowAssetProfile: upArrowAssetProfile))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: PhoneRegistrationAssembly.registrationName, factory: getFactory)
        container.autoregister(PhoneRegistrationViewModel.self, initializer: PhoneRegistrationViewModel.init).inObjectScope(.container)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "PhoneRegistrationFactory"
}
