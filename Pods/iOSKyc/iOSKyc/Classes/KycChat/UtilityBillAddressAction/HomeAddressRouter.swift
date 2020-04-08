//
//  HomeAddressRouter.swift
//  iOSKyc
//
//  Created by Nik on 21/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import iOSKycViews

class HomeAddressRouter : TemplateFormRouterProtocol {
    
    let navigator : StateNavigatorProtocol
    let chatFlowService : ChatFlowService
    
    init(navigator : StateNavigatorProtocol, chatFlowService : ChatFlowService) {
        self.navigator = navigator
        self.chatFlowService = chatFlowService
    }
    
    func finish(config: TemplateFormConfigProtocol) {
        navigator.back()
        chatFlowService.messagesChange.onNext([.delete(1)])
        chatFlowService.state.accept(.ADDRESS_INFO(config))
        chatFlowService.state.accept(.BOT_UTILITY_BILL_UPLOAD_LOADING)
    }
}
