//
//  SideBarLogoConfiguratorProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol SideBarLogoConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var logoImageFactory : ConfigurationFactory<UIImageView> { get }
}
