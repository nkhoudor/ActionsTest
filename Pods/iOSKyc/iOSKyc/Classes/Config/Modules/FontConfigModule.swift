//
//  FontConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class FontConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        for fontJSON in source["value"].arrayValue {
            let name = fontJSON["name"].string!
            
            let factory : (Resolver) -> (FontProfile) = { _ in
                let fontData = try? Data(contentsOf: URL(string: fontJSON["url"].string!)!)
                return FontProfile(name: name, fontData: fontData!)
            }
            
            container.register(FontProfile.self, name: name, factory: factory).inObjectScope(objectScope)
        }
    }
}
