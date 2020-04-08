//
//  PinCodeViewProtocol.swift
//
//  Created by Nik, 4/01/2020
//

import Foundation

public enum PinCodeViewState {
    case normal
    case error
    case success
}

public protocol PinCodeViewProtocol : class {
    func changeState(_ state: PinCodeViewState)
}
