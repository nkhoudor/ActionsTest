//
//  BotTextMessagePresenterProtocol.swift
//
//  Created by Nik, 16/01/2020
//

import Foundation

public protocol BotTextMessagePresenterProtocol {
    var configurator : BotTextMessageConfiguratorProtocol { get }
    func viewDidLoad(view: BotTextMessageViewProtocol)
    func showImagesPressed()
}
