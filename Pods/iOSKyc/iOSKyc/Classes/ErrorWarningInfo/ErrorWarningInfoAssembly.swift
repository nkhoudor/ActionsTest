//
//  ErrorWarningInfoAssembly.swift
//  iOSKyc
//
//  Created by Nik on 11/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews
import iOSKycSDK

class ErrorWarningInfoAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let overlayVC = OverlayVC()
            let configurator : ErrorWarningInfoConfiguratorProtocol = resolver.resolve(ErrorWarningInfoConfiguratorProtocol.self)!
            
            let mainVCFactory = { () -> UIViewController in
                return ErrorWarningInfoVC.createInstance(presenter: ErrorWarningInfoPresenter(interactor: ErrorWarningInfoInteractor(), router: ErrorWarningInfoRouter(), configurator: configurator))
            }
            
            let router = OverlayRouter()
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: router, configurator: ErrorWarningInfoOverlayConfigurator(mainVCFactory: mainVCFactory))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: ErrorWarningInfoAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "ErrorWarningInfoFactory"
}

extension ErrorWarningInfoConfigurator {
    static func getComeLater() -> ErrorWarningInfoConfiguratorProtocol {
        return ErrorWarningInfoConfigurator(screenId: "COME_BACK_LATER")
    }
    
    static func getHighRisk() -> ErrorWarningInfoConfiguratorProtocol {
        return ErrorWarningInfoConfigurator(screenId: "REGISTRATION_REJECTED")
    }
    
    static func getWrongCountry() -> ErrorWarningInfoConfiguratorProtocol {
        return ErrorWarningInfoConfigurator(screenId: "WRONG_COUNTRY")
    }
    
    static func getWrongAge() -> ErrorWarningInfoConfiguratorProtocol {
        return ErrorWarningInfoConfigurator(screenId: "WRONG_AGE")
    }
    
    static func getKYCCompleted() -> ErrorWarningInfoConfiguratorProtocol {
        return ErrorWarningInfoConfigurator(screenId: "KYC_COMPLETED")
    }
}
