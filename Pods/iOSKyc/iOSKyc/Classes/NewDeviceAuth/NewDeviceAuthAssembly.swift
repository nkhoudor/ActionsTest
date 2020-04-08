//
//  NewDeviceAuthAssembly.swift
//  iOSKyc
//
//  Created by Nik on 14/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews
import iOSKycSDK

public typealias InputFactory<ModuleInput, Instance> = (ModuleInput) -> Instance

class NewDeviceAuthAssembly: Assembly {
    
    private func getFactory(resolver: Resolver, data: AuthorizationDeviceNewData) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let overlayVC = OverlayVC()
            
            let interactor = KYCNewDeviceAuthInteractor(flowService: resolver.resolve(IFlowService.self)!, stateNavigator: resolver.resolve(StateNavigatorProtocol.self)!, authRequestId: data.id ?? "")
            
            let mainVCFactory = { () -> UIViewController in
                return NewDeviceAuthVC.createInstance(presenter: NewDeviceAuthPresenter(interactor: interactor, router: NewDeviceAuthRouter(), configurator: NewDeviceAuthConfigurator(deviceInfo: data.deviceInfo!)))
            }
            
            let router = OverlayRouter()
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: router, configurator: NewDeviceAuthOverlayConfigurator(mainVCFactory: mainVCFactory))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: NewDeviceAuthAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "NewDeviceAuthFactory"
}
