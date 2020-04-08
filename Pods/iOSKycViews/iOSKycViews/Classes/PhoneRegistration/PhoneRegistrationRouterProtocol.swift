//
//  PhoneRegistrationRouterProtocol.swift
//
//  Created by Nik, 1/01/2020
//

import RxSwift

public protocol PhoneRegistrationRouterProtocol {
    func finish()
    func restrictedCountry()
    var clearPhone : PublishSubject<Void> { get }
}
