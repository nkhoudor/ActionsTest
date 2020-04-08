//
//  ScreenStateService.swift
//  iOSKyc
//
//  Created by Nik on 14/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK
import RxSwift
import RxRelay
import Swinject
import iOSBaseViews
import iOSCoreSDK

enum ScreenState : Equatable {
    case CLOSE_APP
    case SPLASH
    case START_SCREEN
    case PRIVACY_POLICY
    case PHONE_REGISTRATION
    case ENTER_SMS_CODE
    case CREATE_PIN_CODE
    case REENTER_PIN_CODE
    case CHECK_PIN_CODE
    case DEVICE_LIST
    case NEW_DEVICE_AUTH(data: AuthorizationDeviceNewData)
    case CHAT
    case TEMPLATE_FORM(config: TemplateFormConfig)
    case EMAIL_FORM
    case EMAIL_VERIFICATION
    case ERROR_WARNING_INFO
    case KYC_COMPLETED
}

class ScreenStateService {
    
    let sdk : ISDKCore
    let flowService : IFlowService
    var storage : IKycStorage!
    let navigator : StateNavigatorProtocol
    
    let disposeBag = DisposeBag()
    
    var state : BehaviorRelay<ScreenState> = BehaviorRelay(value: .SPLASH)
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    var finishCallback: (() -> ())?
    
    init(sdk : ISDKCore, flowService : IFlowService, storage : IKycStorage, navigator : StateNavigatorProtocol, finishCallback: (() -> ())?) {
        self.sdk = sdk
        self.flowService = flowService
        self.storage = storage
        self.navigator = navigator
        self.finishCallback = finishCallback
        initListeners()
    }
    
    private func initListeners() {
        sdk.state.observeOn(MainScheduler.asyncInstance).subscribe(onNext: {[weak self] state in
            self?.sdkStateChanged(state: state)
        }).disposed(by: disposeBag)
        
        flowService.state.observeOn(MainScheduler.asyncInstance).subscribe(onNext: {[weak self] state in
            self?.flowStateChanged(state: state)
        }).disposed(by: disposeBag)
    }
    
    private var oneTime : Bool = true
    
    private var checkIdentityDisposable : Disposable?
    
    public func pinCodeVerified() {
        
        if storage.isRecoveryMode {
            navigator.state.accept(.DEVICE_LIST)
        } else {
            checkIdentityDisposable = flowService.state
                .observeOn(MainScheduler.asyncInstance)
                .subscribe(onNext: {[weak self] state in
                    switch state {
                    case .IDENTITY_REQUEST_RESULT(let res):
                        self?.checkIdentityDisposable?.dispose()
                        self?.checkIdentityDisposable = nil
                        switch res {
                        case .success(_, let data):
                            if data.riskScore == .HIGH {
                                (self?.resolver as? Container)?.register(ErrorWarningInfoConfiguratorProtocol.self, factory: { _ in
                                    return ErrorWarningInfoConfigurator.getHighRisk()
                                }).inObjectScope(.weak)
                                self?.navigator.state.accept(.ERROR_WARNING_INFO)
                                return
                            }
                            if data.isSuccess {
                                let _ = self?.resolver.resolve(DeviceAuthService.self)!
                                if let finishCallback = self?.finishCallback {
                                    finishCallback()
                                } else {
                                    self?.navigator.state.accept(.KYC_COMPLETED)
                                }
                            } else if data.isManualOrSuccess {
                                //START MONITORING WATCHERS
                                self?.monitorWatchers = true
                                
                                (self?.resolver as? Container)?.register(ErrorWarningInfoConfiguratorProtocol.self, factory: { _ in
                                    return ErrorWarningInfoConfigurator.getComeLater()
                                }).inObjectScope(.weak)
                                self?.navigator.state.accept(.ERROR_WARNING_INFO)
                            } else {
                                self?.navigator.state.accept(.CHAT)
                            }
                            
                        case .failure(_):
                            ()
                        }
                    default:
                        ()
                    }
                })
            checkIdentityDisposable?.disposed(by: disposeBag)
            flowService.getIdentity(uuid: flowService.generateFlowId())
            
            //navigator.state.accept(.CHAT)
        }
    }
    
    private func sdkStateChanged(state: State) {
        
        print("SDKSSTATE:\(state)")
        switch state {
        case .INIT_SUCCESS:
            
            if oneTime {
                oneTime = false
                /*if true {
                 navigator.state.accept(.NEW_DEVICE_AUTH)
                 return
                 }*/
                //HACK. We need to implement request to server
                if storage.wrongCountry {
                    (resolver as? Container)?.register(ErrorWarningInfoConfiguratorProtocol.self, factory: { _ in
                        return ErrorWarningInfoConfigurator.getWrongCountry()
                    }).inObjectScope(.weak)
                    navigator.state.accept(.ERROR_WARNING_INFO)
                } else if storage.wrongAge {
                    (resolver as? Container)?.register(ErrorWarningInfoConfiguratorProtocol.self, factory: { _ in
                        return ErrorWarningInfoConfigurator.getWrongAge()
                    }).inObjectScope(.weak)
                    navigator.state.accept(.ERROR_WARNING_INFO)
                } else {
                    navigator.state.accept(.START_SCREEN)
                }
            }
        default:
            ()
        }
    }
    
    var monitorWatchers: Bool = false
    
    private func flowStateChanged(state: FlowState) {
        print("FLOWSSTATE:\(state)")
        switch state {
        case .REGISTRATION_PHONE_START:
            storage.clear()
            print(storage.keys)
            sdk.reinit()
            navigator.state.accept(.PHONE_REGISTRATION)
        case .REGISTRATION_PHONE_FLOW_RESULT(let result):
            switch result {
            case .success(let data):
                storage.isRecoveryMode = data.isRecovery ?? false
                storage.phoneProvided = true
                navigator.state.accept(.CREATE_PIN_CODE)
            case .failure(let error):
                if error?.code != 428 {
                    flowService.state.accept(.REGISTRATION_PHONE_START)
                }
            }
        case .ADDRESS_PROCESSED, .AML_PROCESSED, .DOCUMENT_PROCESSED:
            if monitorWatchers {
                pinCodeVerified()
            }
            
        default:
            ()
        }
    }
}
