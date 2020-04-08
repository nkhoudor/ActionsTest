//
//  FormStyleConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 02/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class FormStyleConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        for styleJSON in source["value"].arrayValue {
            print("STYLE\(styleJSON["type"].string!)")
            switch styleJSON["type"].string! {
                
            case "labeledTextField":
                let name = styleJSON["name"].string!
                container.register(LabeledTextFieldProfile.self, name: name, factory: { resolver -> LabeledTextFieldProfile in
                    return LabeledTextFieldProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
            
            
            default:
                ()
            }
            
        }
    }
}
