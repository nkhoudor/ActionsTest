//
//  PhoneRegistrationRouter.swift
//
//  Created by Nik, 1/01/2020
//

import RxSwift

public class PhoneRegistrationRouter : PhoneRegistrationRouterProtocol {
    public init() {}
    public func finish() {}
    public func restrictedCountry() {}
    public var clearPhone: PublishSubject<Void> = PublishSubject()
}
