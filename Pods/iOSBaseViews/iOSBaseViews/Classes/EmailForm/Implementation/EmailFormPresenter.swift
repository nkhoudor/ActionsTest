//
//  EmailFormPresenter.swift
//
//  Created by Nik, 29/01/2020
//

import RxSwift

public class EmailFormPresenter : EmailFormPresenterProtocol {
    public var configurator: EmailFormConfiguratorProtocol
    var interactor : EmailFormInteractorProtocol!
    var router : EmailFormRouterProtocol!
    weak var view : EmailFormViewProtocol?
    
    let disposeBag = DisposeBag()
    
    private var disposable: Disposable?
    
    public init(interactor: EmailFormInteractorProtocol, router : EmailFormRouterProtocol, configurator : EmailFormConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: EmailFormViewProtocol) {
        self.view = view
    }
    
    public func submitPressed(_ email: String) {
        view?.changeState(.loading)
        disposable = interactor.emailProvided(email).observeOn(MainScheduler.asyncInstance).subscribe(onNext: { [weak self] result in
            self?.view?.changeState(.normal)
            if result {
                self?.router.emailProvided?(email)
            }
            self?.disposable?.dispose()
        })
    }
}
