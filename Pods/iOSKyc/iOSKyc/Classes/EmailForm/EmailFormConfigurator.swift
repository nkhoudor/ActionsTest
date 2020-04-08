//
//  EmailFormConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 29/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject

class EmailFormConfigurator : EmailFormConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    let screenId : String
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: screenId)!
    }()
    
    lazy var labeledTextFieldProfile: LabeledTextFieldProfile = {
        return resolver.resolve(LabeledTextFieldProfile.self, name: "defaultLabeledTextField")!
    }()
    
    init(screenId: String) {
        self.screenId = screenId
    }
    
    var backgroundColor: UIColor = .clear
    
    var titleLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("TITLE")
    }
    
    var subtitleLabelFactory: Factory<UILabel>? {
        return screenProfile.getLabelFactory("SUBTITLE")
    }
    
    var labeledTextFieldFactory: Factory<LabeledTextFieldView> {
        let tf = labeledTextFieldProfile.labeledTextFieldFactory()
        let placeholder = screenProfile.getLocalizedText("PLACEHOLDER")
        let factory : Factory<LabeledTextFieldView> = {
            tf.label.text = placeholder
            return tf
        }
        return factory
    }
    
    var submitButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("SUBMIT")
    }
}
