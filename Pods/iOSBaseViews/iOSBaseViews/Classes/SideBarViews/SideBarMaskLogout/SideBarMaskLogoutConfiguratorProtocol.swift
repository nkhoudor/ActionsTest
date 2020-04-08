//
//  SideBarMaskLogoutConfiguratorProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol SideBarMaskLogoutConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var contentViewBackgroundColor : UIColor { get }
    var contentViewMargin : CGFloat { get }
    var contentViewRadius : CGFloat { get }
    var maskSwitchFactory : Factory<UISwitch> { get }
    var imageBackgroundColor : UIColor { get }
    var maskImageFactory : ConfigurationFactory<UIImageView> { get }
    var logoutImageFactory : ConfigurationFactory<UIImageView>? { get }
    var maskLabelFactory : Factory<UILabel> { get }
    var logoutLabelFactory : Factory<UILabel>? { get }
}
