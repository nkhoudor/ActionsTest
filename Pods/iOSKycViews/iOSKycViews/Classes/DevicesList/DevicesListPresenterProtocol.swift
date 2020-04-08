//
//  DevicesListPresenterProtocol.swift
//
//  Created by Nik, 26/01/2020
//

import Foundation

public protocol DevicesListPresenterProtocol {
    var configurator : DevicesListConfiguratorProtocol { get }
    func viewDidLoad(view: DevicesListViewProtocol)
    func sendPressed()
    func recoverPressed()
}
