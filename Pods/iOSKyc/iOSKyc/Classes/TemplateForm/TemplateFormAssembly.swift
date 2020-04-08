//
//  TemplateFormAssembly.swift
//  iOSKyc
//
//  Created by Nik on 20/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews

extension ObjectScope {
    static let templateForm = ObjectScope(storageFactory: PermanentStorage.init)
}
class TemplateFormAssembly: Assembly {
    
    private func getFactory(resolver: Resolver, config: TemplateFormConfig) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let navigator = resolver.resolve(StateNavigatorProtocol.self)!
            let tfRouter = resolver.resolve(TemplateFormRouterProtocol.self)!
            let configurator = resolver.resolve(TemplateFormConfiguratorProtocol.self)!
            let overlayVC = OverlayVC()
            
            let mainVCFactory = { () -> UIViewController in
                return TemplateFormVC.createInstance(presenter: TemplateFormPresenter(interactor: TemplateFormInteractor(config: config), router: tfRouter, configurator: configurator))
            }
            
            let router = OverlayRouter()
            router.back = { [weak navigator] in
                navigator?.back()
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: router, configurator: TemplateFormOverlayConfigurator(mainVCFactory: mainVCFactory))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        container.register(Factory<UIViewController>.self, name: TemplateFormAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "TemplateFormFactory"
}
