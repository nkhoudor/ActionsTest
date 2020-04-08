//
//  SideBarMaskLogoutPresenter.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation
import RxSwift

public class SideBarMaskLogoutPresenter : SideBarMaskLogoutPresenterProtocol {
    public var configurator: SideBarMaskLogoutConfiguratorProtocol
    var interactor : SideBarMaskLogoutInteractorProtocol!
    var router : SideBarMaskLogoutRouterProtocol!
    weak var view : SideBarMaskLogoutViewProtocol?
    let disposeBag = DisposeBag()
    
    public init(interactor: SideBarMaskLogoutInteractorProtocol, router : SideBarMaskLogoutRouterProtocol, configurator : SideBarMaskLogoutConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: SideBarMaskLogoutViewProtocol) {
        self.view = view
        interactor.maskObservable.subscribe(onNext: {[weak self] isOn in
            self?.view?.changeMaskSwitchState(isOn: isOn)
        }).disposed(by: disposeBag)
    }
    
    public func logoutPressed() {
        interactor.logout().subscribe(onNext: {[weak self] result in
            if result {
                self?.router.logout()
            }
        }).disposed(by: disposeBag)
    }
    
    public func maskSwitchChanged(isOn: Bool) {
        interactor.changeMaskState(isOn: isOn)
    }
}
