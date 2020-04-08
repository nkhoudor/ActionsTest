//
//  CreatePinViewModel.swift
//  iOSKyc
//
//  Created by Nik on 24/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSKycSDK

class CreatePinViewModel {
    var storage : IKycStorage
    var pinCode : String = ""
    
    init(storage: IKycStorage) {
        self.storage = storage
    }
    
    func validate(pinCode: String) -> Bool {
        if self.pinCode == pinCode {
            storage.pinHash = pinCode
            return true
        }
        return false
    }
}
