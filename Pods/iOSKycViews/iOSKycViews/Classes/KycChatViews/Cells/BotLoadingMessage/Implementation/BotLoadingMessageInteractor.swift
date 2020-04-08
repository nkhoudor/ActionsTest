//
//  BotLoadingMessageInteractor.swift
//
//  Created by Nik, 21/01/2020
//

import Foundation

open class BotLoadingMessageInteractor : BotLoadingMessageInteractorProtocol {
    public var botLoadingMessage : BotLoadingMessageEntity
    
    public init(botLoadingMessage : BotLoadingMessageEntity) {
        self.botLoadingMessage = botLoadingMessage
    }
}
