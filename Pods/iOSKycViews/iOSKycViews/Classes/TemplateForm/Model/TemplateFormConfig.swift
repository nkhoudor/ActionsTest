//
//  TemplateFormConfig.swift
//  iOSKyc
//
//  Created by Nik on 20/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews

public protocol TemplateFormConfigProtocol {
    var fields : [FormFieldTemplateProtocol] { get }
    var shortPresentationFormat : TemplateShortPresentationFormatProtocol { get }
    var stringPresentation : String { get }
}

public protocol TemplateShortPresentationFormatProtocol {
    var fields : [String] { get }
    var separator : String { get }
}

public protocol FormFieldTemplateProtocol : ValidatorProtocol {
    var title: String { get }
    var name: String { get }
    var isRequired: Bool { get }
    var result: String? { get set }
}

public protocol CountryPickerFormFieldTemplateProtocol : FormFieldTemplateProtocol {
    var maxLength: Int { get }
    var countries: [String] { get }
}

public protocol SelectFormFieldTemplateProtocol : FormFieldTemplateProtocol {
    var values: [SelectValueProtocol] { get }
}

public protocol SelectValueProtocol {
    var value: String { get }
    var viewValue: String { get }
}

public protocol InputFormFieldTemplateProtocol: FormFieldTemplateProtocol {
    var maxLength: Int { get }
    var charRegex: String { get }
}

public extension String {
    func matches(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "self MATCHES [c] %@", regex)
        for c in self {
            if !predicate.evaluate(with: "\(c)") {
                return false
            }
        }
        return true
    }
}
