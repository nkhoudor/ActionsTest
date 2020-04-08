//
//  KYCChooseDocumentRouter.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit
import iOSKycViews

class KYCChooseDocumentRouter : ChatActionRouterProtocol {
    var chatFlowService : ChatFlowService!
    
    init(chatFlowService : ChatFlowService) {
        self.chatFlowService = chatFlowService
    }
    
    func firstButton() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Passport", style: . default, handler: { [weak self] _ in
            self?.chatFlowService.state.accept(.CHOOSE_PASSPORT_USER_MESSAGE)
        }))
        alert.addAction(UIAlertAction(title: "Driver license", style: . default, handler: { [weak self] _ in
            self?.chatFlowService.state.accept(.CHOOSE_DRIVER_LICENSE_USER_MESSAGE)
        }))
        alert.addAction(UIAlertAction(title: "ID Card", style: . default, handler: { [weak self] _ in
            self?.chatFlowService.state.accept(.CHOOSE_ID_CARD_USER_MESSAGE)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func secondButton() {}
}
