//
//  DeviceAuthService.swift
//  iOSKyc
//
//  Created by Nik on 18/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK
import Swinject
import RxSwift

class DeviceAuthService {
    let flowService : IFlowService
    let navigator : StateNavigatorProtocol
    let disposeBag = DisposeBag()
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    init(flowService: IFlowService, navigator : StateNavigatorProtocol) {
        self.flowService = flowService
        self.navigator = navigator
        flowService.state.subscribe(onNext: {[weak self] state in
            self?.flowStateChanged(state)
        }).disposed(by: disposeBag)
        flowService.getAuthorizationRequestList(uuid: flowService.generateFlowId())
    }
    
    func requestReceived(_ data: AuthorizationDeviceNewData) {
        navigator.state.accept(.NEW_DEVICE_AUTH(data: data))
    }
    
    func flowStateChanged(_ state: FlowState) {
        switch state {
        
        case .AUTHORIZATION_DEVICE_NEW(let res):
            switch res {
            case .success(let data):
                requestReceived(data)
            case .failure(_):
                ()
            }
            
        case .AUTHORIZATION_REQUEST_LIST_RES(let res):
            switch res {
            case .success(let data):
                for d in data {
                    requestReceived(d)
                }
            case .failure(_):
                ()
            }
        default:
            ()
        }
    }
}
