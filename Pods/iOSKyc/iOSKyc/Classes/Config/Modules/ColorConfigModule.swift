//
//  ColorConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class ColorConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        for colorJSON in source["value"].arrayValue {
            let name = colorJSON["name"].string!
            
            let factory : (Resolver) -> (ColorProfile) = { _ in
                let colorSource = colorJSON["hex"].string!

                let scanner = Scanner(string: colorSource)
                var value: UInt64 = 0
                scanner.scanHexInt64(&value)
                let color = UIColor(argb: Int(value))
                return ColorProfile(name: name, color: color)
            }
            container.register(ColorProfile.self, name: name, factory: factory).inObjectScope(objectScope)
        }
    }
}
