//
//  ConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class ConfigModule {
    func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        for dependency in source["dependencies"].arrayValue {
            
            let dependencyId = "\(dependency["name"].string!)\(dependency["version"].int!)"
            
            container.resolve(ConfigLibraryItem.self, name: dependencyId)!.register(container: container, objectScope: objectScope)
        }
    }
}
