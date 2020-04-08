//
//  ScreenConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class ScreenConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        for (screenName, screenJSON) in source["value"].dictionaryValue {
            
            let factory : (Resolver) -> (ScreenProfile) = { resolver in
                
                let localizationProfile = resolver.resolve(ScreenLocalizationProfile.self, name: screenName)
                
                var texts: [String : TextStyleProfile] = [:]
                var buttons: [String : ButtonStyleProfile] = [:]
                var assets: [String : AssetProfile] = [:]
                var lines: [String : LineStyleProfile] = [:]
                
                for element in screenJSON.arrayValue {
                    switch element["type"].string! {
                    case "text":
                        let name = element["name"].string!
                        
                        texts[name] = resolver.resolve(TextStyleProfile.self, name: element["style"].string!)!
                        
                    case "button":
                        let name = element["name"].string!
                        
                        buttons[name] = resolver.resolve(ButtonStyleProfile.self, name: element["style"].string!)!
                        
                    case "line":
                        let name = element["name"].string!
                        
                        lines[name] = resolver.resolve(LineStyleProfile.self, name: element["style"].string!)!
                        
                    case "asset":
                        let name = element["name"].string!
                        
                        assets[name] = resolver.resolve(AssetProfile.self, name: element["id"].string!)!
                    default:
                        ()
                    }
                }
                
                return ScreenProfile(name: screenName, texts: texts, buttons: buttons, assets: assets, lines: lines, localizationProfile: localizationProfile)
            }
            container.register(ScreenProfile.self, name: screenName, factory: factory).inObjectScope(objectScope)
        }
    }
}
