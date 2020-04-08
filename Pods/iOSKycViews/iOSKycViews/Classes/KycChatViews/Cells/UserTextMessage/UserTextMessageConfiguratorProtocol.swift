//
//  UserTextMessageConfiguratorProtocol.swift
//
//  Created by Nik, 17/01/2020
//

import UIKit

public protocol UserTextMessageConfiguratorProtocol {
    var verticalMargin : CGFloat { get }
    var horizontalMargin : CGFloat { get }
    var textFont : UIFont { get }
    var textColor : UIColor { get }
    var textContainerColor : UIColor { get }
    var containerShadowColor : UIColor { get }
    var textContainerRadius : CGFloat { get }
}
