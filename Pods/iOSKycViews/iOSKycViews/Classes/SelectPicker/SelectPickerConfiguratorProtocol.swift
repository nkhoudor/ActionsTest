//
//  SelectPickerConfiguratorProtocol.swift
//
//  Created by Nik, 24/02/2020
//

import iOSBaseViews

public protocol SelectPickerConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var valueLabelConfigurationFactory : ConfigurationFactory<UILabel> { get }
}
