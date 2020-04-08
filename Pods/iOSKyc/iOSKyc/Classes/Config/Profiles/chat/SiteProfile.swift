//
//  SiteProfile.swift
//  iOSKyc
//
//  Created by Nik on 03/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class SiteProfile {
    let name: String
    let url: String
    
    init(from source: JSON, resolver: Resolver) {
        self.name = source["name"].string!
        self.url = source["url"].string!
    }
}



