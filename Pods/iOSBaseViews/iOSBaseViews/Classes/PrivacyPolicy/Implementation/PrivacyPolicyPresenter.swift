//
//  PrivacyPolicyPresenter.swift
//
//  Created by Nik, 28/01/2020
//

import Foundation

public class PrivacyPolicyPresenter : PrivacyPolicyPresenterProtocol {
    public var configurator: PrivacyPolicyConfiguratorProtocol
    var interactor : PrivacyPolicyInteractorProtocol!
    var router : PrivacyPolicyRouterProtocol!
    weak var view : PrivacyPolicyViewProtocol?
    
    public init(interactor: PrivacyPolicyInteractorProtocol, router : PrivacyPolicyRouterProtocol, configurator : PrivacyPolicyConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: PrivacyPolicyViewProtocol) {
        self.view = view
    }
    
    public func confirmPressed() {
        interactor.setPPConfirmation?(true)
        router.confirm?()
    }
    
    public func denyPressed() {
        interactor.setPPConfirmation?(false)
        router.deny?()
    }
}
