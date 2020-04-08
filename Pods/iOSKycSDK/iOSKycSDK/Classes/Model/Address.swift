//
//  Address.swift
//  CoreStore
//
//  Created by Nik on 26/12/2019.
//

import Foundation

public struct Address : Codable {
    public let country : String
    public let city : String
    public let region : String
    public let street : String
    public let streetType : String
    public let buildingNumber : String
    public let apartmentNumber : String
    public let postalCode : String
    
    public init(country : String, city : String, region : String, street : String, streetType : String, buildingNumber : String, apartmentNumber : String, postalCode : String) {
        self.country = country
        self.city = city
        self.region = region
        self.street = street
        self.streetType = streetType
        self.buildingNumber = buildingNumber
        self.apartmentNumber = apartmentNumber
        self.postalCode = postalCode
    }
}
