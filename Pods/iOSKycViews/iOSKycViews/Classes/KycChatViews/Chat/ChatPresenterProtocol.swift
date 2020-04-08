//
//  ChatPresenterProtocol.swift
//
//  Created by Nik, 15/01/2020
//

import Foundation

public protocol ChatPresenterProtocol {
    var configurator : ChatConfiguratorProtocol { get }
    func viewDidLoad(view: ChatViewProtocol)
    
}
