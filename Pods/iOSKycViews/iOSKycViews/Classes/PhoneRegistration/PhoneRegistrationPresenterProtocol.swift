//
//  PhoneRegistrationPresenterProtocol.swift
//
//  Created by Nik, 1/01/2020
//

import Foundation

public protocol PhoneRegistrationPresenterProtocol {
    var configurator : PhoneRegistrationConfiguratorProtocol { get }
    func viewDidLoad(view: PhoneRegistrationViewProtocol)
    func registerPhone(phone: String)
}
