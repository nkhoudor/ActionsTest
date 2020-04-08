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

class CheckPinCodeAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let navigator = resolver.resolve(StateNavigatorProtocol.self)!
            let stateService = resolver.resolve(ScreenStateService.self)!
            let storage = resolver.resolve(IKycStorage.self)!
            let overlayVC = OverlayVC()
            
            let screenProfile = resolver.resolve(ScreenProfile.self, name: "CHECK_PIN_CODE")!
            let pinCodeDotStyleProfile = resolver.resolve(PinCodeDotStyleProfile.self, name: "basicPinCodeDot")!
            let pinCodeDigitButtonStyleProfile = resolver.resolve(PinCodeDigitButtonStyleProfile.self, name: "basicPinCodeDigitButton")!
            let upArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "up_arrow")!
            
            let mainVCFactory = { () -> UIViewController in
                let router = PinCodeRouter()
                
                router.finish = { [navigator, storage] in
                    stateService.pinCodeVerified()
                }
                return PinCodeVC.createInstance(presenter: PinCodePresenter(interactor: KYCCheckPinCodeInteractor(storage: storage), router: router, configurator: CheckPinCodeConfigurator(pinCodeDotStyleProfile: pinCodeDotStyleProfile, pinCodeDigitButtonStyleProfile: pinCodeDigitButtonStyleProfile, screenProfile: screenProfile)))
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: OverlayRouter(), configurator: CheckPinCodeOverlayConfigurator(mainVCFactory: mainVCFactory, screenProfile: screenProfile, upArrowAssetProfile: upArrowAssetProfile))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: CheckPinCodeAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "CheckPinCodeFactory"
}
