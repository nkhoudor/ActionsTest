//
//  CongratulationsConfiguratorProtocol.swift
//
//  Created by Nik, 23/01/2020
//

import iOSBaseViews

public protocol CongratulationsConfiguratorProtocol {
    var containerBackgroundColor : UIColor { get }
    var containerCornerRadius : CGFloat { get }
    var shadowColor : UIColor { get }
    var successImageConfigurationFactory : ConfigurationFactory<UIImageView> { get }
    var titleLabelFactory : Factory<UILabel> { get }
    var descriptionLabelFactory : Factory<UILabel> { get }
    var whatsNextButtonFactory : Factory<UIButton>? { get }
}
