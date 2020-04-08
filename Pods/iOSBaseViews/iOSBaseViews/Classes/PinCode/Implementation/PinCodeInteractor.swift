//
//  PinCodeInteractor.swift
//
//  Created by Nik, 4/01/2020
//

import Foundation
import RxSwift

public class PinCodeInteractor : PinCodeInteractorProtocol {
    public init() {}
    
    public func checkPinCode(_ pinCode: String) -> Observable<Bool> {
        return Observable.create { observer in
            observer.onNext(pinCode == "0000")
            return Disposables.create {}
        }
    }
}
