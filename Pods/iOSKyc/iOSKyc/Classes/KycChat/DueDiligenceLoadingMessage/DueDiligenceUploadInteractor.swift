//
//  DueDiligenceUploadInteractor.swift
//  iOSKyc
//
//  Created by Nik on 24/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK
import iOSBaseViews
import RxSwift
import iOSKycViews

class DueDiligenceUploadInteractor : BotLoadingMessageInteractor {
    
    let viewModel : DueDiligenceViewModel
    let chatFlowService : ChatFlowService
    let flowService : IFlowService
    
    let disposeBag = DisposeBag()
    
    init(viewModel: DueDiligenceViewModel, chatFlowService: ChatFlowService, flowService: IFlowService, botLoadingMessage: BotLoadingMessageEntity) {
        self.viewModel = viewModel
        self.flowService = flowService
        self.chatFlowService = chatFlowService
        super.init(botLoadingMessage: botLoadingMessage)
        
        flowService.state.subscribe(onNext: {[weak self] state in
            switch state {
            case .DUE_DILIGENCE_FLOW_RESULT(let res):
                switch res {
                case .success(_):
                    self?.chatFlowService.messagesChange.onNext([.delete(1)])
                    self?.chatFlowService.fireNextProof()
                case .failure(_):
                    self?.chatFlowService.messagesChange.onNext([.delete(1)])
                    self?.chatFlowService.state.accept(.SOMETHING_WENT_WRONG)
                }
            default:
                ()
            }
        }).disposed(by: disposeBag)
        
        flowService.setDueDiligence(uuid: flowService.generateFlowId(), data: viewModel.form.values)
    }
}
