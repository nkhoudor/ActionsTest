//
//  PhoneRegistrationPresenter.swift
//
//  Created by Nik, 1/01/2020
//

import Foundation
import PhoneNumberKit
import RxSwift

public class PhoneRegistrationPresenter : PhoneRegistrationPresenterProtocol {
    public var configurator: PhoneRegistrationConfiguratorProtocol
    var interactor : PhoneRegistrationInteractorProtocol!
    var router : PhoneRegistrationRouterProtocol!
    weak var view : PhoneRegistrationViewProtocol?
    let disposeBag = DisposeBag()
    
    public init(interactor: PhoneRegistrationInteractorProtocol, router : PhoneRegistrationRouterProtocol, configurator : PhoneRegistrationConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
        
        interactor.restrictedCountry.subscribe(onNext: {[weak self] _ in
            self?.router.restrictedCountry()
        }).disposed(by: disposeBag)
        
        router.clearPhone.subscribe(onNext: {[weak self] _ in
            self?.view?.changeState(.normal)
        }).disposed(by: disposeBag)
    }
    
    public func viewDidLoad(view: PhoneRegistrationViewProtocol) {
        self.view = view
    }
    
    public func registerPhone(phone: String) {
        if let phoneNumber = interactor.parsePhone(phone) {
            view?.changeState(.loading)
            interactor.registerPhone(phoneNumber).observeOn(MainScheduler.asyncInstance).subscribe(onNext: { [weak self] result in
                if result {
                    self?.view?.changeState(.success)
                    self?.router.finish()
                } else {
                    self?.view?.changeState(.error)
                }
            }).disposed(by: disposeBag)
        } else {
            view?.changeState(.error)
        }
    }
    
}
