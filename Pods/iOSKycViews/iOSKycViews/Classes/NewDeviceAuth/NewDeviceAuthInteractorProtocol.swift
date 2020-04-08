//
//  NewDeviceAuthInteractorProtocol.swift
//
//  Created by Nik, 8/02/2020
//

import RxSwift

public protocol NewDeviceAuthInteractorProtocol {
    var requestSent : PublishSubject<Void> { get }
    var sdkDenied : Bool { get set }
    func confirmAction()
    func denyAction()
}
