//
//  EmailCodeVerifyInteractor.swift
//  iOSKyc
//
//  Created by Nik on 04/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews
import iOSKycSDK
import RxSwift
import RxRelay

class EmailCodeVerifyInteractor : EnterCodeInteractorProtocol {
    var attemptsLeft: BehaviorRelay<Int> = BehaviorRelay(value: 3)
    let flowService : IFlowService
    let viewModel: ConnectEmailViewModel
    let disposeBag = DisposeBag()
    
    private var observer : AnyObserver<Bool>?
    var resendProhibited : PublishSubject<Void> = PublishSubject()
    
    init(flowService: IFlowService, viewModel: ConnectEmailViewModel) {
        self.flowService = flowService
        self.viewModel = viewModel
        
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
                case .success(_, let data):
                    if let attemptsLeft = data?.attemptsLeft {
                        self?.attemptsLeft.accept(attemptsLeft)
                        if attemptsLeft <= 0 {
                            self?.resendProhibited.onNext(())
                        }
                    }
                case .failure(_, _):
                    self?.observer?.onNext(false)
                }
            default:
                ()
            }
            
        }).disposed(by: disposeBag)
    }
    
    func checkCode(_ code: String) -> Observable<Bool> {
        viewModel.code = code
        return Observable.create { [weak self] observer in
            guard let uuid = self?.flowService.generateFlowId() else {
                observer.onCompleted()
                return Disposables.create()
            }
            self?.observer = observer
            self?.flowService.confirmEmail(uuid: uuid, code: code)
            
            return Disposables.create() {
                self?.observer = nil
            }
        }
    }
    
    func resendCode() {
        flowService.retrySendEmailCode(uuid: flowService.generateFlowId())
    }
}
