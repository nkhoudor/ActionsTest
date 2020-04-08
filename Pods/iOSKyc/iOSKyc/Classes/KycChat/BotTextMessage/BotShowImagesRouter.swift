//
//  BotShowImagesRouter.swift
//  iOSKyc
//
//  Created by Nik on 21/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews

class FullScreenImageSlideshowConfigurator : FullScreenImageSlideshowConfiguratorProtocol {
    var imageLabelFactory: Factory<UILabel> {
        return UILabel.getFactory(font: UIFont.Theme.font, textColor: .white, text: nil)
    }
    
    var bottomItemMaskColor: UIColor = UIColor.Theme.gray50
    
    var bottomItemCornerRadius: CGFloat = 4
    
    var maskColor: UIColor = UIColor.Theme.gray50
    
    var backgroundColor: UIColor = .black
}

class BotShowImagesRouter : BotTextMessageRouterProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    func showImages(_ images: [UIImage]) {
        let vc = FullScreenImageSlideshowVC.createInstance(entities: images.map({ SlideshowEntity(image: $0, text: "GAZ BILL") }), configurator: FullScreenImageSlideshowConfigurator())
        
        let swipeVC = SwipeModalVC(presentedVC: vc, configurator: SwipeModalConfigurator())
        swipeVC.modalPresentationStyle = .overCurrentContext
        swipeVC.modalTransitionStyle = .coverVertical
        resolver.resolve(UINavigationController.self)?.visibleViewController?.present(swipeVC, animated: true, completion: nil)
    }
}
