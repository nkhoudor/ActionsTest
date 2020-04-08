//
//  HomeAddressFormConfiguratorProtocol.swift
//
//  Created by Nik, 22/01/2020
//

import iOSBaseViews

public protocol HomeAddressFormConfiguratorProtocol {
    var titleLabelFactory : Factory<UILabel> { get }
    var subtitleLabelFactory : Factory<UILabel> { get }
    var labeledTextFieldFactory : Factory<LabeledTextFieldView> { get }
    var submitButtonFactory : Factory<UIButton> { get }
    var countryPickerConfiguratorFactory : Factory<CountryPickerConfiguratorProtocol> { get }
    var countryPickerInteractorFactory : Factory<CountryPickerInteractorProtocol> { get }
    var halfScreenModalConfigurator : Factory<HalfSceenModalConfiguratorProtocol> { get }
}
