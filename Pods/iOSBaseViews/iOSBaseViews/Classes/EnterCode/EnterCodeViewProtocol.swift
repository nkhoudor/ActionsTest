//
//  EnterCodeViewProtocol.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation

public enum EnterCodeViewState {
    case normal
    case error
    case error_description
    case success
    case clear
    case loading
}

public enum ResendState {
    case allowed
    case resend(seconds: Int)
}

public protocol EnterCodeViewProtocol : class {
    func changeState(_ state: EnterCodeViewState)
    func changeResendState(_ state: ResendState)
}
