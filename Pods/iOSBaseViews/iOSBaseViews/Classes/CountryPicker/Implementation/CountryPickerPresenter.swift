//
//  CountryPickerPresenter.swift
//
//  Created by Nik, 1/02/2020
//

import RxSwift
import RxRelay
import RxCocoa

public class CountryPickerPresenter : CountryPickerPresenterProtocol {
    public var configurator: CountryPickerConfiguratorProtocol
    var interactor : CountryPickerInteractorProtocol!
    var router : CountryPickerRouterProtocol!
    weak var view : CountryPickerViewProtocol?
    
    let disposeBag = DisposeBag()
    
    public init(interactor: CountryPickerInteractorProtocol, router : CountryPickerRouterProtocol, configurator : CountryPickerConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: CountryPickerViewProtocol) {
        self.view = view
    }
    
    public func countrySelected(_ country: CountryEntityProtocol) {
        router.countrySelected?(country)
    }
    
    public func cancelPressed() {
        router.cancelPressed?()
    }
    
    public func getCountriesObservable() -> Observable<[CountryEntityProtocol]> {
        return interactor!.countries.asObservable()
    }
    
    public func searchKeywordChanged(_ keyword: String) {
        interactor.searchKeywordChanged(keyword)
    }
}
