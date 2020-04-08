//
//  TestModulePresenter.swift
//
//  Created by Nik, 7/01/2020
//

import Foundation

public class TestModulePresenter : TestModulePresenterProtocol {
    public var configurator: TestModuleConfiguratorProtocol
    var interactor : TestModuleInteractorProtocol!
    var router : TestModuleRouterProtocol!
    weak var view : TestModuleViewProtocol?
    
    public init(interactor: TestModuleInteractorProtocol, router : TestModuleRouterProtocol, configurator : TestModuleConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: TestModuleViewProtocol) {
        self.view = view
        view.setupModules(interactor.modules)
    }
}
