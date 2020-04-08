//
//  ConfigAssembly.swift
//  iOSKyc
//
//  Created by Nik on 20/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject
import SwiftyJSON

extension ObjectScope {
    static let config = ObjectScope(storageFactory: PermanentStorage.init)
}

class ConfigAssembly: Assembly {
    
    func assemble(container: Container) {
                
        let _ = ConfigService(container: container, objectScope: .config)
        
        /*if let url = Bundle.main.url(forResource: "config_address", withExtension: "json") {
            if let configStr = try? String(contentsOf: url) {
                let configJSON = JSON(parseJSON: configStr)
                
                container.register(TemplateFormConfig.self, name: ConfigAssembly.addressForm, factory: { _ in
                    return TemplateFormConfig(from: configJSON["ADDRESS_FORM"])
                })
                
                container.register(TemplateFormConfig.self, name: ConfigAssembly.dueDiligenceForm, factory: { _ in
                    return TemplateFormConfig(from: configJSON["DUE_DILIGENCE_FORM"])
                })
            }
        }*/
    }
    
    static let addressForm = "ADDRESS_FORM"
    static let dueDiligenceForm = "DUE_DILIGENCE_FORM"
}

extension Resolver {
    var addressForm : TemplateFormConfig {
        return resolve(TemplateFormConfig.self, name: ConfigAssembly.addressForm)!
    }
    
    var dueDiligenceForm : TemplateFormConfig {
        return resolve(TemplateFormConfig.self, name: ConfigAssembly.dueDiligenceForm)!
    }
}
