//
//  EnterCodeInteractor.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation
import RxSwift
import RxRelay

public class EnterCodeInteractor : EnterCodeInteractorProtocol {
    public var attemptsLeft: BehaviorRelay<Int> = BehaviorRelay(value: 3)
    private var timer: Timer?
    
    public init() {}
    
    public func checkCode(_ code: String) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
                observer.onNext(code == "000000")
            })
            return Disposables.create {
                self?.timer?.invalidate()
                self?.timer = nil
            }
        }
    }
    
    public var resendProhibited : PublishSubject<Void> = PublishSubject()
    
    public func resendCode() {
        attemptsLeft.accept(attemptsLeft.value - 1)
        
        if attemptsLeft.value == 0 {
            resendProhibited.onNext(())
        }
    }
}
