//
//  TemplateFormPresenter.swift
//
//  Created by Nik, 20/02/2020
//

import Foundation

public class TemplateFormPresenter : TemplateFormPresenterProtocol {
    public var configurator: TemplateFormConfiguratorProtocol
    var interactor : TemplateFormInteractorProtocol!
    var router : TemplateFormRouterProtocol!
    weak var view : TemplateFormViewProtocol?
    
    public init(interactor: TemplateFormInteractorProtocol, router : TemplateFormRouterProtocol, configurator : TemplateFormConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: TemplateFormViewProtocol) {
        self.view = view
    }
    
    public func getConfig() -> TemplateFormConfigProtocol {
        return interactor.config
    }
    
    public func submitPressed() {
        router.finish(config: interactor.config)
    }
}
