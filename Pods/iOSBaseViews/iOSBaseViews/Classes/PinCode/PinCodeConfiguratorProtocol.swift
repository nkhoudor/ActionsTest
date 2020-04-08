//
//  PinCodeConfiguratorProtocol.swift
//  iOSBaseViews
//
//  Created by Nik on 04/01/2020.
//

import Foundation

public protocol PinCodeConfiguratorProtocol {
    var digitButtonFactory : Factory<DigitButton> { get }
    var dotFactory : Factory<DotView> { get }
    var errorLabelFactory : Factory<UILabel> { get }
    var eraseButtonImageFactory : ConfigurationFactory<UIButton> { get }
    
    ///Nil for invisible logo. Choose logo or title
    var logoImageFactory : ConfigurationFactory<UIImageView>? { get }
    ///Nil for invisible title. Choose logo or title
    var titleLabelFactory : Factory<UILabel>? { get }
    ///Nil for invisible subtitle
    var subtitleLabelFactory : Factory<UILabel>? { get }
    
    var policyButtonFactory : ConfigurationFactory<UIButton>? { get }
    
    var biometricsButtonFactory : ConfigurationFactory<UIButton>? { get }
    
    var forgotButtonFactory : Factory<UIButton>? { get }
    
    var backgroundColor : UIColor { get }
}
