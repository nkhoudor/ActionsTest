//
//  SideBarSupportPresenterProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol SideBarSupportPresenterProtocol {
    var configurator : SideBarSupportConfiguratorProtocol { get }
    func viewDidLoad(view: SideBarSupportViewProtocol)
    func supportPressed()
}
