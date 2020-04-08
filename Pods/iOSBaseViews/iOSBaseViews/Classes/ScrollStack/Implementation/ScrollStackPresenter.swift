//
//  ScrollStackPresenter.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation

public class ScrollStackPresenter : ScrollStackPresenterProtocol {
    
    public var configurator: ScrollStackConfiguratorProtocol
    var interactor : ScrollStackInteractorProtocol!
    var router : ScrollStackRouterProtocol!
    weak var view : ScrollStackViewProtocol?
    
    public init(interactor: ScrollStackInteractorProtocol, router : ScrollStackRouterProtocol, configurator : ScrollStackConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewInited(view: ScrollStackViewProtocol) {
        self.view = view
    }
}
