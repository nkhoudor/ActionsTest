//
//  PrivacyPolicyPresenterProtocol.swift
//
//  Created by Nik, 28/01/2020
//

import Foundation

public protocol PrivacyPolicyPresenterProtocol {
    var configurator : PrivacyPolicyConfiguratorProtocol { get }
    func viewDidLoad(view: PrivacyPolicyViewProtocol)
    func confirmPressed()
    func denyPressed()
}
