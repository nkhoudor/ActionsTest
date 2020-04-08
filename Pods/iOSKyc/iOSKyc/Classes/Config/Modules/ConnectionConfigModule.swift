//
//  ConnectionConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class ConnectionConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        
        let factory : (Resolver) -> (ConnectionProfile) = { _ in
           let data = try! source["value"].rawData()
            return try! JSONDecoder().decode(ConnectionProfile.self, from: data)
        }
        
        container.register(ConnectionProfile.self, factory: factory).inObjectScope(objectScope)
    }
}
