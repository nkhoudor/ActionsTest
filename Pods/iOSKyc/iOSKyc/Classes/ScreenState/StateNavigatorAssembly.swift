//
//  StateNavigatorAssembly.swift
//  iOSKyc
//
//  Created by Nik on 14/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import iOSBaseViews
import iOSKycSDK
import iOSCoreSDK

class StateNavigatorAssembly : Assembly {
    
    private func getScreenStateServiceFactory(resolver: Resolver) -> ScreenStateService {
        let sdk = resolver.resolve(ISDKCore.self)!
        let flowService = resolver.resolve(IFlowService.self)!
        let storage = resolver.resolve(IKycStorage.self)!
        let navigator = resolver.resolve(StateNavigatorProtocol.self)!
        let finishCallback = KYCModulesAssembly.kycFinishCallback

        return ScreenStateService(sdk: sdk, flowService: flowService, storage: storage, navigator: navigator, finishCallback: finishCallback)
    }
    
    func assemble(container: Container) {
        container.register(ScreenStateService.self, factory: getScreenStateServiceFactory).inObjectScope(.container)
        container.autoregister(UINavigationController.self, initializer: StateNavigator.init).implements(StateNavigatorProtocol.self).inObjectScope(.container)
    }
}

