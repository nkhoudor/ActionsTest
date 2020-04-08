//
//  HalfSceenModalConfiguratorProtocol.swift
//
//  Created by Nik, 30/01/2020
//

public protocol HalfSceenModalConfiguratorProtocol {
    var coverRatio : CGFloat { get }
    var backgroundColor : UIColor { get }
    var coverColor : UIColor { get }
    var cornerRadius : CGFloat { get }
    var topArrowImageViewFactory : ConfigurationFactory<UIImageView> { get }
    var titleLabelFactory : Factory<UILabel>? { get }
    var titleUnderlineColor : UIColor? { get }
    var titleUnderlineFactory: Factory<UIView>? { get }
}
