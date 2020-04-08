//
//  DueDiligenceActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 24/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews

class DueDiligenceActionRouter : ChatActionRouterProtocol {
    let chatFlowService : ChatFlowService
    let viewModel : DueDiligenceViewModel
    
    init(chatFlowService : ChatFlowService, viewModel : DueDiligenceViewModel) {
        self.chatFlowService = chatFlowService
        self.viewModel = viewModel
    }
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    var swipeVC : UIViewController?
    
    func firstButton() {
        let container = resolver as! Container
        container.resetObjectScope(.templateForm)
        container.register(TemplateFormRouterProtocol.self, factory: { resolver -> TemplateFormRouterProtocol in
            return DueDiligenceRouter(navigator: resolver.resolve(StateNavigatorProtocol.self)!, chatFlowService: resolver.resolve(ChatFlowService.self)!)
        }).inObjectScope(.templateForm)
        
        container.register(TemplateFormConfiguratorProtocol.self, factory: { resolver -> TemplateFormConfiguratorProtocol in
            return DueDiligenceTemplateFormConfigurator()
        }).inObjectScope(.templateForm)
        
        resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.TEMPLATE_FORM(config: viewModel.form))
    }
    
    func secondButton() {}
}
