//
//  EmailFormAssembly.swift
//  iOSKyc
//
//  Created by Nik on 29/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews

class EmailFormAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let navigator = resolver.resolve(StateNavigatorProtocol.self)!
            let overlayVC = OverlayVC()
            
            let emailConfigurator = resolver.resolve(EmailFormConfiguratorProtocol.self)!
            let emailRouter = resolver.resolve(EmailFormRouterProtocol.self)!
            
            let interactor = resolver.resolve(EmailFormInteractorProtocol.self) ?? EmailFormInteractor()
            
            let mainVCFactory = { () -> UIViewController in
                return EmailFormVC.createInstance(presenter: EmailFormPresenter(interactor: interactor, router: emailRouter, configurator: emailConfigurator))
            }
            
            let router = OverlayRouter()
            router.back = {
                navigator.back()
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: router, configurator: EmailFormOverlayConfigurator(mainVCFactory: mainVCFactory))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: EmailFormAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "EmailFormFactory"
}
