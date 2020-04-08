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

class KYCCreatePinCodeInteractor : PinCodeInteractorProtocol {
    let viewModel : CreatePinViewModel
    
    init(viewModel : CreatePinViewModel) {
        self.viewModel = viewModel
    }
    
    func checkPinCode(_ pinCode: String) -> Observable<Bool> {
        viewModel.pinCode = pinCode
        return Observable.create { observer in
            observer.onNext(true)
            return Disposables.create {}
        }
    }
}
