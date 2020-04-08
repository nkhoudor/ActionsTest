//
//  CountryPickerRouterProtocol.swift
//
//  Created by Nik, 1/02/2020
//

import Foundation

public protocol CountryPickerRouterProtocol {
    var countrySelected : ((CountryEntityProtocol) -> ())? { get }
    var cancelPressed : (() -> ())? { get }
}
