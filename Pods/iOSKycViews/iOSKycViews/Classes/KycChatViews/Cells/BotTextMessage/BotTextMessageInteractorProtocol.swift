//
//  BotTextMessageInteractorProtocol.swift
//
//  Created by Nik, 16/01/2020
//

import Foundation
import RxSwift
import RxRelay

public protocol BotTextMessageInteractorProtocol {
    var botTextMessage : BotTextMessageEntity { get }
}
