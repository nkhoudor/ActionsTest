//
//  CountryPickerPresenterProtocol.swift
//
//  Created by Nik, 1/02/2020
//

import RxSwift

public protocol CountryPickerPresenterProtocol {
    var configurator : CountryPickerConfiguratorProtocol { get }
    func viewDidLoad(view: CountryPickerViewProtocol)
    func countrySelected(_ country: CountryEntityProtocol)
    func cancelPressed()
    func getCountriesObservable() -> Observable<[CountryEntityProtocol]>
    func searchKeywordChanged(_ keyword: String)
}
