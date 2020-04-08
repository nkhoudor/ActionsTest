//
//  TestModuleInteractor.swift
//
//  Created by Nik, 7/01/2020
//

import Foundation

public class TestModuleInteractor : TestModuleInteractorProtocol {
    public var modules : [TestModuleFactory] = []
    
    public init(modules : [TestModuleFactory]) {
        self.modules = modules
    }
}
