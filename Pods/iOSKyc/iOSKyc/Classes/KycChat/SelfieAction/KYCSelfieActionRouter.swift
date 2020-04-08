//
//  SelfieActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 19/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation

import Swinject
import iOSBaseViews
import iOSKycViews

class KYCSelfiePhotoActionRouter : PhotoActionRouter {
    let viewModel : DocumentViewModel
    
    init(chatFlowService : ChatFlowService, viewModel : DocumentViewModel) {
        self.viewModel = viewModel
        super.init(chatFlowService: chatFlowService)
    }
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    var swipeVC : UIViewController?
    
    override func photoAction() {
        let router = MaskCameraRouter()
        router.imageTaken = { [weak self] photoData in
            self?.swipeVC?.dismiss(animated: true, completion: nil)
            self?.swipeVC = nil
            self?.viewModel.faceImageFile = photoData
            self?.chatFlowService.state.accept(.SELFIE_PHOTO_TAKEN(photoData: photoData))
        }
        
        let vc = MaskCameraVC.createInstance(presenter: MaskCameraPresenter(interactor: MaskCameraInteractor(), router: router, configurator: SelfieMaskCameraConfigurator()))
        
        swipeVC = SwipeModalVC(presentedVC: vc, configurator: SwipeModalConfigurator())
        swipeVC!.modalPresentationStyle = .overCurrentContext
        swipeVC!.modalTransitionStyle = .coverVertical
        resolver.resolve(UINavigationController.self)?.visibleViewController?.present(swipeVC!, animated: true, completion: nil)
    }
    
    override func secondButton() {}
}
