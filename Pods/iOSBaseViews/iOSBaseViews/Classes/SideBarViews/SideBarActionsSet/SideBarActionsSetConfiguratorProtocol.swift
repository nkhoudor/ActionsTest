//
//  SideBarActionsSetConfiguratorProtocol.swift
//
//  Created by Nik, 8/01/2020
//

import Foundation

public protocol SideBarActionsSetConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var actionIconViewRadius : CGFloat { get }
    var actionIconBackgroundColor : UIColor { get }
    var actionIconFactories : [ConfigurationFactory<UIImageView>] { get }
}
