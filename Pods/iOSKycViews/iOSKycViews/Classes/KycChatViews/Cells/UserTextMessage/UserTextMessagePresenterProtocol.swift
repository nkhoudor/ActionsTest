//
//  UserTextMessagePresenterProtocol.swift
//
//  Created by Nik, 17/01/2020
//

import Foundation

public protocol UserTextMessagePresenterProtocol {
    var configurator : UserTextMessageConfiguratorProtocol { get }
    func viewDidLoad(view: UserTextMessageViewProtocol)
    
}
