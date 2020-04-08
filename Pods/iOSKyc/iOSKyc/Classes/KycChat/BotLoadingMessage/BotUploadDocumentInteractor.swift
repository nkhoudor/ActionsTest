//
//  BotUploadDocumentInteractor.swift
//  iOSKyc
//
//  Created by Nik on 27/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK
import RxSwift
import iOSKycViews

class BotUploadDocumentInteractor : BotLoadingMessageInteractor {
    
    let viewModel : DocumentViewModel
    let chatFlowService : ChatFlowService
    let flowService : IFlowService
    var storage : IKycStorage
    
    let disposeBag = DisposeBag()
    
    init(viewModel: DocumentViewModel, storage: IKycStorage, chatFlowService: ChatFlowService, flowService: IFlowService, botLoadingMessage: BotLoadingMessageEntity) {
        self.viewModel = viewModel
        self.storage = storage
        self.flowService = flowService
        self.chatFlowService = chatFlowService
        super.init(botLoadingMessage: botLoadingMessage)
        
        flowService.state.subscribe(onNext: {[weak self] state in
            switch state {
            case .REGISTRATION_DOCUMENT_FLOW_RESULT(let result):
                switch result {
                case .success(_):
                    self?.chatFlowService.messagesChange.onNext([.delete(1)])
                    self?.chatFlowService.fireNextProof()
                case .failure(let error):
                    self?.chatFlowService.messagesChange.onNext([.delete(1)])
                    if let error = error {
                        switch error.code {
                        case 443:
                            self?.storage.wrongCountry = true
                            self?.chatFlowService.state.accept(.BOT_WRONG_COUNTRY_DESCRIPTION)
                        case 444:
                            self?.storage.wrongAge = true
                            self?.chatFlowService.state.accept(.BOT_WRONG_AGE_DESCRIPTION)
                        default:
                            ()
                        }
                        
                    } else {
                        self?.chatFlowService.state.accept(.SOMETHING_WENT_WRONG)
                    }
                }
            default:
                ()
            }
        }).disposed(by: disposeBag)
        
        if storage.isRecoveryMode {
            flowService.approveDocument(uuid: flowService.generateFlowId(), documentType: viewModel.documentType, frontImageFile: viewModel.frontImageFile, backImageFile: viewModel.backImageFile, faceImageFile: viewModel.faceImageFile)
        } else {
            flowService.uploadDocument(uuid: flowService.generateFlowId(), documentType: viewModel.documentType, frontImageFile: viewModel.frontImageFile, backImageFile: viewModel.backImageFile, faceImageFile: viewModel.faceImageFile)
        }
    }
}
