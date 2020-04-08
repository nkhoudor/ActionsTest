//
//  SelectPickerInteractorProtocol.swift
//
//  Created by Nik, 24/02/2020
//

import Foundation
import RxRelay

public protocol SelectPickerInteractorProtocol {
    var values: BehaviorRelay<[String]> { get }
    func setValues(_ values: [String])
}
