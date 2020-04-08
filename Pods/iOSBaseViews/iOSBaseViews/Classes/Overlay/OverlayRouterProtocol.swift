//
//  OverlayRouterProtocol.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public protocol OverlayRouterProtocol {
    var back : (() -> ())? { get }
    var close : (() -> ())? { get }
}
