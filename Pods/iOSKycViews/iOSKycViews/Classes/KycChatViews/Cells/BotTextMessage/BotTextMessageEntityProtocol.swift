//
//  BotTextMessageEntityProtocol.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation

public protocol BotTextMessageEntityProtocol {
    func getText() -> String
    func getAvatarVisible() -> Bool
    func getWarningVisible() -> Bool
}
