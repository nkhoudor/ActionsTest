//
//  DevicesListConfiguratorProtocol.swift
//
//  Created by Nik, 26/01/2020
//

import iOSBaseViews

public protocol DevicesListConfiguratorProtocol {
    var titleLabelFactory: Factory<UILabel> { get }
    var cellNameConfigurationFactory: ConfigurationFactory<UILabel> { get }
    var cellDescriptionConfigurationFactory: ConfigurationFactory<UILabel> { get }
    
    var sendButtonBackgroundColor : UIColor { get }
    var sendButtonShadowColor : UIColor { get }
    var sendButtonProhibitedColor : UIColor { get }
    var sendButtonCornerRadius : CGFloat { get }
    
    var sendLabelFactory : Factory<UILabel> { get }
    var resendLabelFactory : Factory<UILabel> { get }
    var resendInLabelFactory : Factory<UILabel> { get }
    
    var recoverButtonFactory : Factory<UIButton> { get }
}
