//
//  KYCDevicesListInteractor.swift
//  iOSKyc
//
//  Created by Nik on 27/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK
import iOSKycViews
import RxSwift
import iOSCoreSDK

class KYCDevicesListInteractor : DevicesListInteractor {
    let flowService : IFlowService
    let screenStateService: ScreenStateService
    var storage: IKycStorage
    let disposeBag = DisposeBag()
    let sdk : ISDKCore
    
    init(flowService: IFlowService, sdk: ISDKCore, screenStateService: ScreenStateService, storage: IKycStorage) {
        self.flowService = flowService
        self.sdk = sdk
        self.screenStateService = screenStateService
        self.storage = storage
        super.init()
        flowService.state.subscribe(onNext: {[weak self] state in
            switch state {
            case .AUTHORIZATION_DEVICE_LIST_RESULT(let result):
                switch result {
                case .success(_, let devices):
                    if let devices = devices {
                        self?.devices.accept(devices)
                    }
                default:
                    ()
                }
            case .DEVICE_AUTHORIZATION_FLOW_RESULT(let result):
                switch result {
                case .success:
                    self?.storage.isRecoveryMode = false
                    screenStateService.pinCodeVerified()
                case .failure:
                    self?.sdk.logout()
                    self?.sdk.reinit()
                }
            default:
                ()
            }
        }).disposed(by: disposeBag)
        
        flowService.getUserDevices(uuid: flowService.generateFlowId())
    }
    
    override func sendConfirmation() {
        flowService.deviceAuthorizationRequest(uuid: flowService.generateFlowId())
    }
}

extension DeviceEntity : DeviceEntityProtocol {
    public func getName() -> String {
        return deviceInfo?.model ?? deviceInfo?.device ?? ""
    }
    
    public func getDescripition() -> String {
        return createdAt ?? ""
    }
    
    public func configureImage(_ image: UIImageView) {
        
    }
    
    
}
