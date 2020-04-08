//
//  EmailFormInteractor.swift
//
//  Created by Nik, 29/01/2020
//

import RxSwift

public class EmailFormInteractor : EmailFormInteractorProtocol {
    
    private var timer : Timer?
    
    public init() {}
    
    public func emailProvided(_ email: String) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                observer.onNext(true)
            })
            return Disposables.create {
                self?.timer?.invalidate()
                self?.timer = nil
            }
        }
    }
}
