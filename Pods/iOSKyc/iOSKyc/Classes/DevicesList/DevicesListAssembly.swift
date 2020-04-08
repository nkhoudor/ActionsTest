//
//  DevicesListAssembly.swift
//  iOSKyc
//
//  Created by Nik on 27/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycSDK
import iOSKycViews
import iOSCoreSDK

class DevicesListAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let flowService = resolver.resolve(IFlowService.self)!
            let sdk = resolver.resolve(ISDKCore.self)!
            let screenStateService = resolver.resolve(ScreenStateService.self)!
            let storage = resolver.resolve(IKycStorage.self)!
            //let stateService = resolver.resolve(ScreenStateService.self)!
            let navigator = resolver.resolve(StateNavigatorProtocol.self)!
            
            let overlayVC = OverlayVC()
            
            let screenProfile = resolver.resolve(ScreenProfile.self, name: "DEVICES_LIST")!
            let prohibitedColorProfile = resolver.resolve(ColorProfile.self, name: "primaryColor5")!
            let upArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "up_arrow")!
            let backArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "back_arrow")!

            let mainVCFactory = { () -> UIViewController in
                let router = DevicesListRouter()
                router.recover = {
                    navigator.state.accept(.CHAT)
                }
                
                return DevicesListVC.createInstance(presenter: DevicesListPresenter(interactor: KYCDevicesListInteractor(flowService: flowService, sdk: sdk, screenStateService: screenStateService, storage: storage), router: router, configurator: DevicesListConfigurator(screenProfile: screenProfile, prohibitedColorProfile: prohibitedColorProfile)))
            }
            
            let router = OverlayRouter()
            router.back = { [weak navigator] in
                navigator?.state.accept(.START_SCREEN)
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: router, configurator: DevicesListOverlayConfigurator(mainVCFactory: mainVCFactory, screenProfile: screenProfile, upArrowAssetProfile: upArrowAssetProfile, backArrowAssetProfile: backArrowAssetProfile))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: DevicesListAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "DevicesListFactory"
}
