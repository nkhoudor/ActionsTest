//
//  NewDeviceAuthRouterProtocol.swift
//
//  Created by Nik, 8/02/2020
//

import Foundation

public protocol NewDeviceAuthRouterProtocol {
    var finish : (() -> ())? { get }
}
