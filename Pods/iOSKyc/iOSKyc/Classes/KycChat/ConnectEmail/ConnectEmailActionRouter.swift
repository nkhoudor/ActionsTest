//
//  ConnectEmailActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 04/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration
import iOSBaseViews
import iOSKycSDK
import iOSKycViews

class ConnectEmailActionRouter : ChatActionRouterProtocol {
    let chatFlowService : ChatFlowService
    var storage : IKycStorage
    
    init(chatFlowService : ChatFlowService, storage : IKycStorage) {
        self.chatFlowService = chatFlowService
        self.storage = storage
    }
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    func firstButton() {
        chatFlowService.state.accept(.BOT_NEWS_DESCRIPTION)
        /*(resolver as? Container)!.register(EmailFormRouterProtocol.self, factory: { resolver in
            let router = EmailFormRouter()
            router.emailProvided = { email in
                resolver.resolve(ConnectEmailViewModel.self)?.email = email
                resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.EMAIL_VERIFICATION)
            }
            return router
        }).inObjectScope(.weak)
        
        let viewModel = resolver.resolve(ConnectEmailViewModel.self)!
        
        (resolver as? Container)!.register(EmailFormInteractorProtocol.self, factory: { resolver in
            return ConnectEmailFormInteractor(flowService: resolver.resolve(IFlowService.self)!, viewModel: viewModel, storage: resolver.resolve(IKycStorage.self)!)
        }).inObjectScope(.weak)
        
        (resolver as? Container)!.register(EmailFormConfiguratorProtocol.self, factory: { _ in
            return EmailFormConfigurator(screenId: "ENTER_EMAIL")
        }).inObjectScope(.weak)
        resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.EMAIL_FORM)*/
    }
    
    func secondButton() {
        storage.emailDenied = true
        chatFlowService.state.accept(.USER_NO_EMAIL_DESCRIPTION)
    }
}

