//
//  ServicesAssembly.swift
//  iOSKyc
//
//  Created by Nik on 13/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import iOSKycSDK
import iOSCoreSDK

var kycServer : String? {
    get {
        UserDefaults.standard.string(forKey: "kycServer")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "kycServer")
    }
}

class ServicesAssembly: Assembly {
    private func createSDKCore(with resolver: Resolver) -> ISDKCore {
        let storage = resolver.resolve(IKycStorage.self)!
        let sdk = SDKCore(storage: storage)
        
        let connectionProfile = resolver.resolve(ConnectionProfile.self)!
        
        if connectionProfile.kyc != kycServer {
            storage.clear()
        }
        
        kycServer = connectionProfile.kyc
        sdk.configure(server: connectionProfile.kyc, config: connectionProfile.config)
        return sdk
    }
    
    func assemble(container: Container) {
        container.autoregister(IKycStorage.self, initializer: Storage.init).inObjectScope(.container)
        container.register(ISDKCore.self, factory: createSDKCore).inObjectScope(.container)
        container.autoregister(IFlowService.self, initializer: FlowService.init).inObjectScope(.container)
        container.autoregister(DeviceAuthService.self, initializer: DeviceAuthService.init).inObjectScope(.container)
    }
}
