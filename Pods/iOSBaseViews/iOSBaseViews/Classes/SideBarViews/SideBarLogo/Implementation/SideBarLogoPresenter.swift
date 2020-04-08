//
//  SideBarLogoPresenter.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public class SideBarLogoPresenter : SideBarLogoPresenterProtocol {
    public var configurator: SideBarLogoConfiguratorProtocol
    var interactor : SideBarLogoInteractorProtocol!
    var router : SideBarLogoRouterProtocol!
    weak var view : SideBarLogoViewProtocol?
    
    public init(interactor: SideBarLogoInteractorProtocol, router : SideBarLogoRouterProtocol, configurator : SideBarLogoConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: SideBarLogoViewProtocol) {
        self.view = view
    }
}
