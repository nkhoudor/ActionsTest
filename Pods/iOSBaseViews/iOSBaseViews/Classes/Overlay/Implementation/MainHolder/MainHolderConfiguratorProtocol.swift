//
//  MainHolderConfiguratorProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol MainHolderConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var contentViewRadius : CGFloat { get }
    var backImageFactory : ConfigurationFactory<UIImageView>? { get }
    var topArrowImageFactory : ConfigurationFactory<UIImageView> { get }
    var closeImageFactory : ConfigurationFactory<UIImageView>? { get }
    var nameLabelFactory : Factory<UILabel>? { get }
    var headerLabelFactory : (labelFactory: Factory<UILabel>, backgroundColor: UIColor, underlineColor: UIColor)? { get }
    var mainVCFactory : Factory<UIViewController> { get }
}

public extension MainHolderConfiguratorProtocol {
    var headerLabelFactory : (labelFactory: Factory<UILabel>, backgroundColor: UIColor, underlineColor: UIColor)? {
        nil
    }
}
