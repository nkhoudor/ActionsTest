//
//  BotTextMessageViewProtocol.swift
//
//  Created by Nik, 16/01/2020
//

import iOSBaseViews

public protocol BotTextMessageViewProtocol : class {
    func update(text: String)
    func update(avatarVisible: Bool)
    func update(warningVisible: Bool)
    func update(images: [ConfigurationFactory<UIImageView>])
    func getImages() -> [UIImage]
}
