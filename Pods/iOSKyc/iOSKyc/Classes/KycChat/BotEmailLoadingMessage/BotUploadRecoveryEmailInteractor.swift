//
//  BotUploadEmailInteractor.swift
//  iOSKyc
//
//  Created by Nik on 09/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK
import iOSBaseViews
import RxSwift
import iOSKycViews

class BotUploadRecoveryEmailInteractor : BotLoadingMessageInteractor {
    
    let chatFlowService : ChatFlowService
    let flowService : IFlowService
    
    let disposeBag = DisposeBag()
    
    init(chatFlowService: ChatFlowService, flowService: IFlowService, botLoadingMessage: BotLoadingMessageEntity) {
        
        self.flowService = flowService
        self.chatFlowService = chatFlowService
        super.init(botLoadingMessage: botLoadingMessage)
        
        flowService.state.subscribe(onNext: {[weak self] state in
            switch state {
            case .REGISTRATION_EMAIL_FLOW_RESULT(let res):
                switch res {
                case .success(_):
                    self?.chatFlowService.messagesChange.onNext([.delete(1)])
                    self?.chatFlowService.state.accept(.BOT_ENTER_RECOVERY_EMAIL_CODE_DESCRIPTION)
                case .failure(_):
                    self?.chatFlowService.messagesChange.onNext([.delete(1)])
                    self?.chatFlowService.state.accept(.SOMETHING_WENT_WRONG)
                }
                
            case .REGISTRATION_EMAIL_SUBMIT_SOLUTION(let res):
            switch res {
            case .success(_, _):
                self?.chatFlowService.messagesChange.onNext([.delete(1)])
                self?.chatFlowService.state.accept(.BOT_ENTER_RECOVERY_EMAIL_CODE_DESCRIPTION)
            case .failure(_, _):
                self?.chatFlowService.messagesChange.onNext([.delete(1)])
                self?.chatFlowService.state.accept(.SOMETHING_WENT_WRONG)
            }
            default:
                ()
            }
        }).disposed(by: disposeBag)
        
        flowService.approveEmail(uuid: flowService.generateFlowId())
        
    }
}
