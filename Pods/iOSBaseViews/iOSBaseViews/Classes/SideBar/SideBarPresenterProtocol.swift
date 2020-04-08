//
//  SideBarPresenterProtocol.swift
//
//  Created by Nik, 8/01/2020
//

import Foundation

public protocol SideBarPresenterProtocol {
    var configurator : SideBarConfiguratorProtocol { get }
    func viewDidLoad(view: SideBarViewProtocol)
    
}
