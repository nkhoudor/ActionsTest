//
//  UtilityBillAddressActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 22/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews

class UtilityBillAddressActionRouter : ChatActionRouterProtocol {
    var chatFlowService : ChatFlowService!
    
    init(chatFlowService : ChatFlowService) {
        self.chatFlowService = chatFlowService
    }
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    var swipeVC : UIViewController?
    
    func firstButton() {
        let container = resolver as! Container
        container.resetObjectScope(.templateForm)
        container.register(TemplateFormRouterProtocol.self, factory: { resolver -> TemplateFormRouterProtocol in
            return HomeAddressRouter(navigator: resolver.resolve(StateNavigatorProtocol.self)!, chatFlowService: resolver.resolve(ChatFlowService.self)!)
        }).inObjectScope(.templateForm)
        
        container.register(TemplateFormConfiguratorProtocol.self, factory: { resolver -> TemplateFormConfiguratorProtocol in
            return TemplateFormConfigurator()
        }).inObjectScope(.templateForm)
        
        resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.TEMPLATE_FORM(config: resolver.resolve(AddressViewModel.self, name: ChatAssembly.homeAddress)!.form))
    }
    
    func secondButton() {}
}
