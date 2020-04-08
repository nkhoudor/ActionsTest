//
//  SideBarSupportPresenter.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public class SideBarSupportPresenter : SideBarSupportPresenterProtocol {
    public var configurator: SideBarSupportConfiguratorProtocol
    var interactor : SideBarSupportInteractorProtocol!
    var router : SideBarSupportRouterProtocol!
    weak var view : SideBarSupportViewProtocol?
    
    public init(interactor: SideBarSupportInteractorProtocol, router : SideBarSupportRouterProtocol, configurator : SideBarSupportConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: SideBarSupportViewProtocol) {
        self.view = view
    }
    
    public func supportPressed() {
        router.support()
    }
}
