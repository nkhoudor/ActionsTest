//
//  PhoneRegistrationInteractor.swift
//  iOSKyc
//
//  Created by Nik on 13/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycSDK
import RxSwift

class KYCReenterPinCodeInteractor : PinCodeInteractorProtocol {
    let viewModel: CreatePinViewModel
    
    init(viewModel: CreatePinViewModel) {
        self.viewModel = viewModel
    }
    
    func checkPinCode(_ pinCode: String) -> Observable<Bool> {
        let result = viewModel.validate(pinCode: pinCode)
        return Observable.create { observer in
            observer.onNext(result)
            return Disposables.create {}
        }
    }
}
