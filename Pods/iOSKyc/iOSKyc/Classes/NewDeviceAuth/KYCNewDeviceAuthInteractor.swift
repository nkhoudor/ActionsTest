//
//  KYCNewDeviceAuthInteractor.swift
//  iOSKyc
//
//  Created by Nik on 14/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import RxSwift
import iOSKycSDK
import iOSKycViews

class KYCNewDeviceAuthInteractor : NewDeviceAuthInteractorProtocol {
    
    var requestSent: PublishSubject<Void> = PublishSubject()
    var sdkDenied: Bool = false
    let flowService: IFlowService
    let stateNavigator: StateNavigatorProtocol
    let authRequestId: String
    let disposeBag = DisposeBag()
    
    init(flowService: IFlowService, stateNavigator: StateNavigatorProtocol, authRequestId: String) {
        self.flowService = flowService
        self.stateNavigator = stateNavigator
        self.authRequestId = authRequestId
        
        flowService.state.subscribe(onNext: {[weak self] state in
            self?.flowStateChanged(state)
        }).disposed(by: disposeBag)
    }
    
    private func flowStateChanged(_ state: FlowState) {
        guard !sdkDenied else { return }
        switch state {
        case .DEVICE_AUTHORIZATION_RESULT(let res):
            switch res {
            case .success(let data):
                guard data.id == authRequestId else { return }
                stateNavigator.back()
            case .failure(_):
                stateNavigator.back()
            }
        default:
            ()
        }
    }
    
    func confirmAction() {
        flowService.handleDeviceAuthorizationRequest(uuid: flowService.generateFlowId(), authRequestId: authRequestId, action: .approve)
    }
    
    func denyAction() {
        flowService.handleDeviceAuthorizationRequest(uuid: flowService.generateFlowId(), authRequestId: authRequestId, action: .reject)
    }
    
    
}
