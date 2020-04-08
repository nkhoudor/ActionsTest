//
//  KYCLetsBeginRouter.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews

class KYCLetsBeginRouter : ChatActionRouterProtocol {

    var chatFlowService : ChatFlowService!

    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    init(chatFlowService : ChatFlowService) {
        self.chatFlowService = chatFlowService
    }
    
    func firstButton() {     
        chatFlowService.state.accept(.LETS_BEGIN_USER_MESSAGE)
    }
    
    func secondButton() {}
    
}
