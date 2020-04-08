//
//  CountryPickerInteractorProtocol.swift
//
//  Created by Nik, 1/02/2020
//

import RxSwift
import RxRelay

public protocol CountryPickerInteractorProtocol {
    var countries : BehaviorRelay<[CountryEntityProtocol]> { get }
    func searchKeywordChanged(_ keyword: String)
    func setCountries(countryCodes: [String])
}
