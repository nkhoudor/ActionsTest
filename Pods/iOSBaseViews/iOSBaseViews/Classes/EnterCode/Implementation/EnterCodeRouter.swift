//
//  EnterCodeRouter.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation

public class EnterCodeRouter : EnterCodeRouterProtocol {
    public init() {}
    public var finish : (() -> ())?
    public var errorFinish : (() -> ())?
}
