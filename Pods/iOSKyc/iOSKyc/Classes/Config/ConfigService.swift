//
//  ConfigService.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import RxSwift
import RxRelay
import SwiftyJSON
import Swinject

protocol IConfigService {
    var configReady : BehaviorRelay<Bool> { get }
}

class ConfigLibraryItem {
    let name: String
    let version: Int
    let url: String
    
    var isRegistered: Bool = false
    
    init(name: String, version: Int, url: String) {
        self.name = name
        self.version = version
        self.url = url
    }
    
    func register(container: Container, objectScope: ObjectScope) {
        guard !isRegistered else { return }
        isRegistered = true
        if let configStr = try? String(contentsOf: URL(string: url)!) {
            let configJSON = JSON(parseJSON: configStr)
            var configModules: [ConfigModule] = []
            switch configJSON["type"].string! {
            case "screen":
                configModules.append(ScreenConfigModule())
            case "style":
                configModules.append(StyleConfigModule())
                configModules.append(ChatStyleConfigModule())
                configModules.append(FormStyleConfigModule())
            case "color":
                configModules.append(ColorConfigModule())
            case "font":
                configModules.append(FontConfigModule())
            case "connection":
                configModules.append(ConnectionConfigModule())
            case "form":
                configModules.append(FormConfigModule())
            case "asset":
                configModules.append(AssetConfigModule())
            case "string":
                configModules.append(LocalizationConfigModule())
            default:
                ()
            }
            for configModule in configModules {
                configModule.register(from: configJSON, container: container, objectScope: objectScope)
            }            
        }
    }
}

class ConfigService : IConfigService {
    var configReady: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    init(container: Container, objectScope: ObjectScope) {
        if let configStr = try? String(contentsOf: URL(string: "https://ios-test-assets.s3.eu-central-1.amazonaws.com/dev/ios/kyc/1.0.0/config.json")!) {
            let configJSON = JSON(parseJSON: configStr)
            for libraryItemJSON in configJSON["configs_library"].arrayValue {
                for versionJSON in libraryItemJSON["versions"].arrayValue {
                    
                    let factory : (Resolver) -> (ConfigLibraryItem) = {_ in
                         return ConfigLibraryItem(name: libraryItemJSON["name"].string!, version: versionJSON["version"].int!, url: versionJSON["url"].string!)
                    }
                    container.register(ConfigLibraryItem.self, name: "\(libraryItemJSON["name"].string!)\(versionJSON["version"].int!)", factory: factory).inObjectScope(objectScope)
                }
            }
            
            
            let activeProfileName = configJSON["active_profile"]["name"].string!
            let activeProfileVersion = configJSON["active_profile"]["version"].int!
            for profile in configJSON["profiles"].arrayValue {
                let profileName = profile["name"].string!
                let profileVersion = profile["version"].int!
                guard profileName == activeProfileName, profileVersion == activeProfileVersion else { continue }
                
                for configJSON in profile["configs"].arrayValue {
                    let configName = "\(configJSON["name"].string!)\(configJSON["version"].int!)"
                    
                    container.resolve(ConfigLibraryItem.self, name: configName)!.register(container: container, objectScope: objectScope)
                }
            }
        }
    }
}
