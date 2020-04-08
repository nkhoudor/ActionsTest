//
//  ErrorWarningInfoPresenterProtocol.swift
//
//  Created by Nik, 11/02/2020
//

import Foundation

public protocol ErrorWarningInfoPresenterProtocol {
    var configurator : ErrorWarningInfoConfiguratorProtocol { get }
    func viewDidLoad(view: ErrorWarningInfoViewProtocol)
    
}
