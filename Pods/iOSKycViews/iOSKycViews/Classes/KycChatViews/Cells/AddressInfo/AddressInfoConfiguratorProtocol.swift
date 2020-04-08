//
//  AddressInfoConfiguratorProtocol.swift
//
//  Created by Nik, 23/01/2020
//

import iOSBaseViews

public protocol AddressInfoConfiguratorProtocol {
    var containerBackgroundColor : UIColor { get }
    var containerCornerRadius : CGFloat { get }
    var shadowColor : UIColor { get }
    var topLabelFactory : Factory<UILabel> { get }
    var mainLabelFactory : Factory<UILabel> { get }
    var myAddressButtonFactory : Factory<UIButton> { get }
}
