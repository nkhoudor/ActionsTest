//
//  HomeAddressFormPresenter.swift
//
//  Created by Nik, 22/01/2020
//

import Foundation

public class HomeAddressFormPresenter : HomeAddressFormPresenterProtocol {
    public var configurator: HomeAddressFormConfiguratorProtocol
    var interactor : HomeAddressFormInteractorProtocol!
    var router : HomeAddressFormRouterProtocol!
    weak var view : HomeAddressFormViewProtocol?
    
    public init(interactor: HomeAddressFormInteractorProtocol, router : HomeAddressFormRouterProtocol, configurator : HomeAddressFormConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: HomeAddressFormViewProtocol) {
        self.view = view
    }
    
    public func addressReady(address: AddressInfoModel) {
        router.addressReady(address: address)
    }
}
