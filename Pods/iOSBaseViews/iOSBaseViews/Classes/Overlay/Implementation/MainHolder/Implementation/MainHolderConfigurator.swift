//
//  MainHolderConfigurator.swift
//  iOSBaseViews
//
//  Created by Nik on 09/01/2020.
//

import Foundation

public class MainHolderConfigurator : MainHolderConfiguratorProtocol {
    public var backgroundColor: UIColor
    public var contentViewRadius: CGFloat
    public var backImageFactory: ConfigurationFactory<UIImageView>?
    public var topArrowImageFactory: ConfigurationFactory<UIImageView>
    public var closeImageFactory: ConfigurationFactory<UIImageView>?
    public var nameLabelFactory: Factory<UILabel>?
    public var headerLabelFactory : (labelFactory: Factory<UILabel>, backgroundColor: UIColor, underlineColor: UIColor)?
    public var mainVCFactory: Factory<UIViewController>
    
    public init(backgroundColor: UIColor, contentViewRadius: CGFloat, backImageFactory: ConfigurationFactory<UIImageView>?, topArrowImageFactory: @escaping ConfigurationFactory<UIImageView>, closeImageFactory: ConfigurationFactory<UIImageView>?, nameLabelFactory: Factory<UILabel>?, headerLabelFactory : (labelFactory: Factory<UILabel>, backgroundColor: UIColor, underlineColor: UIColor)? = nil, mainVCFactory: @escaping Factory<UIViewController>) {
        self.backgroundColor = backgroundColor
        self.contentViewRadius = contentViewRadius
        self.backImageFactory = backImageFactory
        self.topArrowImageFactory = topArrowImageFactory
        self.closeImageFactory = closeImageFactory
        self.nameLabelFactory = nameLabelFactory
        self.headerLabelFactory = headerLabelFactory
        self.mainVCFactory = mainVCFactory
    }
}

public extension MainHolderConfigurator {
    static func getFactory(backgroundColor: UIColor, contentViewRadius: CGFloat, backImageFactory: ConfigurationFactory<UIImageView>?, topArrowImageFactory: @escaping ConfigurationFactory<UIImageView>, closeImageFactory: ConfigurationFactory<UIImageView>?, nameLabelFactory: Factory<UILabel>?, headerLabelFactory : (labelFactory: Factory<UILabel>, backgroundColor: UIColor, underlineColor: UIColor)? = nil, mainVCFactory: @escaping Factory<UIViewController>) -> Factory<MainHolderConfiguratorProtocol> {
        let factory = { () -> MainHolderConfiguratorProtocol in
            return MainHolderConfigurator(backgroundColor: backgroundColor, contentViewRadius: contentViewRadius, backImageFactory: backImageFactory, topArrowImageFactory: topArrowImageFactory, closeImageFactory: closeImageFactory, nameLabelFactory: nameLabelFactory, headerLabelFactory : headerLabelFactory, mainVCFactory: mainVCFactory)
        }
        return factory
    }
}
