//
//  SideBarActionsSetPresenter.swift
//
//  Created by Nik, 8/01/2020
//

import Foundation

public class SideBarActionsSetPresenter : SideBarActionsSetPresenterProtocol {
    public var configurator: SideBarActionsSetConfiguratorProtocol
    var interactor : SideBarActionsSetInteractorProtocol!
    var router : SideBarActionsSetRouterProtocol!
    weak var view : SideBarActionsSetViewProtocol?
    
    public init(interactor: SideBarActionsSetInteractorProtocol, router : SideBarActionsSetRouterProtocol, configurator : SideBarActionsSetConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: SideBarActionsSetViewProtocol) {
        self.view = view
    }
}
