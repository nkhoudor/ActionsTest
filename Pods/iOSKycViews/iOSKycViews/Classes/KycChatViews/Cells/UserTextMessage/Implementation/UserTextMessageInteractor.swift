//
//  UserTextMessageInteractor.swift
//  iOSKyc
//
//  Created by Nik on 19/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation

public class UserTextMessageInteractor : UserTextMessageInteractorProtocol {
    public var userTextMessage: UserTextMessageEntity
    
    public init(userTextMessage: UserTextMessageEntity) {
        self.userTextMessage = userTextMessage
    }
    
}
