//
//  PhoneRegistrationConfiguratorProtocol.swift
//  iOSKycViews
//
//  Created by Nik on 01/01/2020.
//

import Foundation
import iOSBaseViews

public protocol PhoneRegistrationConfiguratorProtocol {
    var logoImageConfigurationFactory : ConfigurationFactory<UIImageView> { get }
    var phoneNumberLabelFactory : Factory<UILabel> { get }
    var errorLabelFactory : Factory<UILabel> { get }
    var continueButtonFactory : Factory<PrimaryButton> { get }
    var underlineFactory : Factory<UIView> { get }
    var phoneTextFieldFactory : ConfigurationFactory<UITextField> { get }
    var disclaimerFactory : Factory<UITextView> { get }
    var phoneMaxLength : Int { get }
}
