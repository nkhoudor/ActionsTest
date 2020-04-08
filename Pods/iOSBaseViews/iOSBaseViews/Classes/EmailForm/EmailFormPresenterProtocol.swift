//
//  EmailFormPresenterProtocol.swift
//
//  Created by Nik, 29/01/2020
//

import Foundation

public protocol EmailFormPresenterProtocol {
    var configurator : EmailFormConfiguratorProtocol { get }
    func viewDidLoad(view: EmailFormViewProtocol)
    func submitPressed(_ email: String)
}
