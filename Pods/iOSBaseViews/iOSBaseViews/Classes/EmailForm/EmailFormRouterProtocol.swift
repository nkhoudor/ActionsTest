//
//  EmailFormRouterProtocol.swift
//
//  Created by Nik, 29/01/2020
//

import Foundation

public protocol EmailFormRouterProtocol {
    var emailProvided : ((String) -> ())? { get }
}
