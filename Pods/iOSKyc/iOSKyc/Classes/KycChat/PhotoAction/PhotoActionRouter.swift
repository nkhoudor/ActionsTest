//
//  PhotoActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 23/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import iOSBaseViews
import AVFoundation
import iOSKycViews

class PhotoActionRouter : ChatActionRouterProtocol {
    let chatFlowService : ChatFlowService
    
    init(chatFlowService : ChatFlowService) {
        self.chatFlowService = chatFlowService
    }
    
    func photoAction() {
        
    }
    
    func firstButton() {
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
    
    func secondButton() {}
}
