//
//  BotLoadingMessagePresenterProtocol.swift
//
//  Created by Nik, 21/01/2020
//

import Foundation

public protocol BotLoadingMessagePresenterProtocol {
    var configurator : BotLoadingMessageConfiguratorProtocol { get }
    func viewDidLoad(view: BotLoadingMessageViewProtocol)
    
}
