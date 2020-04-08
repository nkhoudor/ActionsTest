//
//  ErrorWarningInfoPresenter.swift
//
//  Created by Nik, 11/02/2020
//

import Foundation

public class ErrorWarningInfoPresenter : ErrorWarningInfoPresenterProtocol {
    public var configurator: ErrorWarningInfoConfiguratorProtocol
    var interactor : ErrorWarningInfoInteractorProtocol!
    var router : ErrorWarningInfoRouterProtocol!
    weak var view : ErrorWarningInfoViewProtocol?
    
    public init(interactor: ErrorWarningInfoInteractorProtocol, router : ErrorWarningInfoRouterProtocol, configurator : ErrorWarningInfoConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: ErrorWarningInfoViewProtocol) {
        self.view = view
    }
}
