//
//  SelectPickerPresenterProtocol.swift
//
//  Created by Nik, 24/02/2020
//

import RxSwift

public protocol SelectPickerPresenterProtocol {
    var configurator : SelectPickerConfiguratorProtocol { get }
    func viewDidLoad(view: SelectPickerViewProtocol)
    func valueSelected(_ value: String)
    func getValuesObservable() -> Observable<[String]>
    
}
