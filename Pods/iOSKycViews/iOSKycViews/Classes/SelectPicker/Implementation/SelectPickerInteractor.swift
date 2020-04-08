//
//  SelectPickerInteractor.swift
//
//  Created by Nik, 24/02/2020
//

import Foundation
import RxRelay

public class SelectPickerInteractor : SelectPickerInteractorProtocol {
    
    public var values: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    public init() {}
    
    public func setValues(_ values: [String]) {
        self.values.accept(values)
    }
}
