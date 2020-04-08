//
//  ChatActionConfiguratorProtocol.swift
//
//  Created by Nik, 17/01/2020
//

import iOSBaseViews

public protocol ChatActionConfiguratorProtocol {
    var firstButtonFactory : Factory<UIButton> { get }
    var secondButtonFactory : Factory<UIButton>? { get }
    var bottomMargin : CGFloat { get }
}
