//
//  AddressInfoPresenterProtocol.swift
//
//  Created by Nik, 23/01/2020
//

import iOSBaseViews

public protocol AddressInfoPresenterProtocol {
    var configurator : AddressInfoConfiguratorProtocol { get }
    func viewDidLoad(view: AddressInfoViewProtocol)
    func getAddress() -> TemplateFormConfigProtocol
}
