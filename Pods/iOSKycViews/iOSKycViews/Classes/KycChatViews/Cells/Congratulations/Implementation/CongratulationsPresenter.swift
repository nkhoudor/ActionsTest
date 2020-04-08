//
//  CongratulationsPresenter.swift
//
//  Created by Nik, 23/01/2020
//

import Foundation

public class CongratulationsPresenter : CongratulationsPresenterProtocol {
    public var configurator: CongratulationsConfiguratorProtocol
    var interactor : CongratulationsInteractorProtocol!
    var router : CongratulationsRouterProtocol!
    weak var view : CongratulationsViewProtocol?
    
    public init(interactor: CongratulationsInteractorProtocol, router : CongratulationsRouterProtocol, configurator : CongratulationsConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: CongratulationsViewProtocol) {
        self.view = view
    }
    
    public func whatsNextPressed() {
        interactor.whatsNext()
    }
}
