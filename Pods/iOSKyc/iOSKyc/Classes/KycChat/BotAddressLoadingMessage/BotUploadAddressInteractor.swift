//
//  BotUploadAddressInteractor.swift
//  iOSKyc
//
//  Created by Nik on 09/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK
import iOSBaseViews
import RxSwift
import iOSKycViews

class BotUploadAddressInteractor : BotLoadingMessageInteractor {
    
    let viewModel : AddressViewModel
    let chatFlowService : ChatFlowService
    let flowService : IFlowService
    
    let disposeBag = DisposeBag()
    
    init(viewModel: AddressViewModel, chatFlowService: ChatFlowService, flowService: IFlowService, botLoadingMessage: BotLoadingMessageEntity) {
        self.viewModel = viewModel
        self.flowService = flowService
        self.chatFlowService = chatFlowService
        super.init(botLoadingMessage: botLoadingMessage)
        
        flowService.state.subscribe(onNext: {[weak self] state in
            switch state {
            case .REGISTRATION_ADDRESS_FLOW_RESULT(let res):
                switch res {
                case .success(_):
                    self?.chatFlowService.messagesChange.onNext([.delete(1)])
                    //self?.chatFlowService.fireNextProof()
                    self?.chatFlowService.state.accept(.BOT_PLASTIC_DELIVERY_DESCRIPTION)
                case .failure(_):
                    self?.chatFlowService.messagesChange.onNext([.delete(1)])
                    self?.chatFlowService.state.accept(.SOMETHING_WENT_WRONG)
                }
            default:
                ()
            }
        }).disposed(by: disposeBag)
        
        flowService.uploadAddress(uuid: flowService.generateFlowId(), addressData: viewModel.form.values, addressImages: viewModel.images)
    }
}
