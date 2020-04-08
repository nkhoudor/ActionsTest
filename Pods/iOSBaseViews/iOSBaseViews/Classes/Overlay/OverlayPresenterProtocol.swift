//
//  OverlayPresenterProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol OverlayPresenterProtocol {
    var configurator : OverlayConfiguratorProtocol { get }
    func viewDidLoad(view: OverlayViewProtocol)
    func backPressed()
    func closePressed()
}
