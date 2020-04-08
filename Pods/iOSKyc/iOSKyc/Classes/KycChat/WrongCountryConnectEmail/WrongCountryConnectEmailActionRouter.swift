//
//  WrongCountryConnectEmailActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 13/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration
import iOSBaseViews
import iOSKycSDK
import RxSwift
import iOSKycViews

class WrongCountryConnectEmailActionRouter : ChatActionRouterProtocol {
    let chatFlowService : ChatFlowService
    
    init(chatFlowService : ChatFlowService) {
        self.chatFlowService = chatFlowService
    }
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    func firstButton() {
        
        (resolver as? Container)!.register(EmailFormRouterProtocol.self, factory: { resolver in
            let router = EmailFormRouter()
            router.emailProvided = {[weak self] email in
                self?.resolver.resolve(StateNavigatorProtocol.self)!.state.accept(.CHAT)
                self?.chatFlowService.messagesChange.onNext([.delete(1)])
                self?.chatFlowService.state.accept(.USER_WRONG_COUNTRY_EMAIL_PROVIDED(email))
            }
            return router
        }).inObjectScope(.weak)
        
        (resolver as? Container)!.register(EmailFormInteractorProtocol.self, factory: { resolver in
            return WrongCountryConnectEmailFormInteractor(flowService: resolver.resolve(IFlowService.self)!)
        }).inObjectScope(.weak)
        
        (resolver as? Container)!.register(EmailFormConfiguratorProtocol.self, factory: { _ in
            return EmailFormConfigurator(screenId: "WRONG_COUNTRY_CONNECT_EMAIL")
        }).inObjectScope(.weak)
        resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.EMAIL_FORM)
    }
    
    func secondButton() {
        chatFlowService.messagesChange.onNext([.delete(1)])
        chatFlowService.state.accept(.USER_WRONG_COUNTRY_NO_EMAIL)
    }
}

