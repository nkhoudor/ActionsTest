//
//  SelectPickerPresenter.swift
//
//  Created by Nik, 24/02/2020
//

import RxSwift

public class SelectPickerPresenter : SelectPickerPresenterProtocol {
    public var configurator: SelectPickerConfiguratorProtocol
    var interactor : SelectPickerInteractorProtocol!
    var router : SelectPickerRouterProtocol!
    weak var view : SelectPickerViewProtocol?
    
    public init(interactor: SelectPickerInteractorProtocol, router : SelectPickerRouterProtocol, configurator : SelectPickerConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: SelectPickerViewProtocol) {
        self.view = view
    }
    
    public func getValuesObservable() -> Observable<[String]> {
        return interactor!.values.asObservable()
    }
    
    public func valueSelected(_ value: String) {
        router.valueSelected?(value)
    }
}
