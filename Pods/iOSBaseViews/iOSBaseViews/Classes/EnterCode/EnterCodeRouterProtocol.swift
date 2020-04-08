//
//  EnterCodeRouterProtocol.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation

public protocol EnterCodeRouterProtocol {
    var finish : (() -> ())? { get }
    var errorFinish : (() -> ())? { get }
}
