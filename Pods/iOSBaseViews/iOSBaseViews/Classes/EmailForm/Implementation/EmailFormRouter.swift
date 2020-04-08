//
//  EmailFormRouter.swift
//
//  Created by Nik, 29/01/2020
//

import Foundation

public class EmailFormRouter : EmailFormRouterProtocol {
    public init() {}
    public var emailProvided: ((String) -> ())?
}
