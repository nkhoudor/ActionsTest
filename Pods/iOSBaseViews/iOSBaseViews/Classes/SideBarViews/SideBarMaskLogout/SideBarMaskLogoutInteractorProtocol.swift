//
//  SideBarMaskLogoutInteractorProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation
import RxSwift

public protocol SideBarMaskLogoutInteractorProtocol {
    var maskObservable : Observable<Bool> { get }
    
    ///process logout. Return true to perform navigation
    func logout() -> Observable<Bool>
    func changeMaskState(isOn: Bool)
}
