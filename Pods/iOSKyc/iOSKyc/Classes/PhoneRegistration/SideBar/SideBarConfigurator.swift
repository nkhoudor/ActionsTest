//
//  SideBarConfigurator.swift
//  iOSBaseViews_Example
//
//  Created by Nik on 06/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import iOSBaseViews

class SideBarConfigurator : ScrollStackConfiguratorProtocol {
    
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    
    var modules: [Factory<UIViewController>]
    lazy var margins: [CGFloat] = {
        return [0, 15.0, 36.0, 16.0, 0.0]
    }()
    
    var backgroundColor: UIColor = UIColor.Theme.sideBarBackground
    
    init() {
        let vc1Factory : () -> UIViewController = {
            return SideBarActionsSetVC.createInstance(configurator: SideBarActionsConfigurator())
        }
        let vc2Factory : () -> UIViewController = {
            return SideBarLogoVC.createInstance(configurator: SideBarLogoConfigurator())
        }
        
        let vc3Factory : () -> UIViewController = {
            return SideBarMaskLogoutVC.createInstance(presenter: SideBarMaskLogoutPresenter(interactor: SideBarMaskLogoutInteractor(), router: SideBarMaskLogoutRouter(), configurator: SideBarMaskLogoutConfigurator()))
        }
        
        let vc4Factory : () -> UIViewController = {
            return SideBarSupportVC.createInstance(presenter: SideBarSupportPresenter(interactor: SideBarSupportInteractor(), router: SideBarSupportRouter(), configurator: SideBarSupportConfigurator()))
        }
        modules = [vc1Factory, vc2Factory, vc3Factory, vc4Factory]
    }
    
    
}
