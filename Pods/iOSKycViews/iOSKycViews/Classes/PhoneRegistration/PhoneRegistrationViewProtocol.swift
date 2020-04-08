//
//  PhoneRegistrationViewProtocol.swift
//
//  Created by Nik, 1/01/2020
//

import Foundation

public enum PhoneRegistrationViewState {
    case normal
    case loading
    case error
    case success
}

public protocol PhoneRegistrationViewProtocol : class {
    func changeState(_ state: PhoneRegistrationViewState)
}
