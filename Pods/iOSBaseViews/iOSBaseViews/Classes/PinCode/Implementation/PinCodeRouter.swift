//
//  PinCodeRouter.swift
//
//  Created by Nik, 4/01/2020
//

import Foundation

public class PinCodeRouter : PinCodeRouterProtocol {
    public var finish: (() -> ())?
    
    public var showPolicy: (() -> ())?
    
    public var showBiometrics: (() -> ())?
    
    public var showForgot: (() -> ())?
    
    public init() {}
}
