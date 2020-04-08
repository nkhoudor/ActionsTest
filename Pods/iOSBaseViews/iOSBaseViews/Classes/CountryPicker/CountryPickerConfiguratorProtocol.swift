//
//  CountryPickerConfiguratorProtocol.swift
//
//  Created by Nik, 1/02/2020
//

public protocol CountryPickerConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var textFieldFactory : Factory<UITextField> { get }
    var textFieldMaxLength : Int { get set }
    var underlineColor : UIColor { get }
    var cancelButtonFactory : Factory<UIButton> { get }
    var serviceUnavailableLabelFactory : Factory<UILabel> { get }
    var countryNameLabelConfigurationFactory : ConfigurationFactory<UILabel> { get }
}
