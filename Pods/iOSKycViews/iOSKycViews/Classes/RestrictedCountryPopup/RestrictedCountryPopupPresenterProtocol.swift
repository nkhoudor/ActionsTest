//
//  RestrictedCountryPopupPresenterProtocol.swift
//
//  Created by Nik, 30/01/2020
//

import Foundation

public protocol RestrictedCountryPopupPresenterProtocol {
    var configurator : RestrictedCountryPopupConfiguratorProtocol { get }
    func viewDidLoad(view: RestrictedCountryPopupViewProtocol)
    func changeNumberPressed()
}
