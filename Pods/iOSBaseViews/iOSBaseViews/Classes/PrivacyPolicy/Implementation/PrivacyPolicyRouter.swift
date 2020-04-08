//
//  PrivacyPolicyRouter.swift
//
//  Created by Nik, 28/01/2020
//

import Foundation

public class PrivacyPolicyRouter : PrivacyPolicyRouterProtocol {
    public var confirm: (() -> ())?
    
    public var deny: (() -> ())?
    
    public init() {}
    
}
