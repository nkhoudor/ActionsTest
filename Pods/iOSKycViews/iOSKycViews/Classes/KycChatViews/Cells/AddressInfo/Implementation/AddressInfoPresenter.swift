//
//  AddressInfoPresenter.swift
//
//  Created by Nik, 23/01/2020
//

import iOSBaseViews

public class AddressInfoPresenter : AddressInfoPresenterProtocol {
    public var configurator: AddressInfoConfiguratorProtocol
    var interactor : AddressInfoInteractorProtocol!
    var router : AddressInfoRouterProtocol!
    weak var view : AddressInfoViewProtocol?
    
    public init(interactor: AddressInfoInteractorProtocol, router : AddressInfoRouterProtocol, configurator : AddressInfoConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: AddressInfoViewProtocol) {
        self.view = view
    }
    
    public func getAddress() -> TemplateFormConfigProtocol {
        return interactor.addressInfoMessage.form
    }
}
