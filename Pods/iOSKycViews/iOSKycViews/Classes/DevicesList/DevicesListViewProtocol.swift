//
//  DevicesListViewProtocol.swift
//
//  Created by Nik, 26/01/2020
//

import Foundation

public enum AuthResendState {
    case send
    case resend(seconds: Int)
    case resendAllowed
}

public protocol DevicesListViewProtocol : class {
    func changeResendState(_ state: AuthResendState)
    func updateDevices(_ devices: [DeviceEntityProtocol])
}
