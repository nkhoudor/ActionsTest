//
//  DevicesListPresenter.swift
//
//  Created by Nik, 26/01/2020
//

import Foundation
import RxSwift

public class DevicesListPresenter : DevicesListPresenterProtocol {
    public var configurator: DevicesListConfiguratorProtocol
    var interactor : DevicesListInteractorProtocol!
    var router : DevicesListRouterProtocol!
    weak var view : DevicesListViewProtocol?
    let disposeBag = DisposeBag()
    
    public init(interactor: DevicesListInteractorProtocol, router : DevicesListRouterProtocol, configurator : DevicesListConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: DevicesListViewProtocol) {
        self.view = view
        interactor.devices.subscribe(onNext: {[weak self] devices in
            self?.view?.updateDevices(devices)
        }).disposed(by: disposeBag)
        view.changeResendState(.send)
    }
    
    public func recoverPressed() {
        router.recover?()
    }
    
    public func sendPressed() {
        interactor.sendConfirmation()
        view?.changeResendState(.resend(seconds: countDown))
        startResendTimer()
    }
    
    let countDown = 10
    func startResendTimer() {
        view?.changeResendState(.resend(seconds: countDown))
        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
            .take(countDown+1)
            .subscribe(onNext: {[weak self] timePassed in
                guard let countDown = self?.countDown else { return }
                let seconds = countDown - timePassed
                self?.view?.changeResendState(.resend(seconds: seconds))
            }, onCompleted: {[weak self] in
                self?.view?.changeResendState(.resendAllowed)
            }).disposed(by: disposeBag)
    }
}
