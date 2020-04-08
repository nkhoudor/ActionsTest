//
//  NewsAgreeActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 04/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import iOSKycViews

class NewsAgreeActionRouter : ChatActionRouterProtocol {
    let viewModel : ConnectEmailViewModel
    let chatFlowService : ChatFlowService
    
    init(viewModel : ConnectEmailViewModel, chatFlowService : ChatFlowService) {
        self.viewModel = viewModel
        self.chatFlowService = chatFlowService
    }
    
    func firstButton() {
        viewModel.isAgree = true
        chatFlowService.state.accept(.NEWS_AGREE_RESULT(true))
    }
    
    func secondButton() {
        viewModel.isAgree = false
        chatFlowService.state.accept(.NEWS_AGREE_RESULT(false))
    }
}


