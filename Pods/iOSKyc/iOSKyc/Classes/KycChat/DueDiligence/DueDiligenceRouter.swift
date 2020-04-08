//
//  DueDiligenceRouter.swift
//  iOSKyc
//
//  Created by Nik on 24/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycViews

class DueDiligenceRouter : TemplateFormRouterProtocol {
    
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
        chatFlowService.state.accept(.DUE_DILIGENCE_UPLOAD)
    }
}
