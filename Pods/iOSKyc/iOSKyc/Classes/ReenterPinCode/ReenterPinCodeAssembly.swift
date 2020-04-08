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

class ReenterPinCodeAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let navigator = resolver.resolve(StateNavigatorProtocol.self)!
            let viewModel = resolver.resolve(CreatePinViewModel.self)!
            let storage = resolver.resolve(IKycStorage.self)!
            let overlayVC = OverlayVC()
            
            let screenProfile = resolver.resolve(ScreenProfile.self, name: "REENTER_PIN_CODE")!
            let pinCodeDotStyleProfile = resolver.resolve(PinCodeDotStyleProfile.self, name: "basicPinCodeDot")!
            let pinCodeDigitButtonStyleProfile = resolver.resolve(PinCodeDigitButtonStyleProfile.self, name: "basicPinCodeDigitButton")!
            let upArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "up_arrow")!
            let backArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "back_arrow")!
            
            let mainVCFactory = { () -> UIViewController in
                let router = PinCodeRouter()
                
                router.finish = { [navigator, storage] in
                    if storage.isRecoveryMode {
                        navigator.state.accept(.DEVICE_LIST)
                    } else {
                        navigator.state.accept(.CHAT)
                    }
                }
                return PinCodeVC.createInstance(presenter: PinCodePresenter(interactor: KYCReenterPinCodeInteractor(viewModel: viewModel), router: router, configurator: ReenterPinCodeConfigurator(pinCodeDotStyleProfile: pinCodeDotStyleProfile, pinCodeDigitButtonStyleProfile: pinCodeDigitButtonStyleProfile, screenProfile: screenProfile)))
            }
            
            let router = OverlayRouter()
            router.back = { [weak navigator] in
                navigator?.state.accept(.CREATE_PIN_CODE)
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: router, configurator: ReenterPinCodeOverlayConfigurator(mainVCFactory: mainVCFactory, screenProfile: screenProfile, upArrowAssetProfile: upArrowAssetProfile, backArrowAssetProfile: backArrowAssetProfile))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: ReenterPinCodeAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "ReenterPinCodeFactory"
}
