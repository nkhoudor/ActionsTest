//
//  TemplateFormConfiguratorProtocol.swift
//
//  Created by Nik, 20/02/2020
//

import iOSBaseViews

public protocol TemplateFormConfiguratorProtocol {
    var titleLabelFactory : Factory<UILabel> { get }
    var subtitleLabelFactory : Factory<UILabel>? { get }
    var labeledTextFieldFactory : Factory<LabeledTextFieldView> { get }
    var submitButtonFactory : Factory<UIButton> { get }
    var countryPickerConfiguratorFactory : Factory<CountryPickerConfiguratorProtocol> { get }
    var countryPickerInteractorFactory : Factory<CountryPickerInteractorProtocol> { get }
    
    var selectPickerConfiguratorFactory : Factory<SelectPickerConfiguratorProtocol> { get }
    var selectPickerInteractorFactory : Factory<SelectPickerInteractorProtocol> { get }
    
    var halfScreenModalConfigurator : Factory<HalfSceenModalConfiguratorProtocol> { get }
    var selectPickerHalfScreenModalConfigurator: (String) -> HalfSceenModalConfiguratorProtocol { get }
}
