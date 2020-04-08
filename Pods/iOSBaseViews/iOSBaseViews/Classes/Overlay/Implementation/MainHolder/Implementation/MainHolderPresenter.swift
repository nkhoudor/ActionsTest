//
//  MainHolderPresenter.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public class MainHolderPresenter : MainHolderPresenterProtocol {
    public var configurator: MainHolderConfiguratorProtocol
    var interactor : MainHolderInteractorProtocol!
    var router : MainHolderRouterProtocol!
    weak var view : MainHolderViewProtocol?
    
    public init(interactor: MainHolderInteractorProtocol, router : MainHolderRouterProtocol, configurator : MainHolderConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: MainHolderViewProtocol) {
        self.view = view
    }
    
    public func backPressed() {
        router.back?()
    }
    
    public func closePressed() {
        router.close?()
    }
}
