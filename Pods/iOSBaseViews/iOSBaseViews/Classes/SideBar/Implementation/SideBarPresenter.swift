//
//  SideBarPresenter.swift
//
//  Created by Nik, 8/01/2020
//

import Foundation

public class SideBarPresenter : SideBarPresenterProtocol {
    public var configurator: SideBarConfiguratorProtocol
    var interactor : SideBarInteractorProtocol!
    var router : SideBarRouterProtocol!
    weak var view : SideBarViewProtocol?
    
    public init(interactor: SideBarInteractorProtocol, router : SideBarRouterProtocol, configurator : SideBarConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: SideBarViewProtocol) {
        self.view = view
    }
}
