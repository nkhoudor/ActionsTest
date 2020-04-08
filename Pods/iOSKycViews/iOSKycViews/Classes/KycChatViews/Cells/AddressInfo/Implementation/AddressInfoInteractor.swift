//
//  AddressInfoInteractor.swift
//
//  Created by Nik, 23/01/2020
//

import Foundation

public class AddressInfoInteractor : AddressInfoInteractorProtocol {
    public var addressInfoMessage: AddressInfoMessageEntity
    
    public init(addressInfoMessage: AddressInfoMessageEntity) {
        self.addressInfoMessage = addressInfoMessage
    }
    
}
