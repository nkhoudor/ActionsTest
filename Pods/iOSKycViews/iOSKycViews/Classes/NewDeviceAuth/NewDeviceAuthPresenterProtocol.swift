//
//  NewDeviceAuthPresenterProtocol.swift
//
//  Created by Nik, 8/02/2020
//

import Foundation

public protocol NewDeviceAuthPresenterProtocol {
    var configurator : NewDeviceAuthConfiguratorProtocol { get }
    func viewDidLoad(view: NewDeviceAuthViewProtocol)
    func viewDidAppear()
    func viewDidDisappear()
    func confirmPressed()
    func denyPressed()
}
