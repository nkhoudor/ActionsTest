//
//  LocalizationConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 27/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class LocalizationConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        for (screenName, localizationJSON) in source["value"].dictionaryValue {
            let factory : (Resolver) -> (ScreenLocalizationProfile) = { _ in
                return ScreenLocalizationProfile(name: screenName, localization: localizationJSON.dictionaryValue.mapValues({ $0.stringValue }))
            }
            container.register(ScreenLocalizationProfile.self, name: screenName, factory: factory).inObjectScope(objectScope)
        }
    }
}
