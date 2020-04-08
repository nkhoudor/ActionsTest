//
//  EnterCodePresenter.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation
import RxSwift

public class EnterCodePresenter : EnterCodePresenterProtocol {
    public var configurator: EnterCodeConfiguratorProtocol
    var interactor : EnterCodeInteractorProtocol!
    var router : EnterCodeRouterProtocol!
    weak var view : EnterCodeViewProtocol?
    let disposeBag = DisposeBag()
    var resendCountdownDisposable : Disposable?
    
    public init(interactor: EnterCodeInteractorProtocol, router : EnterCodeRouterProtocol, configurator : EnterCodeConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: EnterCodeViewProtocol) {
        self.view = view
        interactor.resendProhibited
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self] _ in
                self?.router.errorFinish?()
        }).disposed(by: disposeBag)
        
        //view.changeResendState(.allowed)
        startResendTimer()
    }
    
    let countDown = 60
    func startResendTimer() {
        view?.changeResendState(.resend(seconds: countDown))
        resendCountdownDisposable = Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
            .take(countDown+1)
            .subscribe(onNext: {[weak self] timePassed in
                guard let countDown = self?.countDown else { return }
                let seconds = countDown - timePassed
                self?.view?.changeResendState(.resend(seconds: seconds))
            }, onCompleted: {[weak self] in
                self?.view?.changeResendState(.allowed)
            })
    }
    
    public func resendPressed() {
        interactor.resendCode()
        startResendTimer()
        view?.changeState(.clear)
    }
    
    public func codeEntered(_ code: String) {
        view?.changeState(.loading)
        interactor.checkCode(code)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self] result in
            if result {
                self?.view?.changeState(.success)
                self?.router.finish?()
            } else {
                self?.view?.changeState(.error)
                
                Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
                    self?.view?.changeState(.error_description)
                    self?.resendCountdownDisposable?.dispose()
                    self?.view?.changeResendState(.allowed)
                }
            }
        }).disposed(by: disposeBag)
    }
}
