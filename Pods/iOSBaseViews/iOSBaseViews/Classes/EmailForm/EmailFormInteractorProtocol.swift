//
//  EmailFormInteractorProtocol.swift
//
//  Created by Nik, 29/01/2020
//

import RxSwift

public protocol EmailFormInteractorProtocol {
    func emailProvided(_ email: String) -> Observable<Bool>
}
