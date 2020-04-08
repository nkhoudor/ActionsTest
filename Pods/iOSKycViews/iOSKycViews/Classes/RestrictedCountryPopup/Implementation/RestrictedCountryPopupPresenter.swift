//
//  RestrictedCountryPopupPresenter.swift
//
//  Created by Nik, 30/01/2020
//

import Foundation

public class RestrictedCountryPopupPresenter : RestrictedCountryPopupPresenterProtocol {
    public var configurator: RestrictedCountryPopupConfiguratorProtocol
    var interactor : RestrictedCountryPopupInteractorProtocol!
    var router : RestrictedCountryPopupRouterProtocol!
    weak var view : RestrictedCountryPopupViewProtocol?
    
    public init(interactor: RestrictedCountryPopupInteractorProtocol, router : RestrictedCountryPopupRouterProtocol, configurator : RestrictedCountryPopupConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: RestrictedCountryPopupViewProtocol) {
        self.view = view
    }
    
    public func changeNumberPressed() {
        interactor.changeNumber?()
        view?.dismiss()
    }
}
