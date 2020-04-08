//
//  NewDeviceAuthConfiguratorProtocol.swift
//
//  Created by Nik, 8/02/2020
//

import iOSBaseViews

public protocol NewDeviceAuthConfiguratorProtocol {
    var titleFactory : Factory<UILabel> { get }
    var subtitleFactory : Factory<UILabel>  { get }
    var deviceImageConfigurationFactory : ConfigurationFactory<UIImageView> { get }
    var confirmButtonFactory : Factory<UIButton> { get }
    var confirmButtonTitle : String { get }
    var disableConfirmButtonConfigurationFacory : ConfigurationFactory<UIButton> { get }
    var enableConfirmButtonConfigurationFacory : ConfigurationFactory<UIButton> { get }
    var denyButtonFactory : Factory<UIButton> { get }
}
