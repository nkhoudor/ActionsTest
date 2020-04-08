//
//  PhoneRegistrationInteractorProtocol.swift
//
//  Created by Nik, 1/01/2020
//

import Foundation
import RxSwift

public protocol PhoneRegistrationInteractorProtocol {
    func registerPhone(_ phone: String) -> Observable<Bool>
    func parsePhone(_ phone: String) -> String?
    var restrictedCountry : PublishSubject<Void> { get }
}
