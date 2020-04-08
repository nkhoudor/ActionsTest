//
//  FullScreenImageSlideshowConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 21/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews

public protocol FullScreenImageSlideshowConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var maskColor : UIColor { get }
    var bottomItemMaskColor : UIColor { get }
    var bottomItemCornerRadius : CGFloat { get }
    var imageLabelFactory : Factory<UILabel> { get }
}
