//
//  PinCodePresenterProtocol.swift
//
//  Created by Nik, 4/01/2020
//

import Foundation

public protocol PinCodePresenterProtocol {
    var configurator : PinCodeConfiguratorProtocol { get }
    func viewDidLoad(view: PinCodeViewProtocol)
    func pinCodeEntered(_ pinCode: String)
    func policyPressed()
    func biometricsPressed()
    func forgotPressed()
}
