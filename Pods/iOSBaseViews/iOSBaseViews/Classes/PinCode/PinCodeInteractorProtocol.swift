//
//  PinCodeInteractorProtocol.swift
//
//  Created by Nik, 4/01/2020
//

import Foundation
import RxSwift

public protocol PinCodeInteractorProtocol {
    func checkPinCode(_ pinCode: String) -> Observable<Bool>
}
