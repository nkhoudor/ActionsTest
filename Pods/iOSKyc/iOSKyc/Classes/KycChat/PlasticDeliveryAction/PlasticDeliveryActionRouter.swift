//
//  PlasticDeliveryActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 23/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import Swinject
import iOSKycViews

class PlasticDeliveryActionRouter : ChatActionRouterProtocol {
    let chatFlowService : ChatFlowService
    let viewModel : AddressViewModel
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    init(chatFlowService : ChatFlowService, viewModel : AddressViewModel) {
        self.chatFlowService = chatFlowService
        self.viewModel = viewModel
    }
    
    func firstButton() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let address = viewModel.form
        alert.addAction(UIAlertAction(title: address.stringPresentation, style: . default, handler: { [weak self] _ in
            self?.chatFlowService.messagesChange.onNext([.delete(1)])
            self?.chatFlowService.state.accept(.PLASTIC_DELIVERY_ADDRESS_INFO(address))
        }))
        
        alert.addAction(UIAlertAction(title: "New address", style: . default, handler: { [weak self] _ in
            guard let container = self?.resolver as? Container, let form = self?.resolver.resolve(AddressViewModel.self, name: ChatAssembly.deliveryAddress)?.form else { return }
            
            container.resetObjectScope(.templateForm)
            container.register(TemplateFormRouterProtocol.self, factory: { resolver -> TemplateFormRouterProtocol in
                return DeliveryAddressRouter(navigator: resolver.resolve(StateNavigatorProtocol.self)!, chatFlowService: resolver.resolve(ChatFlowService.self)!)
            }).inObjectScope(.templateForm)
            
            container.register(TemplateFormConfiguratorProtocol.self, factory: { resolver -> TemplateFormConfiguratorProtocol in
                return TemplateFormConfigurator()
            }).inObjectScope(.templateForm)
        self?.resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.TEMPLATE_FORM(config: form))
        }))
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func secondButton() {}
}
