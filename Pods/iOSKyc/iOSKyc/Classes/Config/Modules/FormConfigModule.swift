//
//  FormConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class FormConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        for (formName, formJSON) in source["value"].dictionaryValue {
            container.register(TemplateFormConfig.self, name: formName, factory: { _ in
                return TemplateFormConfig(from: formJSON)
            }).inObjectScope(objectScope)
        }
    }
}
