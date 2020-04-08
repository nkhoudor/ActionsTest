//
//  ChatActionPresenter.swift
//
//  Created by Nik, 17/01/2020
//

import Foundation

public class ChatActionPresenter : ChatActionPresenterProtocol {
    public var configurator: ChatActionConfiguratorProtocol
    var interactor : ChatActionInteractorProtocol!
    var router : ChatActionRouterProtocol!
    weak var view : ChatActionViewProtocol?
    
    public init(interactor: ChatActionInteractorProtocol, router : ChatActionRouterProtocol, configurator : ChatActionConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: ChatActionViewProtocol) {
        self.view = view
    }
    
    public func firstButtonPressed() {
        router.firstButton()
    }
    
    public func secondButtonPressed() {
        router.secondButton()
    }
}
