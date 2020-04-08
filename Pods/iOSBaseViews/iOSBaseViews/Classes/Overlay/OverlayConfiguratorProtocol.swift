//
//  OverlayConfiguratorProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol OverlayConfiguratorProtocol {
    var sideBarFactory : Factory<UIViewController> { get }
    var mainFactory : Factory<MainHolderConfiguratorProtocol> { get }
}
