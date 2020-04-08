//
//  ChatPresenter.swift
//
//  Created by Nik, 15/01/2020
//

import Foundation
import RxSwift

public class ChatPresenter : ChatPresenterProtocol {
    public var configurator: ChatConfiguratorProtocol
    var interactor : ChatInteractorProtocol!
    var router : ChatRouterProtocol!
    weak var view : ChatViewProtocol?
    
    let disposeBag = DisposeBag()
    
    public init(interactor: ChatInteractorProtocol, router : ChatRouterProtocol, configurator : ChatConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: ChatViewProtocol) {
        self.view = view
        interactor.vcsRelay.subscribe(onNext: {[weak self] vcs in
            self?.view?.setupVCs(vcs)
        }).disposed(by: disposeBag)
        interactor.startChat()
    }
}
