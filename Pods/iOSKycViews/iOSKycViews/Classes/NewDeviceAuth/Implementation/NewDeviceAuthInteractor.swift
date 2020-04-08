//
//  NewDeviceAuthInteractor.swift
//
//  Created by Nik, 8/02/2020
//

import RxSwift

public class NewDeviceAuthInteractor : NewDeviceAuthInteractorProtocol {
    public var requestSent: PublishSubject<Void> = PublishSubject()
    public var sdkDenied : Bool = false
    
    public init() {}
    
    public func confirmAction() {
        
    }
    
    public func denyAction() {
        
    }
}
