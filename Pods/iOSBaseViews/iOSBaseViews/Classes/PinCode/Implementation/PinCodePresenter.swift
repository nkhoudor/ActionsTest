//
//  PinCodePresenter.swift
//
//  Created by Nik, 4/01/2020
//

import Foundation
import RxSwift

public class PinCodePresenter : PinCodePresenterProtocol {
    public var configurator: PinCodeConfiguratorProtocol
    var interactor : PinCodeInteractorProtocol!
    var router : PinCodeRouterProtocol!
    weak var view : PinCodeViewProtocol?
    
    let disposeBag = DisposeBag()
    
    public init(interactor: PinCodeInteractorProtocol, router : PinCodeRouterProtocol, configurator : PinCodeConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: PinCodeViewProtocol) {
        self.view = view
    }
    
    public func pinCodeEntered(_ pinCode: String) {
        interactor.checkPinCode(pinCode).observeOn(MainScheduler.asyncInstance).subscribe(onNext: {[weak self] result in
            if result {
                self?.view?.changeState(.success)
                self?.router.finish?()
            } else {
                self?.view?.changeState(.error)
            }
        }).disposed(by: disposeBag)
    }
    
    public func policyPressed() {
        router.showPolicy?()
    }
    
    public func biometricsPressed() {
        router.showBiometrics?()
    }
    
    public func forgotPressed() {
        router.showForgot?()
    }
}
