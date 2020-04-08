//
//  MainHolderRouterProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol MainHolderRouterProtocol {
    var back : (() -> ())? { get }
    var close : (() -> ())? { get }
}
