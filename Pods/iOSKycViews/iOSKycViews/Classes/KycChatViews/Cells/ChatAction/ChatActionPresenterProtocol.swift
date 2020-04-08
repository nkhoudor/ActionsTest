//
//  ChatActionPresenterProtocol.swift
//
//  Created by Nik, 17/01/2020
//

import Foundation

public protocol ChatActionPresenterProtocol {
    var configurator : ChatActionConfiguratorProtocol { get }
    func viewDidLoad(view: ChatActionViewProtocol)
    func firstButtonPressed()
    func secondButtonPressed()
}
