//
//  AddressInfoConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 23/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject
import iOSKycViews

class AddressInfoConfigurator : AddressInfoConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "ADDRESS_INFO")!
    }()
    
    var containerBackgroundColor: UIColor = .white
    
    var containerCornerRadius: CGFloat = 4
    
    var shadowColor: UIColor = UIColor.Theme.mainBlackColor
    
    var topLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("TOP_LABEL")
    }
    
    var mainLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("MAIN_LABEL")
    }
    
    var myAddressButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("MY_ADDRESS")
    }
    
    
}
