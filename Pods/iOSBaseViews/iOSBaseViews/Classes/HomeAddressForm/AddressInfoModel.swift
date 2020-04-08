//
//  AddressInfoModel.swift
//  iOSKyc
//
//  Created by Nik on 23/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

public class AddressField {
    public let name : String
    public let value : String
    
    public init(name : String, value: String) {
        self.name = name
        self.value = value
    }
}

open class AddressInfoModel {
    public let values : [AddressField]
    
    public init(values : [AddressField]) {
        self.values = values
    }
    
    public var name : String {
        let street = values.first(where: { $0.name == "Street" })?.value ?? ""
        let house = values.first(where: { $0.name == "House number" })?.value ?? ""
        let postalCode = values.first(where: { $0.name == "Postal code" })?.value ?? ""
        return "\(street) \(house), \(postalCode)"
    }
    
    public func value(for field: String) -> String? {
        return values.first(where: { $0.name == field })?.value
    }
}
