//
//  KYCCongratulationsInteractor.swift
//  iOSKyc
//
//  Created by Nik on 04/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import iOSKycViews

class KYCCongratulationsInteractor : CongratulationsInteractorProtocol {
    
    let stateService: ScreenStateService
    
    init(stateService: ScreenStateService) {
        self.stateService = stateService
    }
    
    func whatsNext() {
        stateService.pinCodeVerified()
    }
}
