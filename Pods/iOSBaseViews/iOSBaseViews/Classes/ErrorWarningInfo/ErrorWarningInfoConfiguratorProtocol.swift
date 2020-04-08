//
//  ErrorWarningInfoConfiguratorProtocol.swift
//
//  Created by Nik, 11/02/2020
//

import iOSBaseViews

public protocol ErrorWarningInfoConfiguratorProtocol {
    var imageConfigurationFactory : ConfigurationFactory<UIImageView>? { get }
    var titleFactory : Factory<UILabel> { get }
    var subtitleFactory : Factory<UILabel>? { get }
    var bottomTextViewFactory : Factory<UITextView>? { get }
    var backgroundColor : UIColor { get }
}
