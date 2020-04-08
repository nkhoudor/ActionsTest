//
//  CountryPickerInteractor.swift
//
//  Created by Nik, 1/02/2020
//

import RxRelay
import RxSwift

public class CountryPickerInteractor : CountryPickerInteractorProtocol {
    public var countries: BehaviorRelay<[CountryEntityProtocol]> = BehaviorRelay(value: [])
    
    public init() {}
    
    public func searchKeywordChanged(_ keyword: String) {
        
    }
    
    public func setCountries(countryCodes: [String]) {
        
    }
}
