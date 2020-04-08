//
//  KYCUserPhotoRouter.swift
//  iOSKyc
//
//  Created by Nik on 20/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject
import iOSKycViews

class KYCUserPhotoRouter : UserPhotoRouterProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    func showImage(_ image: UIImage) {
        guard let messages = resolver.resolve(ChatFlowService.self)?.messages else { return }
        
        var slideElements : [SlideshowEntity] = []
        
        for case let photoMessage as UserPhotoMessage in messages {
            if let image = UIImage(data: photoMessage.photo.value) {
                slideElements.append(SlideshowEntity(image: image, text: photoMessage.name.value))
            }
        }
        
        guard slideElements.count > 0 else { return }
        
        let vc = FullScreenImageSlideshowVC.createInstance(entities: slideElements, configurator: FullScreenImageSlideshowConfigurator())
        
        let swipeVC = SwipeModalVC(presentedVC: vc, configurator: SwipeModalConfigurator())
        swipeVC.modalPresentationStyle = .overCurrentContext
        swipeVC.modalTransitionStyle = .coverVertical
        resolver.resolve(UINavigationController.self)?.visibleViewController?.present(swipeVC, animated: true, completion: nil)
    }
}
