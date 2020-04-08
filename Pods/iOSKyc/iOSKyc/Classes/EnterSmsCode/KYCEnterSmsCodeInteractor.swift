//
//  PhoneRegistrationInteractor.swift
//  iOSKyc
//
//  Created by Nik on 13/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews
import iOSKycSDK
import RxSwift
import RxRelay

class KYCEnterSmsCodeInteractor : EnterCodeInteractorProtocol {
    
    var attemptsLeft: BehaviorRelay<Int> = BehaviorRelay(value: 3)
    var flowService : IFlowService!
    let disposeBag = DisposeBag()
    
    private var observer : AnyObserver<Bool>?
    
    init(flowService: IFlowService) {
        self.flowService = flowService
        
        flowService.state.observeOn(MainScheduler.asyncInstance).subscribe(onNext: {[weak self] state in
            switch state {
            case .REGISTRATION_PHONE_FLOW_RESULT(let result):
                switch result {
                case .success(_):
                    self?.observer?.onNext(true)
                case .failure(let error):
                    if error?.code == 428, let attemptsLeft = self?.attemptsLeft.value, attemptsLeft <= 1 {
                        self?.resendProhibited.onNext(())
                    }
                    self?.observer?.onNext(false)
                }
                self?.observer?.onCompleted()
            case .REGISTRATION_PHONE_SUBMIT_SOLUTION(let result):
                switch result {
                case .success( _, let data):
                    if let attemptsLeft = data.attemptsLeft {
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
    var resendProhibited : PublishSubject<Void> = PublishSubject()
    
    func checkCode(_ code: String) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let uuid = self?.flowService.generateFlowId() else {
                observer.onCompleted()
                return Disposables.create()
            }
            self?.observer = observer
            self?.flowService.confirmPhone(uuid: uuid, code: code)
            
            return Disposables.create() {
                self?.observer = nil
            }
        }
    }
    
    func resendCode() {
        flowService.retrySendPhoneCode(uuid: flowService.generateFlowId())
    }
}
