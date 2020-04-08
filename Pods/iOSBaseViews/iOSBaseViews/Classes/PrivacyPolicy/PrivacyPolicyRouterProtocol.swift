//
//  PrivacyPolicyRouterProtocol.swift
//
//  Created by Nik, 28/01/2020
//

import Foundation

public protocol PrivacyPolicyRouterProtocol {
    var confirm : (() -> ())? { get }
    var deny : (() -> ())? { get }
}
