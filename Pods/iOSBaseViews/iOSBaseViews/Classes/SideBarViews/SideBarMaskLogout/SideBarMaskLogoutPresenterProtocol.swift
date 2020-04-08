//
//  SideBarMaskLogoutPresenterProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol SideBarMaskLogoutPresenterProtocol {
    var configurator : SideBarMaskLogoutConfiguratorProtocol { get }
    func viewDidLoad(view: SideBarMaskLogoutViewProtocol)
    func logoutPressed()
    func maskSwitchChanged(isOn: Bool)
}
