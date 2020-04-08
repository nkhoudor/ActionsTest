//
//  EmailFormViewProtocol.swift
//
//  Created by Nik, 29/01/2020
//

import Foundation

public enum EmailFormViewState {
    case normal
    case loading
}

public protocol EmailFormViewProtocol : class {
    func changeState(_ state: EmailFormViewState)
}
