//
//  DevicesListInteractorProtocol.swift
//
//  Created by Nik, 26/01/2020
//

import RxSwift
import RxRelay

public protocol DevicesListInteractorProtocol {
    var devices : BehaviorRelay<[DeviceEntityProtocol]> { get }
    func sendConfirmation()
}
