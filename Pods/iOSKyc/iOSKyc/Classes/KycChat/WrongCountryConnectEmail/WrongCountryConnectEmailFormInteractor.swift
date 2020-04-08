//
//  WrongCountryConnectEmailFormInteractor.swift
//  iOSKyc
//
//  Created by Nik on 13/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycSDK
import RxSwift

class WrongCountryConnectEmailFormInteractor : EmailFormInteractorProtocol {
    
    let flowService : IFlowService
    
    let disposeBag = DisposeBag()
    
    init(flowService : IFlowService) {
        self.flowService = flowService
        
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
        return Observable.create { [weak self] observer in
            guard let flowService = self?.flowService else {
                observer.onCompleted()
                return Disposables.create()
            }
            self?.observer = observer
            
            flowService.setEmail(uuid: flowService.generateFlowId(), email: email, isAgree: true)
            
            return Disposables.create() {
                self?.observer = nil
            }
        }
    }
}
