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

class EnterSmsCodeAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let flowService = resolver.resolve(IFlowService.self)!
            let viewModel = resolver.resolve(PhoneRegistrationViewModel.self)!
            let overlayVC = OverlayVC()
            
            let screenProfile = resolver.resolve(ScreenProfile.self, name: "PHONE_CONFIRMATION")!
            let numTextFieldStyleProfile = resolver.resolve(NumTextFieldStyleProfile.self, name: "basicNumTextField")!
            let mainColorProfile = resolver.resolve(ColorProfile.self, name: "primaryButton")!
            let upArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "up_arrow")!
            let backArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "back_arrow")!
            
            let codeRouter = EnterCodeRouter()
            
            codeRouter.errorFinish = {
                flowService.state.accept(.REGISTRATION_PHONE_START)
            }
            
            let mainVCFactory = { () -> UIViewController in
                EnterCodeVC.createInstance(presenter: EnterCodePresenter(interactor: KYCEnterSmsCodeInteractor(flowService: flowService), router: codeRouter, configurator: EnterSmsCodeConfigurator(viewModel: viewModel, screenProfile: screenProfile, numTextFieldStyleProfile: numTextFieldStyleProfile, mainColorProfile: mainColorProfile)))
            }
            
            let router = OverlayRouter()
            router.back = {
                flowService.state.accept(.REGISTRATION_PHONE_START)
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: router, configurator: EnterSmsCodeOverlayConfigurator(mainVCFactory: mainVCFactory, screenProfile: screenProfile, upArrowAssetProfile: upArrowAssetProfile, backArrowAssetProfile: backArrowAssetProfile))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: EnterSmsCodeAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "EnterSmsCodeFactory"
}
