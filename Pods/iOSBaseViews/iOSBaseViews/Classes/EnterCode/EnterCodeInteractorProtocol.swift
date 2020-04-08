//
//  EnterCodeInteractorProtocol.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation
import RxSwift
import RxRelay

public protocol EnterCodeInteractorProtocol {
    func checkCode(_ code: String) -> Observable<Bool>
    var resendProhibited : PublishSubject<Void> { get }
    var attemptsLeft : BehaviorRelay<Int> { get }
    func resendCode()
}
