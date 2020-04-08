//
//  KYCUtilityBillRouter.swift
//  iOSKyc
//
//  Created by Nik on 22/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import iOSKycViews

class KYCUtilityBillActionRouter : PhotoActionRouter {
    let viewModel : AddressViewModel
    
    init(chatFlowService : ChatFlowService, viewModel : AddressViewModel) {
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
            self?.viewModel.images.append(photoData)
            self?.chatFlowService.state.accept(.UTILITY_BILL_USER_PHOTO(photoData: photoData, showDescription: true, limitReached: false))
        }
        
        let vc = MaskCameraVC.createInstance(presenter: MaskCameraPresenter(interactor: MaskCameraInteractor(), router: router, configurator: UtilityBillMaskCameraConfigurator()))
        
        swipeVC = SwipeModalVC(presentedVC: vc, configurator: SwipeModalConfigurator())
        swipeVC!.modalPresentationStyle = .overCurrentContext
        swipeVC!.modalTransitionStyle = .coverVertical
        resolver.resolve(UINavigationController.self)?.visibleViewController?.present(swipeVC!, animated: true, completion: nil)
    }
    
    override func secondButton() {}
}
