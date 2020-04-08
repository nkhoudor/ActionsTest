//
//  CongratulationsPresenterProtocol.swift
//
//  Created by Nik, 23/01/2020
//

import Foundation

public protocol CongratulationsPresenterProtocol {
    var configurator : CongratulationsConfiguratorProtocol { get }
    func viewDidLoad(view: CongratulationsViewProtocol)
    func whatsNextPressed()
}
