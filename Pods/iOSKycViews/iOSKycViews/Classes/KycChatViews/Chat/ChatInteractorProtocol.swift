//
//  ChatInteractorProtocol.swift
//
//  Created by Nik, 15/01/2020
//

import Foundation
import RxSwift
import RxRelay

public protocol ChatInteractorProtocol {
    var vcsRelay : BehaviorRelay<[UIViewController]> { get }
    func startChat()
}
