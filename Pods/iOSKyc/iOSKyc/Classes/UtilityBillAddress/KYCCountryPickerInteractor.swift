//
//  KYCCountryPickerInteractor.swift
//  iOSKyc
//
//  Created by Nik on 02/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import RxSwift
import RxRelay
import iOSBaseViews
import iOSKycSDK
import Swinject

class KYCCountryPickerInteractor : CountryPickerInteractorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var flowService: IFlowService = {
        return resolver.resolve(IFlowService.self)!
    }()
    
    let disposeBag = DisposeBag()
    
    init() {
        flowService.state.subscribe(onNext: {[weak self] state in
            switch state {
            case .COUNTRIES_REQUEST_RESULT(let res):
                switch res {
                case .success(_, let countries):
                    let _countries = countries.map({ Country(name: $0.common, countryCode: $0.cca2) }).sorted(by: { $0.name < $1.name })
                    self?.initialData = _countries
                    self?.countries.accept(_countries)
                default:
                    ()
                }
            default:
                ()
            }
        }).disposed(by: disposeBag)
        flowService.getCountries(uuid: flowService.generateFlowId())
    }
    
    var countries: BehaviorRelay<[CountryEntityProtocol]> = BehaviorRelay(value: [])
    
    private var initialData : [Country] = []
    
    public func setCountries(countryCodes: [String]) {
        //initialData = countryCodes.map({ Country(name: $0.countryName ?? "", countryCode: $0) }).sorted(by: { $0.name < $1.name })
        //countries.accept(initialData)
    }
    
    func searchKeywordChanged(_ keyword: String) {
        if keyword.isEmpty {
            countries.accept(initialData.sorted(by: { $0.name < $1.name }))
        } else {
            countries.accept(initialData.filter({ $0.name.lowercased().contains(keyword.lowercased()) }).sorted(by: { $0.name < $1.name }))
        }        
    }
}

extension String {
    var countryName : String? {
        let current = Locale.current //Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: self)
    }
}

class Country : CountryEntityProtocol {
    var name: String
    var countryCode: String
    
    
    init(name: String, countryCode: String) {
        self.name = name
        self.countryCode = countryCode
    }
}
