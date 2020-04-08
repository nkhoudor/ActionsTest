//
//  AssetConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject
import Kingfisher

class AssetConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        for assetJSON in source["value"].arrayValue {
            let name = assetJSON["id"].string!
            
            let factory : (Resolver) -> (AssetProfile) = { _ in
                AssetProfile(id: name, x2: assetJSON["2x"].string!, x3: assetJSON["3x"].string!)
            }
            container.register(AssetProfile.self, name: name, factory: factory).inObjectScope(objectScope)
        }
        
        var urls : [URL] = []
        
        switch UIScreen.main.scale {
        case 2.0:
            urls = source["value"].arrayValue.map({ URL(string: $0["2x"].string!)! })
        case 3.0:
            urls = source["value"].arrayValue.map({ URL(string: $0["3x"].string!)! })
        default:
            ()
        }
        ImagePrefetcher(urls: urls, options: [.scaleFactor(UIScreen.main.scale)]).start()
    }
}
