//
//  OverlayRouter.swift
//
//  Created by Nik, 9/01/2020
//

import Foundation

public class OverlayRouter : OverlayRouterProtocol {
    public init() {}
    public var back : (() -> ())?
    public var close : (() -> ())?
}
