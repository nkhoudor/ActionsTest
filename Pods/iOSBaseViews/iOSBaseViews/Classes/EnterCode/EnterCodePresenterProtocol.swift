//
//  EnterCodePresenterProtocol.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation

public protocol EnterCodePresenterProtocol {
    var configurator : EnterCodeConfiguratorProtocol { get }
    func viewDidLoad(view: EnterCodeViewProtocol)
    func codeEntered(_ code: String)
    func resendPressed()
}
