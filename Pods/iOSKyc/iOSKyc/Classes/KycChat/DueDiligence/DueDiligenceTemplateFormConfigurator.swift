//
//  DueDiligenceTemplateFormConfigurator.swift
//  iOSKyc
//
//  Created by Nik on 24/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Swinject
import iOSKycViews

class DueDiligenceTemplateFormConfigurator : TemplateFormConfiguratorProtocol {
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile: ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "DUE_DILIGENCE_FORM")!
    }()
    
    lazy var labeledTextFieldProfile: LabeledTextFieldProfile = {
        return resolver.resolve(LabeledTextFieldProfile.self, name: "defaultLabeledTextField")!
    }()
    
    var selectPickerConfiguratorFactory: Factory<SelectPickerConfiguratorProtocol> = {
        return SelectPickerConfigurator()
    }
    
    var selectPickerInteractorFactory: Factory<SelectPickerInteractorProtocol> = {
        return SelectPickerInteractor()
    }
    
    var countryPickerConfiguratorFactory: Factory<CountryPickerConfiguratorProtocol> = {
        return CountryPickerConfigurator()
    }
    
    var countryPickerInteractorFactory: Factory<CountryPickerInteractorProtocol> = {
        return KYCCountryPickerInteractor()
    }
    
    var halfScreenModalConfigurator: Factory<HalfSceenModalConfiguratorProtocol> = {
        return HalfSceenModalConfigurator()
    }
    
    var selectPickerHalfScreenModalConfigurator: (String) -> HalfSceenModalConfiguratorProtocol = { title in
        return HalfSceenModalConfigurator(titleLabelFactory: UILabel.getFactory(font: UIFont.Theme.boldFont, textColor: UIColor.Theme.mainBlackColor, text: title), titleUnderlineColor: UIColor.Theme.gray10)
    }
    
    var titleLabelFactory: Factory<UILabel> {
        return screenProfile.getLabelFactory("HEADER")
    }
    
    var subtitleLabelFactory: Factory<UILabel>? = nil
    
    var labeledTextFieldFactory: Factory<LabeledTextFieldView> {
        return labeledTextFieldProfile.labeledTextFieldFactory
    }
    
    var submitButtonFactory: Factory<UIButton> {
        return screenProfile.getButtonFactory("SUBMIT")
    }
}
