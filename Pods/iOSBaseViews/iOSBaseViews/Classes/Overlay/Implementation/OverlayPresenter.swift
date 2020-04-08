//
//  OverlayPresenter.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public class OverlayPresenter : OverlayPresenterProtocol {
    public var configurator: OverlayConfiguratorProtocol
    var interactor : OverlayInteractorProtocol!
    var router : OverlayRouterProtocol!
    weak var view : OverlayViewProtocol?
    
    public init(interactor: OverlayInteractorProtocol, router : OverlayRouterProtocol, configurator : OverlayConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: OverlayViewProtocol) {
        self.view = view
    }
    
    public func backPressed() {
        router.back?()
    }
    
    public func closePressed() {
        router.close?()
    }
}
