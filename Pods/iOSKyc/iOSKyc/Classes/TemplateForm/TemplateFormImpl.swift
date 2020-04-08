//
//  TemplateFormImpl.swift
//  iOSKyc
//
//  Created by Nik on 06/03/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import SwiftyJSON
import iOSKycViews

public class TemplateShortPresentationFormat : TemplateShortPresentationFormatProtocol {
    public static func == (lhs: TemplateShortPresentationFormat, rhs: TemplateShortPresentationFormat) -> Bool {
        return lhs.separator == rhs.separator && lhs.fields == rhs.fields
    }
    
    public var fields: [String]
    
    public var separator: String
    
    init(from source: JSON) {
        fields = source["fields"].arrayValue.map({ $0.stringValue })
        separator = source["separator"].stringValue
    }
    
    
}

public class TemplateFormConfig : TemplateFormConfigProtocol, Equatable {
    
    public var shortPresentationFormat: TemplateShortPresentationFormatProtocol
    public var fields : [FormFieldTemplateProtocol] = []
    
    init(from source: JSON) {
        shortPresentationFormat = TemplateShortPresentationFormat(from: source["shortPresentationFormat"])
        
        for json in source["fields"].arrayValue {
            switch json["type"].stringValue {
            case "input":
                fields.append(InputFormFieldTemplate(from: json))
            case "country_dialog":
                fields.append(CountryPickerFormFieldTemplate(from: json))
            case "select":
                fields.append(SelectFormFieldTemplate(from: json))
            default:
                ()
            }
        }
    }
    
    public func isValid() -> Bool {
        for field in fields {
            if !field.isValid() {
                return false
            }
        }
        return true
    }
    
    public var values : [String : String] {
        var res : [String : String] = [:]
        for field in fields {
            if let val = field.result, !val.isEmpty {
                res[field.name] = val
            }
        }
        return res
    }
    
    public var stringPresentation: String {
        let values = self.values
        
        var res : [String] = []
        
        for fieldName in shortPresentationFormat.fields {
            if let val = values[fieldName] {
                res.append(val)
            }
        }
        
        return res.joined(separator: shortPresentationFormat.separator)
    }
    
    public var name : String {
        return fields.filter({ $0.result != nil && !($0.result!.isEmpty) }).map({ $0.result! }).joined(separator: ", ")
    }
    
    public static func == (lhs: TemplateFormConfig, rhs: TemplateFormConfig) -> Bool {
        return true
    }
    
}


public class FormFieldTemplate : FormFieldTemplateProtocol {
    public let title: String
    public let name: String
    public let isRequired: Bool
    
    public var result: String?

    init(from source: JSON) {
        title = source["title"].stringValue
        name = source["name"].stringValue
        isRequired = source["isRequired"].boolValue
    }
    
    public func isValid(_ value: String?) -> Bool {
        if isRequired {
            return value != nil && !value!.isEmpty
        }
        return true
    }
    
    public func isValid() -> Bool {
        return isValid(result)
    }
}

public class CountryPickerFormFieldTemplate: FormFieldTemplate, CountryPickerFormFieldTemplateProtocol {
    public var maxLength: Int
    
    public var countries: [String]
    
    override init(from source: JSON) {
        countries = source["country_dialog"]["countries"].arrayValue.map({ $0.stringValue })
        maxLength = source["country_dialog"]["maxLength"].intValue
        super.init(from: source)
    }
}

public class SelectFormFieldTemplate : FormFieldTemplate, SelectFormFieldTemplateProtocol {
    public var values: [SelectValueProtocol]
    
    override init(from source: JSON) {
        values = source["select"]["values"].arrayValue.map({ SelectValue(from: $0) })
        super.init(from: source)
    }
}

public class SelectValue: SelectValueProtocol {
    public let value: String
    public let viewValue: String
    
    init(from source: JSON) {
        value = source["value"].stringValue
        viewValue = source["viewValue"].stringValue
    }
}

public class InputFormFieldTemplate: FormFieldTemplate, InputFormFieldTemplateProtocol {
    public let maxLength: Int
    public let charRegex: String
    
    override init(from source: JSON) {
        maxLength = source["input"]["maxLength"].intValue
        charRegex = source["input"]["charRegex"].stringValue
        super.init(from: source)
    }
    
    public override func isValid(_ value: String?) -> Bool {
        if value == nil || value!.isEmpty {
            return !isRequired
        }
        
        return value!.count <= maxLength &&
        value!.matches(charRegex)
    }
    
    public override func isValid() -> Bool {
        return isValid(result)
    }
}

