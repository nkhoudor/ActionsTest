//
//  ChatStyleConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 01/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class ChatStyleConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        for styleJSON in source["value"].arrayValue {
            print("STYLE\(styleJSON["type"].string!)")
            switch styleJSON["type"].string! {
                
            case "botTextMessage":
                let name = styleJSON["name"].string!
                container.register(BotTextMessageProfile.self, name: name, factory: { resolver -> BotTextMessageProfile in
                    return BotTextMessageProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
            
            case "userTextMessage":
                let name = styleJSON["name"].string!
                container.register(UserTextMessageProfile.self, name: name, factory: { resolver -> UserTextMessageProfile in
                    return UserTextMessageProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
                
            case "userPhotoMessage":
                let name = styleJSON["name"].string!
                container.register(UserPhotoMessageProfile.self, name: name, factory: { resolver -> UserPhotoMessageProfile in
                    return UserPhotoMessageProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
                
            case "botLoadingMessage":
                let name = styleJSON["name"].string!
                container.register(BotLoadingMessageProfile.self, name: name, factory: { resolver -> BotLoadingMessageProfile in
                    return BotLoadingMessageProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
                
            case "site":
                let name = styleJSON["name"].string!
                container.register(SiteProfile.self, name: name, factory: { resolver -> SiteProfile in
                    return SiteProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
            default:
                ()
            }
            
        }
    }
}
