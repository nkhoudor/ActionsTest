//
//  SideBarActionsSetPresenterProtocol.swift
//
//  Created by Nik, 8/01/2020
//

import Foundation

public protocol SideBarActionsSetPresenterProtocol {
    var configurator : SideBarActionsSetConfiguratorProtocol { get }
    func viewDidLoad(view: SideBarActionsSetViewProtocol)
    
}
