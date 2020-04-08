//
//  TestModulePresenterProtocol.swift
//
//  Created by Nik, 7/01/2020
//

import Foundation

public protocol TestModulePresenterProtocol {
    var configurator : TestModuleConfiguratorProtocol { get }
    func viewDidLoad(view: TestModuleViewProtocol)
    
}
