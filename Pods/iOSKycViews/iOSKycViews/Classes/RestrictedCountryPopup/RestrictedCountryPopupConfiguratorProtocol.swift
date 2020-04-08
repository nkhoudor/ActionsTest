//
//  RestrictedCountryPopupConfiguratorProtocol.swift
//
//  Created by Nik, 30/01/2020
//

import iOSBaseViews

public protocol RestrictedCountryPopupConfiguratorProtocol {
    var infoImageViewFactory : ConfigurationFactory<UIImageView> { get }
    var descriptionLabelFactory : Factory<UILabel> { get }
    var changeNumberButtonFactory : Factory<UIButton> { get }
    var psTextViewFactory : Factory<UITextView> { get }
}
