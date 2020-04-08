//
//  NewDeviceAuthPresenter.swift
//
//  Created by Nik, 8/02/2020
//

import RxSwift

public class NewDeviceAuthPresenter : NewDeviceAuthPresenterProtocol {
    public var configurator: NewDeviceAuthConfiguratorProtocol
    var interactor : NewDeviceAuthInteractorProtocol!
    var router : NewDeviceAuthRouterProtocol!
    weak var view : NewDeviceAuthViewProtocol?
    
    let disposeBag = DisposeBag()
    
    public init(interactor: NewDeviceAuthInteractorProtocol, router : NewDeviceAuthRouterProtocol, configurator : NewDeviceAuthConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: NewDeviceAuthViewProtocol) {
        self.view = view
        interactor.requestSent.observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] _ in
            self?.router.finish?()
        }).disposed(by: disposeBag)
        startUpdateConfirmationButtonTimer()
    }
    
    public func viewDidAppear() {
        interactor.sdkDenied = false
    }
    
    public func viewDidDisappear() {
        interactor.sdkDenied = true
    }
    
    public func confirmPressed() {
        startUpdateConfirmationButtonTimer()
        interactor.confirmAction()
    }
    
    public func denyPressed() {
        interactor.denyAction()
    }
    
    let countDown = 3
    func startUpdateConfirmationButtonTimer() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let button = self?.view?.getConfirmButton() else { return }
            self?.configurator.disableConfirmButtonConfigurationFacory(button)
            button.isUserInteractionEnabled = false
        }
        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
            .take(countDown+1)
            .subscribe(onNext: {[weak self] timePassed in
                guard let countDown = self?.countDown else { return }
                let seconds = countDown - timePassed
                guard let text = self?.configurator.confirmButtonTitle, let button = self?.view?.getConfirmButton() else { return }
                button.setTitle("\(text) (\(seconds))", for: .normal)
            }, onCompleted: {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    guard let text = self?.configurator.confirmButtonTitle, let button = self?.view?.getConfirmButton() else { return }
                    button.setTitle(text, for: .normal)
                    self?.configurator.enableConfirmButtonConfigurationFacory(button)
                    button.isUserInteractionEnabled = true
                }
                
            }).disposed(by: disposeBag)
    }
}
