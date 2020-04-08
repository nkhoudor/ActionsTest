//
//  BotLoadingMessagePresenter.swift
//
//  Created by Nik, 21/01/2020
//

import Foundation
import RxSwift

public class BotLoadingMessagePresenter : BotLoadingMessagePresenterProtocol {
    public var configurator: BotLoadingMessageConfiguratorProtocol
    var interactor : BotLoadingMessageInteractorProtocol!
    var router : BotLoadingMessageRouterProtocol!
    weak var view : BotLoadingMessageViewProtocol?
    
    let disposeBag = DisposeBag()
    
    public init(interactor: BotLoadingMessageInteractorProtocol, router : BotLoadingMessageRouterProtocol, configurator : BotLoadingMessageConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: BotLoadingMessageViewProtocol) {
        self.view = view
        interactor.botLoadingMessage.avatarVisible.subscribe(onNext: {[weak self] avatarVisible in
            self?.view?.update(avatarVisible: avatarVisible)
        }).disposed(by: disposeBag)
    }
}
