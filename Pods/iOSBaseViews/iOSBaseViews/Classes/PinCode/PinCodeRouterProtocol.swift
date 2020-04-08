//
//  PinCodeRouterProtocol.swift
//
//  Created by Nik, 4/01/2020
//

import Foundation

public protocol PinCodeRouterProtocol {
    var finish : (() -> ())? { get }
    var showPolicy : (() -> ())? { get }
    var showBiometrics : (() -> ())? { get }
    var showForgot : (() -> ())? { get }
}
