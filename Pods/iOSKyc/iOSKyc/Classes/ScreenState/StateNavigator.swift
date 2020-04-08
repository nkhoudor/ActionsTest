//
//  StateNavigator.swift
//  iOSKyc
//
//  Created by Nik on 14/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import iOSKycSDK
import RxSwift
import RxRelay
import Swinject
import iOSBaseViews
import iOSCoreSDK

protocol StateNavigatorProtocol : class {
    var state : BehaviorRelay<ScreenState> { get }
    func back()
}

class StateNavigator : UINavigationController, StateNavigatorProtocol {
    
    var sdk : ISDKCore!
    var flowService : IFlowService!
    var storage : IKycStorage!
    
    let disposeBag = DisposeBag()
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    var state : BehaviorRelay<ScreenState> = BehaviorRelay(value: .SPLASH)
    
    init(sdk : ISDKCore, flowService : IFlowService, storage : IKycStorage) {
        super.init(nibName: nil, bundle: nil)
        self.sdk = sdk
        self.flowService = flowService
        self.storage = storage
        isNavigationBarHidden = true
        initListeners()
    }
    
    private func initListeners() {
        state.observeOn(MainScheduler.asyncInstance).withPrevious(startWith: state.value).subscribe(onNext: {[weak self] state in
            //guard state.previous != state.current else { return }
            self?.showScreen(state: state.current)
        }).disposed(by: disposeBag)
    }
    
    private func showScreen(state: ScreenState) {
        switch state {
        case .SPLASH:
            ()
        case .CLOSE_APP:
            exit(-1)
        case .KYC_COMPLETED:
            (resolver as? Container)?.register(ErrorWarningInfoConfiguratorProtocol.self, factory: { _ in
                return ErrorWarningInfoConfigurator.getKYCCompleted()
            }).inObjectScope(.weak)
            self.state.accept(.ERROR_WARNING_INFO)
        case .START_SCREEN:
            /*if true {
                
                self.state.accept(.TEMPLATE_FORM(config: resolver.resolve(TemplateFormConfig.self)!))
                return
            }*/
            if !storage.isPPConfirmed {
                self.state.accept(.PRIVACY_POLICY)
            } else if storage.pinHash != nil {
                self.state.accept(.CHECK_PIN_CODE)
            } else {
                self.state.accept(.PHONE_REGISTRATION)
            }
            
        case .PRIVACY_POLICY:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: PrivacyPolicyAssembly.registrationName)!
            switchVC(key: PrivacyPolicyAssembly.registrationName, factory: factory)
        case .PHONE_REGISTRATION:
            //storage.clear()
            //sdk.reinit()
            let factory = resolver.resolve(Factory<UIViewController>.self, name: PhoneRegistrationAssembly.registrationName)!
            switchVC(key: PhoneRegistrationAssembly.registrationName, factory: factory)
        case .ENTER_SMS_CODE:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: EnterSmsCodeAssembly.registrationName)!
            switchVC(key: EnterSmsCodeAssembly.registrationName, factory: factory)
        case .CREATE_PIN_CODE:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: CreatePinCodeAssembly.registrationName)!
            switchVC(key: CreatePinCodeAssembly.registrationName, factory: factory)
        case .REENTER_PIN_CODE:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: ReenterPinCodeAssembly.registrationName)!
            switchVC(key: ReenterPinCodeAssembly.registrationName, factory: factory)
        case .CHECK_PIN_CODE:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: CheckPinCodeAssembly.registrationName)!
            switchVC(key: CheckPinCodeAssembly.registrationName, factory: factory)
        case .DEVICE_LIST:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: DevicesListAssembly.registrationName)!
            switchVC(key: DevicesListAssembly.registrationName, factory: factory)
        case .NEW_DEVICE_AUTH(let data):
            let factory = resolver.resolve(Factory<UIViewController>.self, name: NewDeviceAuthAssembly.registrationName, argument: data)!
            switchVC(key: NewDeviceAuthAssembly.registrationName, factory: factory, checkStack: false)
        case .CHAT:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: ChatAssembly.registrationName)!
            switchVC(key: ChatAssembly.registrationName, factory: factory)
        case .TEMPLATE_FORM(let config):
            let factory = resolver.resolve(Factory<UIViewController>.self, name: TemplateFormAssembly.registrationName, argument: config)!
            switchVC(key: TemplateFormAssembly.registrationName, factory: factory)
        case .EMAIL_FORM:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: EmailFormAssembly.registrationName)!
            switchVC(key: EmailFormAssembly.registrationName, factory: factory)
        case .EMAIL_VERIFICATION:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: EmailCodeVerifyAssembly.registrationName)!
            switchVC(key: EmailCodeVerifyAssembly.registrationName, factory: factory)
        case .ERROR_WARNING_INFO:
            let factory = resolver.resolve(Factory<UIViewController>.self, name: ErrorWarningInfoAssembly.registrationName)!
            switchVC(key: ErrorWarningInfoAssembly.registrationName, factory: factory)
        }
    }
    
    func back() {
        if vcs.count > 0 {
            popViewController(animated: true)
            vcs.removeLast()
        }
    }
    
    private var vcs : [(key: String, vc: UIViewController)] = []
    
    private func switchVC(key: String, factory: Factory<UIViewController>, checkStack: Bool = true) {
        if checkStack, let index = vcs.lastIndex(where: { $0.key == key }), index != vcs.count - 1 {
            popToViewController(vcs[index].vc, animated: true)
            vcs.removeSubrange(index+1...vcs.count-1)
        } else {
            let vc = factory()
            pushViewController(vc, animated: true)
            vcs.append((key: key, vc: vc))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

