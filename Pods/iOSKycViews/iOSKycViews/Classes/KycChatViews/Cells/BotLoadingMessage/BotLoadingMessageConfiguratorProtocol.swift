//
//  BotLoadingMessageConfiguratorProtocol.swift
//
//  Created by Nik, 21/01/2020
//

import iOSBaseViews
import MaterialComponents.MaterialActivityIndicator

public protocol BotLoadingMessageConfiguratorProtocol {
    var verticalMargin : CGFloat { get }
    var horizontalMargin : CGFloat { get }
    var avatarMargin : CGFloat { get }
    var botAvatarImageFactory : ConfigurationFactory<UIImageView> { get }
    var containerBackgroundColor : UIColor { get }
    var containerRadius : CGFloat { get }
    var activityIndicatorFactory : Factory<MDCActivityIndicator> { get }
}
