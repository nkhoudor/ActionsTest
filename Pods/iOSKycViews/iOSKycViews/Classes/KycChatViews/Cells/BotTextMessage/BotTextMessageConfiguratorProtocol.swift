//
//  BotTextMessageConfiguratorProtocol.swift
//
//  Created by Nik, 16/01/2020
//

import Foundation
import iOSBaseViews

public protocol BotTextMessageConfiguratorProtocol {
    var verticalMargin : CGFloat { get }
    var horizontalMargin : CGFloat { get }
    var avatarMargin : CGFloat { get }
    var botAvatarImageFactory : ConfigurationFactory<UIImageView> { get }
    var textFont : UIFont { get }
    var textColor : UIColor { get }
    var textBackgroundColor : UIColor { get }
    var textContainerRadius : CGFloat { get }
    var maskImageViewFactory : Factory<MaskImageView>? { get }
    var warningColor : UIColor { get }
    var warningWidth : CGFloat { get }
    var warningCornerRadius : CGFloat { get }
}
