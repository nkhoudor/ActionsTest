//
//  MainHolderPresenterProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol MainHolderPresenterProtocol {
    var configurator : MainHolderConfiguratorProtocol { get }
    func viewDidLoad(view: MainHolderViewProtocol)
    func backPressed()
    func closePressed()
}
