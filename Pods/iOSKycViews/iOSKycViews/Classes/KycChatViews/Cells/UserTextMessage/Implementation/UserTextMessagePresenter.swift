//
//  UserTextMessagePresenter.swift
//
//  Created by Nik, 17/01/2020
//

import Foundation
import RxSwift

public class UserTextMessagePresenter : UserTextMessagePresenterProtocol {
    public var configurator: UserTextMessageConfiguratorProtocol
    var interactor : UserTextMessageInteractorProtocol!
    var router : UserTextMessageRouterProtocol!
    weak var view : UserTextMessageViewProtocol?
    
    let disposeBag = DisposeBag()
    
    public init(interactor: UserTextMessageInteractorProtocol, router : UserTextMessageRouterProtocol, configurator : UserTextMessageConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: UserTextMessageViewProtocol) {
        self.view = view
        interactor.userTextMessage.text.subscribe(onNext: {[weak self] text in
            self?.view?.update(text: text)
        }).disposed(by: disposeBag)
        
    }
}
