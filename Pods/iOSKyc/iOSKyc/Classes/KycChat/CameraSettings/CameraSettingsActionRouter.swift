//
//  CameraSettingsActionRouter.swift
//  iOSKyc
//
//  Created by Nik on 19/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration
import iOSBaseViews
import iOSKycSDK
import RxSwift
import AVFoundation
import iOSKycViews

class CameraSettingsActionRouter : ChatActionRouterProtocol {
    
    var timer : Timer?
    let chatFlowService : ChatFlowService
    
    init(chatFlowService : ChatFlowService) {
        self.chatFlowService = chatFlowService
    }
    
    func firstButton() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    func secondButton() {}
}

