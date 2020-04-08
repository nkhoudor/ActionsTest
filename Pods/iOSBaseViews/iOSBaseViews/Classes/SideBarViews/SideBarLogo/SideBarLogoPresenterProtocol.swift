//
//  SideBarLogoPresenterProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol SideBarLogoPresenterProtocol {
    var configurator : SideBarLogoConfiguratorProtocol { get }
    func viewDidLoad(view: SideBarLogoViewProtocol)
}
