//
//  PhoneRegistrationAssembly.swift
//  iOSKyc
//
//  Created by Nik on 13/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import Swinject
import iOSBaseViews
import iOSKycViews
import iOSKycSDK

class CreatePinCodeAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let flowService = resolver.resolve(IFlowService.self)!
            let viewModel = resolver.resolve(CreatePinViewModel.self)!
            let navigator = resolver.resolve(StateNavigatorProtocol.self)!
            let overlayVC = OverlayVC()
            
            let screenProfile = resolver.resolve(ScreenProfile.self, name: "CREATE_PIN_CODE")!
            let pinCodeDotStyleProfile = resolver.resolve(PinCodeDotStyleProfile.self, name: "basicPinCodeDot")!
            let pinCodeDigitButtonStyleProfile = resolver.resolve(PinCodeDigitButtonStyleProfile.self, name: "basicPinCodeDigitButton")!
            let upArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "up_arrow")!
            let backArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "back_arrow")!
            
            let mainVCFactory = { () -> UIViewController in
                let router = PinCodeRouter()
                
                router.finish = { [weak navigator] in
                    navigator?.state.accept(.REENTER_PIN_CODE)
                }
                
                return PinCodeVC.createInstance(presenter: PinCodePresenter(interactor: KYCCreatePinCodeInteractor(viewModel: viewModel), router: router, configurator: CreatePinCodeConfigurator(pinCodeDotStyleProfile: pinCodeDotStyleProfile, pinCodeDigitButtonStyleProfile: pinCodeDigitButtonStyleProfile, screenProfile: screenProfile)))
            }
            
            let router = OverlayRouter()
            router.back = {
                flowService.state.accept(.REGISTRATION_PHONE_START)
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: router, configurator: CreatePinCodeOverlayConfigurator(mainVCFactory: mainVCFactory, screenProfile: screenProfile, upArrowAssetProfile: upArrowAssetProfile, backArrowAssetProfile: backArrowAssetProfile))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.autoregister(CreatePinViewModel.self, initializer: CreatePinViewModel.init).inObjectScope(.container)
        container.register(Factory<UIViewController>.self, name: CreatePinCodeAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "CreatePinCodeFactory"
}
