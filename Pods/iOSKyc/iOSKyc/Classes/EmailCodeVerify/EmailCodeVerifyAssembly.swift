//
//  EmailCodeVerifyAssembly.swift
//  iOSKyc
//
//  Created by Nik on 04/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews
import iOSKycSDK

class EmailCodeVerifyAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let flowService = resolver.resolve(IFlowService.self)!
            let chatFlowService = resolver.resolve(ChatFlowService.self)!
            let viewModel = resolver.resolve(ConnectEmailViewModel.self)!
            let stateNavigator = resolver.resolve(StateNavigatorProtocol.self)!
            let overlayVC = OverlayVC()
            
            let screenProfile = resolver.resolve(ScreenProfile.self, name: "EMAIL_CONFIRMATION")!
            let upArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "up_arrow")!
            let backArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "back_arrow")!
            
            let mainVCFactory = { () -> UIViewController in
                let router = EnterCodeRouter()
                router.finish = {
                    stateNavigator.state.accept(.CHAT)
                    chatFlowService.state.accept(.EMAIL_VERIFIED(viewModel.email, viewModel.code))
                }
                
                return EnterCodeVC.createInstance(presenter: EnterCodePresenter(interactor: EmailCodeVerifyInteractor(flowService: flowService, viewModel: viewModel), router: router, configurator: EmailCodeVerifyConfigurator(viewModel: viewModel)))
            }
            
            let router = OverlayRouter()
            router.back = {
                stateNavigator.back()
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: router, configurator: EmailCodeVerifyOverlayConfigurator(mainVCFactory: mainVCFactory, screenProfile: screenProfile, upArrowAssetProfile: upArrowAssetProfile, backArrowAssetProfile: backArrowAssetProfile))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: EmailCodeVerifyAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "EmailCodeVerifyFactory"
}
