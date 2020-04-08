//
//  KYCUtilityBillMoreRouter.swift
//  iOSKyc
//
//  Created by Nik on 22/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import AVFoundation
import iOSKycViews

class KYCUtilityBillMoreActionRouter : ChatActionRouterProtocol {
    let chatFlowService : ChatFlowService
    let viewModel : AddressViewModel
    
    init(chatFlowService : ChatFlowService, viewModel : AddressViewModel) {
        self.chatFlowService = chatFlowService
        self.viewModel = viewModel
    }
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    var swipeVC : UIViewController?
    
    func firstButton() {
        chatFlowService.state.accept(.BOT_ADDRESS_UTILITY_BILL_DESCRIPTION)
    }
    
    func photoAction() {
        let router = MaskCameraRouter()
        router.imageTaken = { [weak self] photoData in
            self?.swipeVC?.dismiss(animated: true, completion: nil)
            self?.swipeVC = nil
            if let viewModel = self?.viewModel {
                viewModel.images.append(photoData)
                self?.chatFlowService.state.accept(.UTILITY_BILL_USER_PHOTO(photoData: photoData, showDescription: false, limitReached: viewModel.images.count >= 4))
            }
        }
        
        let vc = MaskCameraVC.createInstance(presenter: MaskCameraPresenter(interactor: MaskCameraInteractor(), router: router, configurator: UtilityBillMaskCameraConfigurator()))
        
        swipeVC = SwipeModalVC(presentedVC: vc, configurator: SwipeModalConfigurator())
        swipeVC!.modalPresentationStyle = .overCurrentContext
        swipeVC!.modalTransitionStyle = .coverVertical
        resolver.resolve(UINavigationController.self)?.visibleViewController?.present(swipeVC!, animated: true, completion: nil)
    }
    
    func secondButton() {
        
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            photoAction()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {[weak self] (granted: Bool) in
                DispatchQueue.main.async {
                    if granted {
                        self?.photoAction()
                    } else {
                        self?.chatFlowService.messagesChange.onNext([.delete(1)])
                        self?.chatFlowService.state.accept(.CAMERA_SETTINGS_DESCRIPTION)
                    }
                }
            })
        }
    }
}
