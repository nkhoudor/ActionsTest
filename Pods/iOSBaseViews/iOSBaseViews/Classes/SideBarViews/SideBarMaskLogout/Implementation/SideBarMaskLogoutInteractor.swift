//
//  SideBarMaskLogoutInteractor.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation
import RxSwift

public class SideBarMaskLogoutInteractor : SideBarMaskLogoutInteractorProtocol {
    public init() {}
    
    public var maskObservable : Observable<Bool> {
        return Observable.create { observer in
            observer.onNext(true)
            return Disposables.create {}
        }
    }
    
    ///process logout. Return true to perform navigation
    public func logout() -> Observable<Bool> {
        return Observable.create { observer in
            observer.onNext(false)
            return Disposables.create {}
        }
    }
    
    public func changeMaskState(isOn: Bool) {}
}
