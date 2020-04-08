//
//  PhoneRegistrationInteractor.swift
//
//  Created by Nik, 1/01/2020
//

import Foundation
import PhoneNumberKit
import RxSwift

public class PhoneRegistrationInteractor : PhoneRegistrationInteractorProtocol {
    
    private var timer : Timer?
    
    public var restrictedCountry : PublishSubject<Void> = PublishSubject()
    
    public func registerPhone(_ phone: String) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
                observer.onNext(true)
            })
            return Disposables.create {
                self?.timer?.invalidate()
                self?.timer = nil
            }
        }
    }
    
    public func parsePhone(_ phone: String) -> String? {
        do {
            let phoneNumberKit = PhoneNumberKit()
            let phoneNumber = try phoneNumberKit.parse(phone)
            return phoneNumberKit.format(phoneNumber, toType: .e164)
        }
        catch {
            return nil
        }
    }
    
    public init() {}
    
    
}
