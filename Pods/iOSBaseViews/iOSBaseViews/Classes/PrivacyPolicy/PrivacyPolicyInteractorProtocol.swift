//
//  PrivacyPolicyInteractorProtocol.swift
//
//  Created by Nik, 28/01/2020
//

import Foundation

public protocol PrivacyPolicyInteractorProtocol {
    var setPPConfirmation : ((Bool) -> ())? { get }
}
