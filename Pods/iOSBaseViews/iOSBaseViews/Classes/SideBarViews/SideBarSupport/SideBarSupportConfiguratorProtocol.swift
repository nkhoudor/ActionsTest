//
//  SideBarSupportConfiguratorProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol SideBarSupportConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var contentViewBackgroundColor : UIColor { get }
    var contentViewMargin : CGFloat { get }
    var contentViewRadius : CGFloat { get }
    var imageBackgroundColor : UIColor { get }
    var supportImageFactory : ConfigurationFactory<UIImageView> { get }
    var supportLabelFactory : Factory<UILabel> { get }
}
