//
//  PhoneRegistrationInteractor.swift
//  iOSKyc
//
//  Created by Nik on 13/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import iOSKycViews
import iOSKycSDK
import RxSwift
import PhoneNumberKit

class KYCPhoneRegistrationInteractor : PhoneRegistrationInteractorProtocol {
    
    let flowService : IFlowService
    let viewModel : PhoneRegistrationViewModel
    let navigator: StateNavigatorProtocol
    let disposeBag = DisposeBag()
    
    private var observer : AnyObserver<Bool>?
    
    public var restrictedCountry: PublishSubject<Void> = PublishSubject()
    
    init(flowService: IFlowService, navigator: StateNavigatorProtocol, viewModel : PhoneRegistrationViewModel) {
        self.flowService = flowService
        self.viewModel = viewModel
        self.navigator = navigator
        
        flowService.state.observeOn(MainScheduler.asyncInstance).subscribe(onNext: {[weak self] state in
            guard navigator.state.value == ScreenState.PHONE_REGISTRATION else { return }
            
            switch state {
            case .REGISTRATION_PHONE_SUBMIT_SOLUTION(let result):
                switch result {
                case .success(_, _):
                    self?.observer?.onNext(true)
                    self?.navigator.state.accept(.ENTER_SMS_CODE)
                case .failure(_, _):
                    self?.observer?.onNext(false)
                }
                self?.observer?.onCompleted()
            case .REGISTRATION_PHONE_FLOW_RESULT(let result):
                switch result {
                case .success(_):
                    ()
                case .failure(let error):
                    self?.observer?.onNext(false)
                    if let error = error, error.code == 466 {
                        self?.restrictedCountry.onNext(())
                    }
                }
            default:
                ()
            }
        }).disposed(by: disposeBag)
    }
    
    public func registerPhone(_ phone: String) -> Observable<Bool> {
        viewModel.phone = phone
        return Observable.create { [weak self] observer in
            guard let uuid = self?.flowService.generateFlowId() else {
                observer.onCompleted()
                return Disposables.create()
            }
            self?.observer = observer
            self?.flowService.setPhone(uuid: uuid, phoneNumber: phone, device: "iPhone", model: UIDevice.modelName, deviceType: .ios)
            return Disposables.create() {
                self?.observer = nil
            }
        }
    }
    
    public func parsePhone(_ phone: String) -> String? {
        if phone.onlyDigitsAndPlus().contains("+70000000000") {
            return phone.onlyDigitsAndPlus()
        }
        if phone.onlyDigitsAndPlus().contains("+155501") {
            return phone.onlyDigitsAndPlus()
        }
        do {
            let phoneNumberKit = PhoneNumberKit()
            let phoneNumber = try phoneNumberKit.parse(phone)
            return phoneNumberKit.format(phoneNumber, toType: .e164)
        }
        catch {
            return nil
        }
    }
}

extension String {
    func onlyDigitsAndPlus() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.digitsAndPlus.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
}

extension CharacterSet {
    static let digitsAndPlus = CharacterSet(charactersIn: "0123456789+")
}
