//
//  CountryPickerRouter.swift
//
//  Created by Nik, 1/02/2020
//

import Foundation

public class CountryPickerRouter : CountryPickerRouterProtocol {
    public var countrySelected: ((CountryEntityProtocol) -> ())?
    
    public var cancelPressed: (() -> ())?
    
    public init() {}
}
