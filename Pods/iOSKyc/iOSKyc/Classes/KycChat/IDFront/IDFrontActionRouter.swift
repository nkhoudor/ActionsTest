//
//  DriverLicenseFrontActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews

class IDFrontActionRouter : PhotoActionRouter {
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
            self?.viewModel.documentType = .idCard
            self?.viewModel.frontImageFile = photoData
            self?.chatFlowService.state.accept(.ID_FRONT_TAKEN(photoData: photoData))
        }
        
        let vc = MaskCameraVC.createInstance(presenter: MaskCameraPresenter(interactor: MaskCameraInteractor(), router: router, configurator: IDFrontMaskCameraConfigurator()))
        
        swipeVC = SwipeModalVC(presentedVC: vc, configurator: SwipeModalConfigurator())
        swipeVC!.modalPresentationStyle = .overCurrentContext
        swipeVC!.modalTransitionStyle = .coverVertical
        resolver.resolve(UINavigationController.self)?.visibleViewController?.present(swipeVC!, animated: true, completion: nil)
    }
    
    override func secondButton() {
        chatFlowService.state.accept(.CHOOSE_TYPE_OF_DOCUMENT(deleteCount: 3))
    }
}
