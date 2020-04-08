//
//  HomeAddressFormPresenterProtocol.swift
//
//  Created by Nik, 22/01/2020
//

import Foundation

public protocol HomeAddressFormPresenterProtocol {
    var configurator : HomeAddressFormConfiguratorProtocol { get }
    func viewDidLoad(view: HomeAddressFormViewProtocol)
    func addressReady(address: AddressInfoModel)
}
