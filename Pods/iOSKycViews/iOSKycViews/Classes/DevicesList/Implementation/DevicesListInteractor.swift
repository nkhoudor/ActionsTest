//
//  DevicesListInteractor.swift
//
//  Created by Nik, 26/01/2020
//

import RxSwift
import RxRelay

open class DevicesListInteractor : DevicesListInteractorProtocol {
    public var devices: BehaviorRelay<[DeviceEntityProtocol]> = BehaviorRelay(value: [])
    
    public init() {}
    
    open func sendConfirmation() {
        print("SEND PRESSED")
    }
}
