//
//  BotTextMessageInteractor.swift
//  iOSKyc
//
//  Created by Nik on 19/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation

public class BotTextMessageInteractor : BotTextMessageInteractorProtocol {
    public var botTextMessage : BotTextMessageEntity
    
    public init(botTextMessage : BotTextMessageEntity) {
        self.botTextMessage = botTextMessage
    }
}
