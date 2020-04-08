//
//  ConnectEmailFormInteractor.swift
//  iOSKyc
//
//  Created by Nik on 12/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycSDK
import RxSwift

class ConnectEmailFormInteractor : EmailFormInteractorProtocol {
    
    let flowService : IFlowService
    let viewModel : ConnectEmailViewModel
    let storage : IKycStorage
    
    let disposeBag = DisposeBag()
    
    init(flowService : IFlowService, viewModel : ConnectEmailViewModel, storage : IKycStorage) {
        self.flowService = flowService
        self.viewModel = viewModel
        self.storage = storage
        
        flowService.state.subscribe(onNext: {[weak self] state in
            switch state {
            case .REGISTRATION_EMAIL_FLOW_RESULT(let res):
                switch res {
                case .success(_):
                    self?.observer?.onNext(true)
                case .failure(_):
                    self?.observer?.onNext(false)
                }
                
            case .REGISTRATION_EMAIL_SUBMIT_SOLUTION(let res):
                switch res {
                case .success(_, _):
                    self?.observer?.onNext(true)
                case .failure(_, _):
                    self?.observer?.onNext(false)
                }
            default:
                ()
            }
        }).disposed(by: disposeBag)
    }
    
    private var observer : AnyObserver<Bool>?
    
    func emailProvided(_ email: String) -> Observable<Bool> {
        viewModel.email = email
        
        return Observable.create { [weak self] observer in
            guard let flowService = self?.flowService, let storage = self?.storage, let viewModel = self?.viewModel else {
                observer.onCompleted()
                return Disposables.create()
            }
            self?.observer = observer
            
            if storage.isRecoveryMode {
                flowService.approveEmail(uuid: flowService.generateFlowId())
            } else {
                flowService.setEmail(uuid: flowService.generateFlowId(), email: email, isAgree: viewModel.isAgree)
            }
            
            return Disposables.create() {
                self?.observer = nil
            }
        }
        
        
        
    }
}
