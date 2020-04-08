//
//  KYCCheckPinCodeInteractor.swift
//  iOSKyc
//
//  Created by Nik on 13/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycSDK
import RxSwift

class KYCCheckPinCodeInteractor : PinCodeInteractorProtocol {
    let storage: IKycStorage
    
    init(storage: IKycStorage) {
        self.storage = storage
    }
    
    func checkPinCode(_ pinCode: String) -> Observable<Bool> {
        let result = storage.pinHash == pinCode
        return Observable.create { observer in
            observer.onNext(result)
            return Disposables.create {}
        }
    }
}
